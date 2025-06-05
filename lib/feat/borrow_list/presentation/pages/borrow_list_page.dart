import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:sccc_v3/app.dart';
import 'package:sccc_v3/common/bloc/button/button_state.dart';
import 'package:sccc_v3/common/bloc/button/button_state_cubit.dart';
import 'package:sccc_v3/feat/borrow_list/domain/entities/local_equipment_copy_entity.dart';
import 'package:sccc_v3/feat/borrow_list/domain/entities/local_supply_entity.dart';
import 'package:sccc_v3/feat/borrow_list/presentation/cubit/local_item_list_cubit.dart';
import 'package:sccc_v3/feat/borrow_list/presentation/cubit/local_item_list_states.dart';

class BorrowListPage extends StatelessWidget {
  const BorrowListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<ButtonStateCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonSuccess) {
            rootScaffoldMessengerKey.currentState?.showSnackBar(
              SnackBar(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                content: Text("Item deleted successfully."),
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
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('Borrow List'), centerTitle: true),
          body: BlocBuilder<LocalItemListCubit, LocalItemListStates>(
            builder: (context, state) {
              if (state is LoadingLocalItemListState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ErrorLocalItemListState) {
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
              }

              if (state is LoadedLocalItemListState) {
                final items = state.items;

                if (items.isEmpty == false) {
                  return RefreshIndicator(
                    onRefresh: () => context.read<LocalItemListCubit>().loadLocalItems(),
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];

                        if (item is LocalEquipmentCopyEntity) {
                          return _buildEquipmentTile(context, item);
                        } else if (item is LocalSupplyEntity) {
                          return _buildSupplyTile(context, item);
                        } else {
                          return ListTile(title: Text('Item not found.'));
                        }
                      },
                    ),
                  );
                }
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.titleLarge,
                        children: [
                          const TextSpan(text: 'No items found 🤷. \n'),
                          const TextSpan(text: 'You can '),
                          TextSpan(
                            text: 'add here',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    // Replace with your navigation logic
                                    context.go('/');
                                  },
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Image.asset('assets/images/empty-basket.png', fit: BoxFit.cover, width: 322, height: 322),
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FilledButton(
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              onPressed: () {
                context.push('/borrow_list/new_transaction');
              },
              child: const Text('Create Borrow Transaction'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEquipmentTile(BuildContext context, LocalEquipmentCopyEntity item) {
    final equipment = item;

    String name = '${equipment.equipmentName} #${equipment.copyNum}';
    String category = equipment.categoryName;
    // String image =

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Deleting borrow item')));
              // TODO: implement deletion via Cubit
              context.read<LocalItemListCubit>().deleteLocalItem(equipment);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        minVerticalPadding: 16,
        minTileHeight: 80,
        leading: AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset('assets/images/baguio-logo.png')),
        ),
        title: Text(name),
        subtitle: Text(category),
      ),
    );
  }

  Widget _buildSupplyTile(BuildContext context, LocalSupplyEntity item) {
    final supply = item;

    String name = '${supply.supplyName}';
    String serialNumber = supply.serialNumber ?? 'No serial number found.';
    String category = supply.categoryName ?? 'No category found.';
    int quantity = supply.supplyQuantity ?? 1;

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Deleting borrow item')));
              // TODO: implement deletion via Cubit
              context.read<LocalItemListCubit>().deleteLocalItem(supply);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        minVerticalPadding: 16,
        minTileHeight: 80,
        leading: AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset('assets/images/baguio-logo.png')),
        ),
        title: Text(name),
        isThreeLine: true,
        subtitle: Text('$category\n$serialNumber'),
        trailing: InputQty(
          initVal: quantity,
          minVal: 1,
          maxVal: 100,
          steps: 1,
          decoration: QtyDecorationProps(
            isBordered: false,
            orientation: ButtonOrientation.vertical,
            contentPadding: EdgeInsets.zero,
            qtyStyle: QtyStyle.btnOnRight,
            borderShape: BorderShapeBtn.square,
            btnColor: Theme.of(context).colorScheme.primary,
            plusButtonConstrains: const BoxConstraints(minHeight: 44, minWidth: 44),
            minusButtonConstrains: const BoxConstraints(minHeight: 44, minWidth: 44),
          ),
          qtyFormProps: QtyFormProps(keyboardType: TextInputType.number),
        ),
      ),
    );
  }
}
