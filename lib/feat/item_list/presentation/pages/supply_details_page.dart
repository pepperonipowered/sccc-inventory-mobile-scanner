import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:readmore/readmore.dart';
import 'package:sccc_v3/app.dart';
import 'package:sccc_v3/common/bloc/button/button_state.dart';
import 'package:sccc_v3/common/bloc/button/button_state_cubit.dart';
import 'package:sccc_v3/common/widgets/button/basic_app_button.dart';
import 'package:sccc_v3/feat/borrow_list/domain/entities/local_supply_entity.dart';
import 'package:sccc_v3/feat/borrow_list/domain/usecase/supply/create_local_supply_usecase.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/supply_cubit.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/supply_states.dart';
import 'package:sccc_v3/service_locator.dart';

class SupplyDetailsPage extends StatefulWidget {
  final String itemId;
  const SupplyDetailsPage({super.key, required this.itemId});

  @override
  State<SupplyDetailsPage> createState() => _SupplyDetailsPageState();
}

class _SupplyDetailsPageState extends State<SupplyDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _qtyTextController;

  @override
  void initState() {
    super.initState();
    context.read<SupplyCubit>().getSupplyById(int.parse(widget.itemId));
    _qtyTextController = TextEditingController(text: '1');
  }

  // @override
  // void dispose() {
  //   _qtyTextController.dispose();
  //   super.dispose();
  // }

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
          toolbarHeight: 90,
          centerTitle: true,
          title: const Text(
            "Supply Details",
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
          child: BlocBuilder<SupplyCubit, SupplyCubitStates>(
            builder: (context, state) {
              if (state is SupplyCubitLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SupplyCubitErrorState) {
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
                    ],
                  ),
                );
              } else if (state is SupplyCubitBorrowErrorState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) return;
                  rootScaffoldMessengerKey.currentState!.showSnackBar(SnackBar(content: Text(state.message)));
                });
                return const SizedBox.shrink();
              } else if (state is SupplyCubitLoadedState) {
                final supply = state.supply;
                int quantity = supply.supplyQuantity ?? 0;
                return Column(
                  children: [
                    Image.asset(
                      supply.imagePath ?? 'assets/images/placeholder.png',
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
                                supply.categories.categoryName,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Text(
                                supply.supplyName ?? 'Supply Name',
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
                                supply.supplyDescription ?? 'No description available.',
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
                                  IntrinsicWidth(
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(maxWidth: 128),
                                      child: Form(
                                        key: _formKey,
                                        child: InputQty(
                                          initVal: 1,
                                          maxVal: quantity,
                                          minVal: 1,
                                          qtyFormProps: QtyFormProps(
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
                                            controller: _qtyTextController,
                                            enableTyping: true,
                                          ),
                                          decoration: QtyDecorationProps(
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            focusedErrorBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,

                                            plusBtn: Ink(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).colorScheme.primary, // fill color
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              height: 32,
                                              width: 32,
                                              child: InkWell(
                                                borderRadius: BorderRadius.circular(6),
                                                onTap: () {
                                                  final current = num.tryParse(_qtyTextController.text) ?? 1;
                                                  if (current < 999) {
                                                    _qtyTextController.text = (current + 1).toString();
                                                  }
                                                },
                                                child: const Icon(Icons.add, color: Colors.white),
                                              ),
                                            ),

                                            minusBtn: Ink(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).colorScheme.primary,
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              height: 32,
                                              width: 32,
                                              child: InkWell(
                                                borderRadius: BorderRadius.circular(6),
                                                onTap: () {
                                                  final current = num.tryParse(_qtyTextController.text) ?? 1;
                                                  if (current > 1) {
                                                    _qtyTextController.text = (current - 1).toString();
                                                  }
                                                },
                                                child: const Icon(Icons.remove, color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          validator: (val) {
                                            if (val == null) return 'Enter a quantity';
                                            if (val > quantity) return 'Max quantity is $quantity';
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    child: Builder(
                                      builder: (context) {
                                        return BasicAppButton(
                                          icon: Icons.add,
                                          title: quantity <= 0 ? "Out of Stock" : "Borrow",
                                          style:
                                              quantity <= 0
                                                  ? FilledButton.styleFrom(
                                                    disabledBackgroundColor: Colors.grey,
                                                    minimumSize: Size(double.infinity, 44),
                                                  )
                                                  : FilledButton.styleFrom(
                                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                                    minimumSize: Size.fromHeight(44),
                                                  ),
                                          loadingStyle: FilledButton.styleFrom(minimumSize: Size.fromHeight(44)),
                                          onPressed: () {
                                            if (quantity <= 0) return;
                                            if (_formKey.currentState!.validate()) {
                                              context.read<ButtonStateCubit>().executeNonEither(
                                                params: LocalSupplyEntity(
                                                  id: supply.id,
                                                  supplyName: supply.supplyName,
                                                  supplyDescription: supply.supplyDescription,
                                                  serialNumber: supply.serialNumber,
                                                  categoryId: supply.categoryId,
                                                  supplyQuantity: int.parse(_qtyTextController.text),
                                                  imagePath: supply.imagePath,
                                                  createdAt:
                                                      supply.createdAt != null
                                                          ? DateTime.tryParse(supply.createdAt!)
                                                          : null,
                                                  updatedAt:
                                                      supply.updatedAt != null
                                                          ? DateTime.tryParse(supply.updatedAt!)
                                                          : null,
                                                  categoryName: supply.categories.categoryName,
                                                ),
                                                usecase: getIt<CreateLocalSupplyUsecase>(),
                                              );
                                            }
                                          },
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
