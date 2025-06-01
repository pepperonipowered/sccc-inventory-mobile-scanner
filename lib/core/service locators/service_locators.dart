import 'package:sccc_v3/feat/auth/data/source/auth_api_service.dart';
import 'package:sccc_v3/feat/auth/data/source/auth_local_service.dart';
import 'package:sccc_v3/feat/borrow_list/data/source/local_equipment_service.dart';
import 'package:sccc_v3/feat/borrow_list/data/source/local_supply_service.dart';
import 'package:sccc_v3/feat/item_list/data/source/category_service.dart';
import 'package:sccc_v3/feat/item_list/data/source/equipment_service.dart';
import 'package:sccc_v3/feat/item_list/data/source/supply_service.dart';
import 'package:sccc_v3/service_locator.dart';

void serviceLocators() {
  // Register your service locators here
  // Example:
  // getIt.registerLazySingleton<YourService>(() => YourServiceImpl());

  // Auth services
  getIt.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  getIt.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());

  // supply services
  getIt.registerSingleton<SupplyService>(SupplyServiceImpl());
  getIt.registerSingleton<LocalSupplyService>(LocalSupplyServiceImpl());

  // equipment services
  getIt.registerSingleton<EquipmentCopyService>(EquipmentCopyServiceImpl());
  getIt.registerSingleton<LocalEquipmentCopyService>(LocalEquipmentServiceImpl());

  // category services
  getIt.registerSingleton<CategoryService>(CategoryServiceImpl());
}
