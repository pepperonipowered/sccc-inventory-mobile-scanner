class OfficeEquipmentEntity {
  int id;
  String? equipmentName;
  String? equipmentDescription;
  int categoryId;
  String? imagePath;
  DateTime? createdAt;
  DateTime? updatedAt;

  OfficeEquipmentEntity({
    required this.id,
    this.equipmentName,
    this.equipmentDescription,
    required this.categoryId,
    this.imagePath,
    this.createdAt,
    this.updatedAt,
  });
}
