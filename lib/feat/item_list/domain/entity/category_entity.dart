class CategoryEntity {
  final int id;
  final String categoryName;
  final bool isDeleted;
  final int? deletedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CategoryEntity({
    required this.id,
    required this.categoryName,
    required this.isDeleted,
    required this.deletedBy,
    this.createdAt,
    this.updatedAt,
  });
}
