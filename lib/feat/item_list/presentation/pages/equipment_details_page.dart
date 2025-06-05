import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';
import 'package:sccc_v3/app.dart';
import 'package:sccc_v3/common/bloc/button/button_state.dart';
import 'package:sccc_v3/common/bloc/button/button_state_cubit.dart';
import 'package:sccc_v3/common/widgets/button/basic_app_button.dart';
import 'package:sccc_v3/feat/borrow_list/domain/entities/local_equipment_copy_entity.dart';
import 'package:sccc_v3/feat/borrow_list/domain/usecase/equipment/create_local_equipment_usecase.dart';
import 'package:sccc_v3/feat/item_list/data/model/equipment_copy_by_copy_num_and_item_id_req.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/equipment_details_cubit.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/equipment_details_states.dart';
import 'package:sccc_v3/service_locator.dart';

class EquipmentDetailsPage extends StatefulWidget {
  final String itemId;
  final String copyNum;
  const EquipmentDetailsPage({super.key, required this.itemId, required this.copyNum});

  @override
  State<EquipmentDetailsPage> createState() => _EquipmentDetailsPageState();
}

class _EquipmentDetailsPageState extends State<EquipmentDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<EquipmentDetailsCubit>().loadEquipmentDetails(
      EquipmentCopyByCopyNumAndItemIdReq(itemId: int.parse(widget.itemId), copyNum: int.parse(widget.copyNum)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          forceMaterialTransparency: true,
          shadowColor: Theme.of(context).shadowColor,
          leading: IconButton.filled(
            icon: const Icon(Icons.arrow_back, size: 20),
            color: Colors.white, // icon color
            onPressed: () => Navigator.of(context).pop(),
          ),
          leadingWidth: 80,
          centerTitle: true,
          toolbarHeight: 90,
          title: const Text(
            "Equipment Details",
            // style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        body: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonFailure) {
              rootScaffoldMessengerKey.currentState?.showSnackBar(
                SnackBar(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  content: Text(state.error),
                  action: SnackBarAction(
                    label: 'Ok',
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    onPressed: () {
                      rootScaffoldMessengerKey.currentState?.clearSnackBars();
                    },
                  ),
                ),
              );
            }

            if (state is ButtonSuccess) {
              rootScaffoldMessengerKey.currentState?.showSnackBar(
                SnackBar(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.green,
                  content: Text("Successfully added to borrow list."),
                  action: SnackBarAction(
                    label: 'Ok',
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    onPressed: () {
                      rootScaffoldMessengerKey.currentState?.clearSnackBars();
                    },
                  ),
                ),
              );
              context.push('/borrow_list');
            }
          },
          child: BlocBuilder<EquipmentDetailsCubit, EquipmentDetailsState>(
            builder: (context, state) {
              if (state is EquipmentDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is EquipmentDetailsError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/error.svg', fit: BoxFit.cover, width: 225, height: 225),
                      const SizedBox(height: 20),
                      Text(
                        'Something went wrong 😬!\nTry again later 😔.',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      // Text(
                      //   'Error: ${state.message}',
                      //   style: Theme.of(context).textTheme.titleLarge,
                      //   textAlign: TextAlign.center,
                      // ),
                    ],
                  ),
                );
              } else if (state is EquipmentDetailsLoaded) {
                final equipment = state.equipment;
                return Column(
                  children: [
                    Image.asset(
                      equipment.officeEquipment.imagePath ?? 'assets/images/placeholder.png',
                      height: MediaQuery.of(context).size.height * 0.40,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 24.0),
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Text(
                                equipment.categories.categoryName,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Text(
                                '${equipment.officeEquipment.equipmentName} #${equipment.copyNum}',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Text(
                                "Description",
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: ReadMoreText(
                                equipment.officeEquipment.equipmentDescription ?? 'No description available.',
                                trimMode: TrimMode.Line,
                                trimLines: 3,
                                colorClickableText: Theme.of(context).colorScheme.primary,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: ' Show less',
                                moreStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                                lessStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Builder(
                                      builder: (context) {
                                        return BasicAppButton(
                                          onPressed:
                                          // (equipment.isAvailable == true || equipment.isAvailable == 1)
                                          //     ?
                                          () {
                                            if (equipment.isAvailable == true) null;
                                            context.read<ButtonStateCubit>().executeNonEither(
                                              usecase: getIt<CreateLocalEquipmentUsecase>(),
                                              params: LocalEquipmentCopyEntity(
                                                id: equipment.id,
                                                itemId: equipment.itemId,
                                                isAvailable: equipment.isAvailable,
                                                copyNum: equipment.copyNum,
                                                createdAt: equipment.createdAt,
                                                updatedAt: equipment.updatedAt,
                                                equipmentId: equipment.officeEquipment.id,
                                                equipmentName: equipment.officeEquipment.equipmentName!,
                                                equipmentDescription: equipment.officeEquipment.equipmentDescription,
                                                categoryId: equipment.categories.id,
                                                categoryName: equipment.categories.categoryName,
                                              ),
                                            );
                                          },
                                          style:
                                              equipment.isAvailable == true
                                                  ? FilledButton.styleFrom(
                                                    disabledBackgroundColor: Colors.grey,
                                                    minimumSize: Size(double.infinity, 44),
                                                  )
                                                  : FilledButton.styleFrom(
                                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                                    minimumSize: Size.fromHeight(44),
                                                  ),
                                          loadingStyle: FilledButton.styleFrom(minimumSize: Size.fromHeight(44)),
                                          title:
                                              (equipment.isAvailable == true || equipment.isAvailable)
                                                  ? "Borrow"
                                                  : "Unavailable",
                                          icon: Icons.add,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink(); // Fallback for unexpected states
            },
          ),
        ),
      ),
    );
  }
}
