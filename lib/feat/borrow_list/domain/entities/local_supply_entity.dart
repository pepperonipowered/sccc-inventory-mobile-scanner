import 'package:sccc_v3/feat/borrow_list/domain/entities/local_item_entity.dart';

class LocalSupplyEntity extends LocalItemEntity {
  final int? localId;
  final int id;
  final String? supplyName;
  final String? supplyDescription;
  final String? serialNumber;
  final int? categoryId;
  final int? supplyQuantity;
  final String? imagePath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? categoryName;

  LocalSupplyEntity({
    this.localId,
    required this.id,
    this.supplyName,
    this.supplyDescription,
    this.serialNumber,
    this.categoryId,
    this.supplyQuantity,
    this.imagePath,
    this.createdAt,
    this.updatedAt,
    this.categoryName,
  });
}
