import 'package:dartz/dartz.dart';
import 'package:sccc_v3/feat/auth/data/model/request/login_req.dart';
import 'package:sccc_v3/feat/auth/data/model/request/register_req.dart';
import 'package:sccc_v3/feat/auth/domain/entity/user_entity.dart';

abstract class AuthRepo {
  Future<Either<dynamic, UserEntity>> signInWithEmailAndPassword(LoginReqParams params);
  Future<Either<dynamic, UserEntity>> signUpWithEmailAndPassword(RegisterReqParams params);
  Future<void> signOut();
  Future<Either<dynamic, UserEntity>> getCurrentUser();
  Future<bool> isUserLoggedIn();
}
