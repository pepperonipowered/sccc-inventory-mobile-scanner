import 'package:dartz/dartz.dart';
import 'package:sccc_v3/core/usecase/usecase.dart';
import 'package:sccc_v3/feat/auth/data/model/request/register_req.dart';
import 'package:sccc_v3/feat/auth/domain/entity/user_entity.dart';
import 'package:sccc_v3/feat/auth/domain/repository/auth_repo.dart';
import 'package:sccc_v3/service_locator.dart';

class RegisterUsecase implements UseCase<Either<dynamic, UserEntity>, RegisterReqParams> {
  @override
  Future<Either<dynamic, UserEntity>> call({RegisterReqParams? param}) {
    return getIt<AuthRepo>().signUpWithEmailAndPassword(param!);
  }
}