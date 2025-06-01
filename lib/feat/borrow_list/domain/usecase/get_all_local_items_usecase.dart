import 'package:sccc_v3/core/usecase/usecase.dart';
import 'package:sccc_v3/feat/borrow_list/domain/entities/local_item_entity.dart';
import 'package:sccc_v3/feat/borrow_list/domain/repository/local_item_repo.dart';
import 'package:sccc_v3/service_locator.dart';

class GetAllLocalItemsUsecase implements UseCase<List<LocalItemEntity>, dynamic> {
  @override
  Future<List<LocalItemEntity>> call({dynamic param}) {
    return getIt<LocalItemRepo>().getAllItems();
  }
}
