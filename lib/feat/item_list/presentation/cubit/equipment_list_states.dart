import 'package:sccc_v3/feat/item_list/domain/entity/equipment_copy_entity.dart';

abstract class EquipmentListState {}

class EquipmentListInitial extends EquipmentListState {}

class EquipmentListLoading extends EquipmentListState {}

class EquipmentListLoaded extends EquipmentListState {
  final List<EquipmentCopyEntity> equipments;
  final bool hasReachedMax;
  final int currentPage;
  final int lastPage;
  final int total;

  EquipmentListLoaded({
    required this.equipments,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.hasReachedMax = false,
  });

  EquipmentListLoaded copyWith({
    List<EquipmentCopyEntity>? equipments,
    bool? hasReachedMax,
    int? currentPage,
    int? lastPage,
    int? total,
  }) {
    return EquipmentListLoaded(
      equipments: equipments ?? this.equipments,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      total: total ?? this.total,
    );
  }
}

class EquipmentListError extends EquipmentListState {
  final String message;

  EquipmentListError(this.message);
}
