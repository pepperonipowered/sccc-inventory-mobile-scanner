class EquipmentCopyByCopyNumAndItemIdReq {
  final int copyNum;
  final int itemId;

  EquipmentCopyByCopyNumAndItemIdReq({required this.copyNum, required this.itemId});

  Map<String, dynamic> toJson() {
    return {'copy_num': copyNum, 'item_id': itemId};
  }

  Map<String, dynamic> toQueryParams() {
    return {'copy_num': copyNum, 'item_id': itemId};
  }
}
