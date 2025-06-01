class ApiUrl {
  static const String baseUrl = 'http://192.168.1.12:8000/api';
  static const String apiKey = '5m@rtC!ty';

  // auth
  static const String getUser = '$baseUrl/user';
  static const String login = '$baseUrl/mobile/login';
  static const String register = '$baseUrl/mobile/register';
  static const String logout = '$baseUrl/mobile/logout';

  // office items
  static const String officeSupplies = '$baseUrl/office_supplies';
  static const String officeSuppliesWithRelations = '$baseUrl/office_supplies/with-relations';
  static const String officeSuppliesById =
      '$baseUrl/office-supplies-by-id'; // made custom method to eager load related data
  static const String officeEquipments = '$baseUrl/office_equipments';

  static const String officeEquipmentCopies = '$baseUrl/equipment_copies/by-item';
  static const String officeEquipmentWithRelations = '$baseUrl/equipment_copies/with-relations';
  static const String officeEquipmentCopyByItemCopyId = '$baseUrl/equipment-copy';

  // borrow transaction
  static const String borrowTransaction = '$baseUrl/borrow_transactions';
  static const String borrowTransactionItem = '$baseUrl/borrow_transaction_items';
  static const String createBorrowTransaction = '$baseUrl/borrow-transactions/store-and-load';

  // category
  static const String category = '$baseUrl/categories';
}
