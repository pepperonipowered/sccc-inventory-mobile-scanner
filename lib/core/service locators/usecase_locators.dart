import 'package:sccc_v3/feat/auth/domain/usecase/check_user_usecase.dart';
import 'package:sccc_v3/feat/auth/domain/usecase/get_user_usecase.dart';
import 'package:sccc_v3/feat/auth/domain/usecase/login_usecase.dart';
import 'package:sccc_v3/feat/auth/domain/usecase/signout_usecase.dart';
import 'package:sccc_v3/feat/borrow_list/domain/usecase/delete_local_item_usecase.dart';
import 'package:sccc_v3/feat/borrow_list/domain/usecase/equipment/create_local_equipment_usecase.dart';
import 'package:sccc_v3/feat/borrow_list/domain/usecase/equipment/delte_local_equipment_usecase.dart';
import 'package:sccc_v3/feat/borrow_list/domain/usecase/supply/create_local_supply_usecase.dart';
import 'package:sccc_v3/feat/borrow_list/domain/usecase/get_all_local_items_usecase.dart';
import 'package:sccc_v3/feat/borrow_list/domain/usecase/supply/delete_local_supply_usecase.dart';
import 'package:sccc_v3/feat/item_list/domain/usecase/get_all_categories_usecase.dart';
import 'package:sccc_v3/feat/item_list/domain/usecase/get_all_equipment_usecase.dart';
import 'package:sccc_v3/feat/item_list/domain/usecase/get_all_supplies_usecase.dart';
import 'package:sccc_v3/feat/item_list/domain/usecase/get_equipment_by_copy_num_and_item_id_usecase.dart';
import 'package:sccc_v3/feat/item_list/domain/usecase/get_supply_by_id_usecase.dart';
import 'package:sccc_v3/service_locator.dart';
import 'package:sccc_v3/feat/auth/domain/usecase/register_usecase.dart';

void usecaseLocators() {
  // Register your use cases here
  // Example:
  // getIt.registerLazySingleton<YourUseCase>(() => YourUseCaseImpl());

  // Auth Usecases
  getIt.registerSingleton<LoginUsecase>(LoginUsecase());
  getIt.registerSingleton<RegisterUsecase>(RegisterUsecase());
  getIt.registerSingleton<SignoutUsecase>(SignoutUsecase());
  getIt.registerSingleton<GetUserUsecase>(GetUserUsecase());
  getIt.registerSingleton<CheckUserUsecase>(CheckUserUsecase());

  // Borrow List Usecases
  getIt.registerSingleton<GetAllLocalItemsUsecase>(GetAllLocalItemsUsecase());
  getIt.registerSingleton<DeleteLocalItemUsecase>(DeleteLocalItemUsecase());

  // Supply Usecases
  getIt.registerSingleton<GetAllSuppliesUsecase>(GetAllSuppliesUsecase());
  getIt.registerSingleton<GetSupplyByIdUsecase>(GetSupplyByIdUsecase());

  getIt.registerSingleton<CreateLocalSupplyUsecase>(CreateLocalSupplyUsecase());
  getIt.registerSingleton<DeleteLocalSupplyUsecase>(DeleteLocalSupplyUsecase());

  // Equipment Usecases
  getIt.registerSingleton<GetAllEquipmentUsecase>(GetAllEquipmentUsecase());
  getIt.registerSingleton<GetEquipmentByCopyNumAndItemIdUsecase>(GetEquipmentByCopyNumAndItemIdUsecase());

  getIt.registerSingleton<CreateLocalEquipmentUsecase>(CreateLocalEquipmentUsecase());
  getIt.registerSingleton<DeleteLocalEquipmentUsecase>(DeleteLocalEquipmentUsecase());

  // Category Usecases
  getIt.registerSingleton<GetAllCategoriesUsecase>(GetAllCategoriesUsecase());
}
