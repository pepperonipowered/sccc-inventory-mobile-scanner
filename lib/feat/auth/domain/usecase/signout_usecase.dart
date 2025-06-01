import 'package:sccc_v3/core/usecase/usecase.dart';
import 'package:sccc_v3/feat/auth/domain/repository/auth_repo.dart';
import 'package:sccc_v3/service_locator.dart';

class SignoutUsecase implements UseCase<void, void> {
  @override
  Future<void> call({dynamic param}) {
    return getIt<AuthRepo>().signOut();
  }
}