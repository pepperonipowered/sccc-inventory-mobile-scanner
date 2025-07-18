import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sccc_v3/app.dart';
import 'package:sccc_v3/common/bloc/button/button_state.dart';
import 'package:sccc_v3/common/bloc/button/button_state_cubit.dart';
import 'package:sccc_v3/common/widgets/button/basic_app_button.dart';
import 'package:sccc_v3/core/routes/app_router.dart';
import 'package:sccc_v3/feat/borrow_list/domain/entities/local_equipment_copy_entity.dart';
import 'package:sccc_v3/feat/borrow_list/presentation/cubit/local_item_list_cubit.dart';
import 'package:sccc_v3/feat/item_list/data/model/equipment_copy_by_copy_num_and_item_id_req.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/equipment_details_cubit.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/equipment_details_states.dart';

class EquipmentBottomSheet extends StatefulWidget {
  final String itemId;
  final String copyNum;

  const EquipmentBottomSheet({super.key, required this.itemId, required this.copyNum});

  @override
  State<EquipmentBottomSheet> createState() => _EquipmentBottomSheetState();
}

class _EquipmentBottomSheetState extends State<EquipmentBottomSheet> {
  @override
  void initState() {
    super.initState();
    context.read<EquipmentDetailsCubit>().loadEquipmentDetails(
      EquipmentCopyByCopyNumAndItemIdReq(itemId: int.parse(widget.itemId), copyNum: int.parse(widget.copyNum)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: BlocListener<ButtonStateCubit, ButtonState>(
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
            Navigator.of(context).pop();
          }

          if (state is ButtonSuccess) {
            rootScaffoldMessengerKey.currentState?.showSnackBar(
              SnackBar(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                content: Text("Successfully added to borrow list. Go to borrow list to proceed."),
                action: SnackBarAction(
                  label: 'Go',
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {
                    final context = AppRouter.rootNavigatorKey.currentContext!;
                    context.push('/borrow_list');
                    rootScaffoldMessengerKey.currentState?.clearSnackBars();
                  },
                ),
              ),
            );
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<EquipmentDetailsCubit, EquipmentDetailsState>(
          builder: (context, state) {
            if (state is EquipmentDetailsLoading) {
              return SizedBox(height: 150, width: double.infinity, child: Center(child: CircularProgressIndicator()));
            } else if (state is EquipmentDetailsError) {
              return Center(
                child: Text('Error loading equipment details: ${state.message}', style: theme.textTheme.bodyMedium),
              );
            } else if (state is EquipmentDetailsLoaded) {
              final equipment = state.equipment;

              String equipmentName = equipment.officeEquipment.equipmentName ?? 'Unknown Equipment';
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('$equipmentName #${equipment.copyNum}', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 12),
                  Text(
                    equipment.officeEquipment.equipmentDescription ?? 'No description available',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            final item = LocalEquipmentCopyEntity(
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
                            );

                            final isAvailable = equipment.isAvailable == true;

                            return BasicAppButton(
                              onPressed: () {
                                if (!isAvailable) return;
                                context.read<ButtonStateCubit>().executeCallback(() async {
                                  await context.read<LocalItemListCubit>().addLocalItem(item);
                                });
                              },
                              style:
                                  isAvailable
                                      ? FilledButton.styleFrom(
                                        backgroundColor: Theme.of(context).colorScheme.primary,
                                        minimumSize: const Size.fromHeight(40),
                                      )
                                      : FilledButton.styleFrom(
                                        disabledBackgroundColor: Colors.grey,
                                        minimumSize: const Size.fromHeight(40),
                                      ),
                              loadingStyle: FilledButton.styleFrom(minimumSize: const Size.fromHeight(40)),
                              title: isAvailable ? "Borrow" : "Unavailable",
                              textStyle: Theme.of(
                                context,
                              ).textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                              icon: Icons.add,
                              iconSize: 20,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              );
            }
            return const SizedBox.shrink(); // Fallback for unexpected states
          },
        ),
      ),
    );
  }
}
