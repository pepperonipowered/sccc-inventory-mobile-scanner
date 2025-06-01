import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:go_router/go_router.dart';
import 'package:sccc_v3/feat/item_list/presentation/pages/equipment_list_page.dart';
import 'package:sccc_v3/feat/item_list/presentation/pages/supply_list_page.dart';

class ItemListPage extends StatefulWidget {
  const ItemListPage({super.key});

  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  final GlobalKey<ExpandableFabState> fabKey = GlobalKey<ExpandableFabState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            backgroundColor: Colors.transparent,
            title: const Text('Item List'),
            centerTitle: true,
            bottom: TabBar(tabs: [Tab(text: 'Supplies'), Tab(text: 'Equipment')]),
          ),
          body: TabBarView(children: [SupplyListPage(), EquipmentListPage()]),
          floatingActionButtonLocation: ExpandableFab.location,
          floatingActionButton: ExpandableFab(
            key: fabKey,
            type: ExpandableFabType.up,
            distance: 72,
            openButtonBuilder: FloatingActionButtonBuilder(
              size: 56,
              builder: (context, onPressed, progress) {
                return FloatingActionButton(
                  heroTag: 'menu_fab',
                  onPressed: onPressed,
                  child: const Icon(Icons.menu),
                  // label: const Text('Menu'),
                );
              },
            ),
            closeButtonBuilder: FloatingActionButtonBuilder(
              size: 56,
              builder: (context, onPressed, progress) {
                return FloatingActionButton(
                  heroTag: 'close_fab',
                  onPressed: onPressed,
                  child: const Icon(Icons.close),
                  // label: const Text('Close'),
                );
              },
            ),
            children: [
              FloatingActionButton.extended(
                heroTag: 'scan_qr_code',
                onPressed: () {
                  fabKey.currentState?.toggle();
                  context.push('/qr_scanner');
                },
                icon: const Icon(Icons.qr_code_scanner_rounded),
                label: const Text('Scan QR Code'),
              ),
              FloatingActionButton.extended(
                heroTag: 'borrow_item',
                onPressed: () {
                  fabKey.currentState?.toggle();
                  context.push('/borrow_list');
                },
                icon: const Icon(Icons.shopping_bag_outlined),
                label: const Text('Borrow List'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
