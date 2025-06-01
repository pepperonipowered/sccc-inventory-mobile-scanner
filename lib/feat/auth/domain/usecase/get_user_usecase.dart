import 'package:dartz/dartz.dart';
import 'package:sccc_v3/core/usecase/usecase.dart';
import 'package:sccc_v3/feat/auth/domain/entity/user_entity.dart';
import 'package:sccc_v3/feat/auth/domain/repository/auth_repo.dart';
import 'package:sccc_v3/service_locator.dart';

class GetUserUsecase implements UseCase<Either<dynamic, UserEntity>, void> {
  @override
  Future<Either<dynamic, UserEntity>> call({dynamic param}) {
    return getIt<AuthRepo>().getCurrentUser();
  }
}
