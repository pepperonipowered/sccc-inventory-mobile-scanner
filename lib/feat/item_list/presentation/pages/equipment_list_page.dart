import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/category_cubit.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/category_states.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/equipment_list_cubit.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/equipment_list_states.dart';

class EquipmentListPage extends StatefulWidget {
  const EquipmentListPage({super.key});

  @override
  State<EquipmentListPage> createState() => _EquipmentListPageState();
}

class _EquipmentListPageState extends State<EquipmentListPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  Set<int> selectedCategoryIds = {};
  // see supply_list_page.dart for debounce implementation
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _fetchAllEquipment(page: 1);

    // _searchController.addListener(_onSearchChanged);

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.offset) {
        final currentState = context.read<EquipmentListCubit>().state;

        if (currentState is EquipmentListLoaded && !currentState.hasReachedMax) {
          _fetchAllEquipment(page: currentState.currentPage + 1);
        }
      }
    });
  }

  void _fetchAllEquipment({int page = 1}) {
    final searchText = _searchController.text.trim();

    context.read<EquipmentListCubit>().fetchAllEquipment(
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
    return BlocBuilder<EquipmentListCubit, EquipmentListState>(
      builder: (context, state) {
        if (state is EquipmentListLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        Center(
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
        if (state is EquipmentListError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        if (state is EquipmentListLoaded) {
          final equipments = state.equipments;
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
                    hintText: 'Search equipment name',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon:
                        _searchController.text.isNotEmpty
                            ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _fetchAllEquipment(page: 1);
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
                    _fetchAllEquipment(page: 1);
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
                                              _fetchAllEquipment(page: 1);
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
                                          _fetchAllEquipment(
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
                    await context.read<EquipmentListCubit>().fetchAllEquipment(page: 1);
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: hasReachedMax ? equipments.length : equipments.length + 1,
                    itemBuilder: (context, index) {
                      if (index < equipments.length) {
                        final equipment = equipments[index];
                        String name = equipment.officeEquipment.equipmentName ?? 'Unknown Equipment';
                        String category = equipment.categories.categoryName;
                        String copyNumber = equipment.copyNum.toString();
                        String imagePath = equipment.officeEquipment.imagePath ?? '';

                        return ListTile(
                          leading: SizedBox(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: ClipRRect(borderRadius: BorderRadius.circular(8), child: _buildImage(imagePath)),
                            ),
                          ),
                          title: Text(name),
                          subtitle: Text(category),
                          trailing: Text('Copy #$copyNumber'),
                          onTap: () {
                            context.push(
                              '/equipment?item_id=${equipment.officeEquipment.id}&copy_num=${equipment.copyNum}',
                            );
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

        return const SizedBox.shrink(); // Fallback for initial state
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
