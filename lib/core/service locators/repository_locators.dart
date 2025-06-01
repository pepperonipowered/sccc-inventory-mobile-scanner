import 'package:sccc_v3/feat/auth/data/repository/auth_repo_impl.dart';
import 'package:sccc_v3/feat/auth/domain/repository/auth_repo.dart';
import 'package:sccc_v3/feat/borrow_list/data/repository/local_equipment_copy_repo_impl.dart';
import 'package:sccc_v3/feat/borrow_list/data/repository/local_item_repo_impl.dart';
import 'package:sccc_v3/feat/borrow_list/data/repository/local_supply_repo_impl.dart';
import 'package:sccc_v3/feat/borrow_list/domain/repository/local_equipment_copy_repo.dart';
import 'package:sccc_v3/feat/borrow_list/domain/repository/local_item_repo.dart';
import 'package:sccc_v3/feat/borrow_list/domain/repository/local_supply_repo.dart';
import 'package:sccc_v3/feat/item_list/data/repository/category_repo_impl.dart';
import 'package:sccc_v3/feat/item_list/data/repository/equipment_copy_repo_impl.dart';
import 'package:sccc_v3/feat/item_list/data/repository/supply_repo_impl.dart';
import 'package:sccc_v3/feat/item_list/domain/repository/category_repo.dart';
import 'package:sccc_v3/feat/item_list/domain/repository/equipment_copy_repo.dart';
import 'package:sccc_v3/feat/item_list/domain/repository/supply_repo.dart';
import 'package:sccc_v3/service_locator.dart';

void repositoryLocators() {
  // Register your repositories here
  // Example:
  // getIt.registerLazySingleton<YourRepository>(() => YourRepositoryImpl());

  // Auth repository
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl());

  // supply repository
  getIt.registerSingleton<SupplyRepo>(SupplyRepoImpl());
  getIt.registerSingleton<LocalSupplyRepo>(LocalSupplyRepoImpl());

  // equipment copy repository
  getIt.registerSingleton<EquipmentCopyRepo>(EquipmentCopyRepoImpl());
  getIt.registerSingleton<LocalEquipmentCopyRepo>(LocalEquipmentCopyRepoImpl());

  // category repository
  getIt.registerSingleton<CategoryRepo>(CategoryRepoImpl());

  // borrow list repository
  getIt.registerSingleton<LocalItemRepo>(LocalItemRepoImpl());
}
