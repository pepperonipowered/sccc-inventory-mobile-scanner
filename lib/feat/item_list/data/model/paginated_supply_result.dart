import 'package:sccc_v3/feat/item_list/domain/entity/supply_entity.dart';

class PaginatedSupplyResult {
  final List<SupplyEntity> data;
  final int currentPage;
  final int lastPage;
  final int total;

  PaginatedSupplyResult({
    required this.data,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });
}