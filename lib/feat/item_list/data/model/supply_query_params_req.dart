class SupplyQueryParamsReq {
  int? page;
  int? perPage;
  final List<int>? categoryIds;
  final String? search;

  SupplyQueryParamsReq({required this.page, required this.perPage, this.categoryIds, this.search});

  Map<String, dynamic> toQueryParams() {
    return {
      'page': page,
      'per_page': perPage,
      if (categoryIds != null && categoryIds!.isNotEmpty) 'category_ids': categoryIds!.join(','),
      if (search != null && search!.isNotEmpty) 'search': search,
    };
  }
}
