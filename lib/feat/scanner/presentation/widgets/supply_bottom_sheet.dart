import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/supply_cubit.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/supply_states.dart';

class SupplyBottomSheet extends StatefulWidget {
  final String itemId;
  const SupplyBottomSheet({super.key, required this.itemId});

  @override
  State<SupplyBottomSheet> createState() => _SupplyBottomSheetState();
}

class _SupplyBottomSheetState extends State<SupplyBottomSheet> {
  @override
  void initState() {
    super.initState();
    context.read<SupplyCubit>().getSupplyById(int.parse(widget.itemId));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: BlocBuilder<SupplyCubit, SupplyCubitStates>(
        builder: (context, state) {
          if (state is SupplyCubitLoadingState) {
            return SizedBox(height: 150, width: double.infinity, child: Center(child: CircularProgressIndicator()));
          } else if (state is SupplyCubitErrorState) {
            return Center(
              child: Text('Error loading supply details: ${state.message}', style: theme.textTheme.bodyMedium),
            );
          } else if (state is SupplyCubitLoadedState) {
            final supply = state.supply;

            String supplyName = supply.supplyName ?? 'Unknown Supply';
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(supplyName, style: theme.textTheme.titleLarge),
                const SizedBox(height: 12),
                Text(
                  supply.supplyDescription ?? 'No description available',
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed:
                            supply.supplyQuantity != 0
                                ? () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        child: Text('Borrowed $supplyName'),
                                      ),
                                      backgroundColor: Colors.green,
                                      showCloseIcon: true,
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                }
                                : null, // Disables the button

                        style: FilledButton.styleFrom(
                          backgroundColor:
                              (supply.supplyQuantity != 0)
                                  ? null // default enabled color
                                  : Colors.grey.shade400, // gray when disabled
                        ),

                        child: Text((supply.supplyQuantity != 0) ? 'Borrow' : 'Unavailable'),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
