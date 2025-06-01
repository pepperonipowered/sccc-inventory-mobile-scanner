import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sccc_v3/feat/auth/data/model/request/login_req.dart';
import 'package:sccc_v3/feat/auth/data/model/request/register_req.dart';
import 'package:sccc_v3/feat/auth/data/model/user_model.dart';
import 'package:sccc_v3/feat/auth/data/source/auth_api_service.dart';
import 'package:sccc_v3/feat/auth/data/source/auth_local_service.dart';
import 'package:sccc_v3/feat/auth/domain/entity/user_entity.dart';
import 'package:sccc_v3/feat/auth/domain/repository/auth_repo.dart';
import 'package:sccc_v3/service_locator.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<Either<dynamic, UserEntity>> getCurrentUser() async {
    Either result = await getIt<AuthApiService>().getCurrentUser();
    return result.fold((error) => Left(error), (data) async {
      Response response = data;
      var userModel = UserModel.fromMap(response.data);
      var user = userModel.toEntity();
      return Right(user);
    });
  }

  @override
  Future<bool> isUserLoggedIn() async {
    final String? token = await getIt<AuthLocalService>().getToken();
    if (token != null) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  @override
  Future<Either<dynamic, UserEntity>> signInWithEmailAndPassword(LoginReqParams params) async {
    Either result = await getIt<AuthApiService>().signInWithEmailAndPassword(params);
    return result.fold((error) => Left(error), (data) async {
      Response response = data;

      var userModel = UserModel.fromMap(response.data['user']);
      var user = userModel.toEntity();
      // Save token to local storage
      await getIt<AuthLocalService>().setToken(response.data['token']);

      return Right(user);
    });
  }

  @override
  Future<void> signOut() async {
    await getIt<AuthApiService>().signOut();
    await getIt<AuthLocalService>().removeToken();
  }

  @override
  Future<Either<dynamic, UserEntity>> signUpWithEmailAndPassword(RegisterReqParams params) async {
    Either result = await getIt<AuthApiService>().signUpWithEmailAndPassword(params);
    return result.fold((error) => Left(error), (data) async {
      Response response = data;

      var userModel = UserModel.fromMap(response.data['user']);
      var user = userModel.toEntity();
      // Save token to local storage
      await getIt<AuthLocalService>().setToken(response.data['token']);

      return Right(user);
    });
  }
}
