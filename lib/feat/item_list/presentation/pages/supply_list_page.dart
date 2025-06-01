import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/category_cubit.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/category_states.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/supply_list_cubit.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/supply_list_states.dart';

class SupplyListPage extends StatefulWidget {
  const SupplyListPage({super.key});

  @override
  State<SupplyListPage> createState() => _SupplyListPageState();
}

class _SupplyListPageState extends State<SupplyListPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  Set<int> selectedCategoryIds = {};
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _fetchSupplies(page: 1);

    // _searchController.addListener(_onSearchChanged);

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.offset) {
        final currentState = context.read<SupplyListCubit>().state;

        if (currentState is SupplyLoadedState && !currentState.hasReachedMax) {
          _fetchSupplies(page: currentState.currentPage + 1);
        }
      }
    });
  }

  // Uncomment this method if you want to debounce the search input but it closes keyboard on every change
  // void _onSearchChanged() {
  //   if (_debounce?.isActive ?? false) _debounce!.cancel();

  //   _debounce = Timer(const Duration(milliseconds: 500), () {
  //     _fetchSupplies(page: 1);
  //   });
  // }

  void _fetchSupplies({int page = 1}) {
    final searchText = _searchController.text.trim();

    context.read<SupplyListCubit>().fetchSupplies(
      page: page,
      search: searchText.isEmpty ? null : searchText,
      categoryIds: selectedCategoryIds.isEmpty ? null : selectedCategoryIds.toList(),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupplyListCubit, SupplyListStates>(
      builder: (context, state) {
        if (state is SupplyErrorState) {
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
                // Display the error message for debugging purposes
                // Text(
                //   'Error: ${state.message}',
                //   style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.transparent),
                //   textAlign: TextAlign.center,
                // ),
              ],
            ),
          );
        }
        if (state is SupplyLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SupplyLoadedState) {
          final supplies = state.supplies;
          final hasReachedMax = state.hasReachedMax;

          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search supply name',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon:
                        _searchController.text.isNotEmpty
                            ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _fetchSupplies(page: 1);
                                // Optionally unfocus keyboard after clearing
                                FocusScope.of(context).unfocus();
                              },
                            )
                            : null,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(360)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  ),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    _debounce?.cancel();
                    _fetchSupplies(page: 1);
                  },
                  // Optional: to fetch while typing but debounce it to avoid spamming
                  onChanged: (value) {
                    // debounce or throttle the calls if you want
                    // call debounce function here if you want to use it
                  },
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                ),
              ),
              BlocBuilder<CategoryCubit, CategoryStates>(
                builder: (context, state) {
                  if (state is CategoryLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is CategoryErrorState) {
                    return Center(child: Text(state.message, style: Theme.of(context).textTheme.titleLarge));
                  }
                  if (state is CategoryLoadedState) {
                    final categories = state.categories;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: MenuAnchor(
                            consumeOutsideTap: true,
                            builder: (BuildContext context, MenuController controller, Widget? child) {
                              return FilledButton.tonalIcon(
                                onPressed: () {
                                  controller.isOpen ? controller.close() : controller.open();
                                },
                                icon: const Icon(Icons.arrow_drop_down),
                                label: const Text('Category'),
                              );
                            },
                            menuChildren: [
                              SizedBox(
                                width: 200,
                                height: 300,
                                child: Scrollbar(
                                  thumbVisibility: true,
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                    children:
                                        categories.map((category) {
                                          final isSelected = selectedCategoryIds.contains(category.id);
                                          return CheckboxMenuButton(
                                            value: isSelected,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                if (value == true) {
                                                  selectedCategoryIds.add(category.id);
                                                } else {
                                                  selectedCategoryIds.remove(category.id);
                                                }
                                              });
                                              _fetchSupplies(page: 1);
                                            },
                                            child: Text(category.categoryName),
                                          );
                                        }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (selectedCategoryIds.isNotEmpty)
                          SingleChildScrollView(
                            padding: const EdgeInsets.only(left: 16),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                  selectedCategoryIds.map((id) {
                                    final category = categories.firstWhere((c) => c.id == id);
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      child: InputChip(
                                        label: Text(category.categoryName),
                                        shape: const StadiumBorder(),
                                        onDeleted: () {
                                          setState(() {
                                            selectedCategoryIds.remove(id);
                                          });
                                          _fetchSupplies(
                                            page: 1,
                                          ); // Add this line to refresh data after removing category
                                        },
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
              Expanded(
                child: RefreshIndicator.adaptive(
                  onRefresh: () async {
                    await context.read<SupplyListCubit>().fetchSupplies(page: 1);
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: hasReachedMax ? supplies.length : supplies.length + 1,
                    itemBuilder: (context, index) {
                      if (index < supplies.length) {
                        final supply = supplies[index];
                        String name = supply.supplyName ?? 'Unknown Supply';
                        String category = supply.categories.categoryName;
                        String quantity = supply.supplyQuantity.toString();
                        String imagePath = supply.imagePath ?? '';

                        return ListTile(
                          leading: SizedBox(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: ClipRRect(borderRadius: BorderRadius.circular(8), child: _buildImage(imagePath)),
                            ),
                          ),
                          title: Text(name),
                          subtitle: Text(category),
                          trailing: Text(quantity),
                          onTap: () {
                            context.push('/supply/${supply.id}');
                          },
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget _buildImage(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty || imageUrl == '') {
      return Image.asset('assets/images/baguio-logo.png');
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => Image.asset('assets/images/baguio-logo.png'),
      errorWidget: (context, url, error) => Image.asset('assets/images/baguio-logo.png'),
    );
  }
}
