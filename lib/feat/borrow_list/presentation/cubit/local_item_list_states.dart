import 'package:sccc_v3/feat/borrow_list/domain/entities/local_item_entity.dart';

abstract class LocalItemListStates {}

class InitialLocalItemListState extends LocalItemListStates {}

class LoadingLocalItemListState extends LocalItemListStates {}

class LoadedLocalItemListState extends LocalItemListStates {
  final List<LocalItemEntity> items;
  LoadedLocalItemListState(this.items);
}

class ErrorLocalItemListState extends LocalItemListStates {
  final String message;
  ErrorLocalItemListState(this.message);
}
