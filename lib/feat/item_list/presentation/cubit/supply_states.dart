import 'package:sccc_v3/feat/item_list/domain/entity/supply_entity.dart';

abstract class SupplyCubitStates {}

class SupplyCubitLoadingState extends SupplyCubitStates {}

class SupplyCubitLoadedState extends SupplyCubitStates {
  final SupplyEntity supply;
  SupplyCubitLoadedState({required this.supply});
}

class SupplyCubitErrorState extends SupplyCubitStates {
  final String message;

  SupplyCubitErrorState(this.message);
}

class SupplyCubitBorrowErrorState extends SupplyCubitStates {
  final String message;

  SupplyCubitBorrowErrorState(this.message);
}
