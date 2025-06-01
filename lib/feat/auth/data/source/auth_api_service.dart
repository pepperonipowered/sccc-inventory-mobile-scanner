import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:sccc_v3/core/constants/api_base_url.dart';
import 'package:sccc_v3/core/network/dio_client.dart';
import 'package:sccc_v3/feat/auth/data/model/request/login_req.dart';
import 'package:sccc_v3/feat/auth/data/model/request/register_req.dart';
import 'package:sccc_v3/feat/auth/data/source/auth_local_service.dart';
import 'package:sccc_v3/service_locator.dart';

abstract class AuthApiService {
  Future<Either> signInWithEmailAndPassword(LoginReqParams params);
  Future<Either> signUpWithEmailAndPassword(RegisterReqParams params);
  Future<Either> signOut();
  Future<Either> getCurrentUser();
}

class AuthApiServiceImpl implements AuthApiService {
  @override
  Future<Either> getCurrentUser() async {
    try {
      String? token = await getIt<AuthLocalService>().getToken();
      if (token == null) {
        return Left('User is not logged in');
      }
      var response = await getIt<DioClient>().get(
        ApiUrl.getUser,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> signInWithEmailAndPassword(LoginReqParams params) async {
    try {
      var response = await getIt<DioClient>().post(ApiUrl.login, data: params.toJson());
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> signOut() async {
    try {
      String? token = await getIt<AuthLocalService>().getToken();
      getIt<Logger>().d('🔐 Token used: $token');
      var response = await getIt<DioClient>().post(
        ApiUrl.logout,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> signUpWithEmailAndPassword(RegisterReqParams params) async {
    try {
      var response = await getIt<DioClient>().post(ApiUrl.register, data: params.toJson());
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
