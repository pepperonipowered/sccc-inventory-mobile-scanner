

import 'package:sccc_v3/feat/auth/domain/entity/user_entity.dart';

abstract class AuthStates {}


class AuthLoading extends AuthStates {}

class Authenticated extends AuthStates {
  final UserEntity user;
  Authenticated(this.user);
}

class UnAuthenticated extends AuthStates {
  final String? message;
  UnAuthenticated({this.message});
}

class AuthError extends AuthStates {
  final String message;
  AuthError(this.message);
}
