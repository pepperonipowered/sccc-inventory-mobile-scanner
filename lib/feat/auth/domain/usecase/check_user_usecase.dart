import 'package:sccc_v3/core/usecase/usecase.dart';
import 'package:sccc_v3/feat/auth/domain/repository/auth_repo.dart';
import 'package:sccc_v3/service_locator.dart';

class CheckUserUsecase implements UseCase<bool, void> {
  @override
  Future<bool> call({dynamic param}) {
    return getIt<AuthRepo>().isUserLoggedIn();
  }
}
