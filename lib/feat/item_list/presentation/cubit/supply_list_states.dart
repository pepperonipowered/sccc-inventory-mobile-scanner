import 'package:sccc_v3/feat/item_list/domain/entity/supply_entity.dart';

abstract class SupplyListStates {}

class SupplyLoadingState extends SupplyListStates {}

class SupplyLoadedState extends SupplyListStates {
  final List<SupplyEntity> supplies;
  final bool hasReachedMax;
  final int currentPage;
  final int lastPage;
  final int total;

  SupplyLoadedState({
    required this.supplies,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.hasReachedMax = false,
  });

  SupplyLoadedState copyWith({
    List<SupplyEntity>? supplies,
    bool? hasReachedMax,
    int? currentPage,
    int? lastPage,
    int? total,
  }) {
    return SupplyLoadedState(
      supplies: supplies ?? this.supplies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      total: total ?? this.total,
    );
  }
}

class SupplyErrorState extends SupplyListStates {
  final String message;

  SupplyErrorState(this.message);
}
