import 'package:sccc_v3/feat/item_list/domain/entity/category_entity.dart';

class SupplyEntity {
  final int id;
  final String? supplyName;
  final String? supplyDescription;
  final String? serialNumber;
  final int? categoryId;
  final int? supplyQuantity;
  final String? imagePath;
  final String? createdAt;
  final String? updatedAt;
  final CategoryEntity categories;

  SupplyEntity({
    required this.id,
    this.supplyName,
    this.supplyDescription,
    this.serialNumber,
    this.categoryId,
    this.supplyQuantity,
    this.imagePath,
    this.createdAt,
    this.updatedAt,
    required this.categories,
  });
}
