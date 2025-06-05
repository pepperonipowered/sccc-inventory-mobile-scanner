import 'package:sccc_v3/core/usecase/usecase.dart';
import 'package:sccc_v3/feat/borrow_list/domain/entities/local_item_entity.dart';
import 'package:sccc_v3/feat/borrow_list/domain/repository/local_item_repo.dart';
import 'package:sccc_v3/service_locator.dart';

class CreateLocalItemUsecase implements UseCase<void, LocalItemEntity> {
  @override
  Future<void> call({LocalItemEntity? param}) {
    return getIt<LocalItemRepo>().addItem(param!);
  }
}
