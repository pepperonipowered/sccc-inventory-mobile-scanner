// import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sccc_v3/feat/scanner/presentation/widgets/buttons/analyze_image_button.dart';
// import 'package:sccc_v3/feat/scanner/presentation/widgets/buttons/pause_button.dart';
import 'package:sccc_v3/feat/scanner/presentation/widgets/buttons/start_stop_button.dart';
import 'package:sccc_v3/feat/scanner/presentation/widgets/buttons/switch_camera_button.dart';
import 'package:sccc_v3/feat/scanner/presentation/widgets/buttons/toggle_flashlight_button.dart';
import 'package:sccc_v3/feat/scanner/presentation/widgets/supply_bottom_sheet.dart';
import 'package:sccc_v3/feat/scanner/presentation/widgets/equipment_bottom_sheet.dart';
import 'package:sccc_v3/feat/scanner/presentation/widgets/scanner_error_widget.dart';
import 'package:sccc_v3/feat/scanner/presentation/widgets/zoom_scale_slider_widget.dart';
import 'package:sccc_v3/service_locator.dart';

/// Implementation of Mobile Scanner example with advanced configuration
class ScannerPage extends StatefulWidget {
  /// Constructor for advanced Mobile Scanner example
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  bool _isBottomSheetVisible = false;

  // Cannot be changed while the scanner is running.
  static const useScanWindow = true;

  late MobileScannerController controller = initController();

  bool autoZoom = false;
  bool invertImage = false;
  bool returnImage = false;

  Size desiredCameraResolution = const Size(1920, 1080);
  DetectionSpeed detectionSpeed = DetectionSpeed.normal;
  int detectionTimeoutMs = 1000;

  bool useBarcodeOverlay = true;
  BoxFit boxFit = BoxFit.cover;
  bool enableLifecycle = false;

  List<BarcodeFormat> selectedFormats = [];

  MobileScannerController initController() => MobileScannerController(
    autoStart: true,
    cameraResolution: desiredCameraResolution,
    detectionSpeed: detectionSpeed,
    detectionTimeoutMs: detectionTimeoutMs,
    formats: selectedFormats,
    returnImage: returnImage,
    // torchEnabled: true,
    invertImage: invertImage,
    autoZoom: autoZoom,
  );

  @override
  void initState() {
    super.initState();
    // unawaited(controller.start());
  }

  void _showerror(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), showCloseIcon: true, duration: const Duration(seconds: 2)));
  }

  void _handleBarcode(Barcode barcode) async {
    final String? code = barcode.rawValue;
    if (code == null || _isBottomSheetVisible) return;

    final data = jsonDecode(code);
    if (data is! Map<String, dynamic>) {
      _showerror('Invalid barcode data');
      getIt<Logger>().e('Invalid barcode data format: $code');
      return;
    }

    final id = data['id'];
    final type = data['type'];

    if (id == null || type == null) {
      _showerror('Missing required fields in barcode data');
      getIt<Logger>().e('Missing required fields in barcode data: $code');
      return;
    }

    _isBottomSheetVisible = true;

    Widget? sheetContent;

    switch (type) {
      case 'supply':
        getIt<Logger>().d('Supply found! $code');
        sheetContent = SupplyBottomSheet(itemId: id.toString());
        break;

      case 'equipment':
        getIt<Logger>().d('Equipment found! $code');
        sheetContent = EquipmentBottomSheet(itemId: id.toString(), copyNum: data['copyNumber'].toString());
        break;

      default:
        _showerror('Unknown item type');
        getIt<Logger>().e('Unknown item type in barcode data: $code');
        _isBottomSheetVisible = false;
        return;
    }

    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (context) => sheetContent!,
    );

    // Reset the flag when the sheet is dismissed
    _isBottomSheetVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    late final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(const Offset(0, -100)),
      width: 300,
      height: 300,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('QR Scanner')),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Scanner preview area
          Expanded(
            child: Stack(
              children: [
                MobileScanner(
                  scanWindow: useScanWindow ? scanWindow : null,
                  controller: controller,
                  errorBuilder: (context, error) {
                    return ScannerErrorWidget(error: error);
                  },
                  fit: boxFit,
                  onDetect: (capture) {
                    final barcodes = capture.barcodes;
                    if (barcodes.isNotEmpty) {
                      _handleBarcode(barcodes.first);
                    }
                  },
                ),
                if (!kIsWeb && useScanWindow) ScanWindowOverlay(controller: controller, scanWindow: scanWindow),
              ],
            ),
          ),
          // Toolbar below preview
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: const Color.fromRGBO(0, 0, 0, 0.6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!kIsWeb) ZoomScaleSlider(controller: controller),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ToggleFlashlightButton(controller: controller),
                    StartStopButton(controller: controller),
                    // PauseButton(controller: controller),
                    SwitchCameraButton(controller: controller),
                    AnalyzeImageButton(controller: controller),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
