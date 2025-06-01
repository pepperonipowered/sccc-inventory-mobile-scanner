import 'package:sccc_v3/feat/item_list/domain/entity/equipment_copy_entity.dart';

abstract class EquipmentDetailsState {}

class EquipmentDetailsInitial extends EquipmentDetailsState {}

class EquipmentDetailsLoading extends EquipmentDetailsState {}

class EquipmentDetailsLoaded extends EquipmentDetailsState {
  final EquipmentCopyEntity equipment;

  EquipmentDetailsLoaded({required this.equipment});
}

class EquipmentDetailsError extends EquipmentDetailsState {
  final String message;

  EquipmentDetailsError({required this.message});
}

class EquipmentDetailsBorrowError extends EquipmentDetailsState {
  final String message;

  EquipmentDetailsBorrowError({required this.message});
}
