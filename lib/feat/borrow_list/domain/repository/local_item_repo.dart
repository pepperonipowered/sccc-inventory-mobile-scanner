import 'package:sccc_v3/feat/borrow_list/domain/entities/local_item_entity.dart';

abstract class LocalItemRepo {
  Future<List<LocalItemEntity>> getAllItems();
  Future<void> deleteItem(LocalItemEntity localItem);
  Future<void> addItem(LocalItemEntity localItem);
}