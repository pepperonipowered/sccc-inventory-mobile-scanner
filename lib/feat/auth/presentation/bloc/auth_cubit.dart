import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sccc_v3/feat/auth/data/model/request/login_req.dart';
import 'package:sccc_v3/feat/auth/data/model/request/register_req.dart';
import 'package:sccc_v3/feat/auth/domain/entity/user_entity.dart';
import 'package:sccc_v3/feat/auth/domain/usecase/check_user_usecase.dart';
import 'package:sccc_v3/feat/auth/domain/usecase/get_user_usecase.dart';
import 'package:sccc_v3/feat/auth/domain/usecase/login_usecase.dart';
import 'package:sccc_v3/feat/auth/domain/usecase/register_usecase.dart';
import 'package:sccc_v3/feat/auth/domain/usecase/signout_usecase.dart';
import 'package:sccc_v3/feat/auth/presentation/bloc/auth_states.dart';
import 'package:sccc_v3/service_locator.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthLoading());

  UserEntity? _user;

  UserEntity? get user => _user;

  final RegisterUsecase _registerUsecase = getIt<RegisterUsecase>();
  final LoginUsecase _loginUsecase = getIt<LoginUsecase>();
  final GetUserUsecase _getUserUsecase = getIt<GetUserUsecase>();
  final CheckUserUsecase _checkUserUsecase = getIt<CheckUserUsecase>();
  final SignoutUsecase _signoutUsecase = getIt<SignoutUsecase>();

  Future<void> signUpWithEmailAndPassword(RegisterReqParams params) async {
    emit(AuthLoading());
    try {
      final user = await _registerUsecase.call(param: params);
      user.fold(
        (error) {
          emit(AuthError(error.toString()));
          emit(UnAuthenticated(message: error.toString())); // Add this
        },
        (user) {
          _user = user;
          emit(Authenticated(user));
        },
      );
    } catch (error) {
      emit(AuthError(error.toString()));
    }
  }

  Future<void> signInWithEmailAndPassword(LoginReqParams params) async {
    emit(AuthLoading());
    try {
      final user = await _loginUsecase.call(param: params);
      user.fold(
        (error) {
          emit(AuthError(error.toString()));
          emit(UnAuthenticated(message: error.toString()));
        },
        (user) {
          _user = user;
          emit(Authenticated(user));
        },
      );
    } catch (error) {
      emit(AuthError(error.toString()));
    }
  }

  Future<void> checkAuth() async {
    emit(AuthLoading());
    bool isUserLoggedIn = await _checkUserUsecase.call();
    if (isUserLoggedIn) {
      final result = await _getUserUsecase.call();
      result.fold((error) => emit(UnAuthenticated(message: error.toString())), (user) {
        _user = user;
        emit(Authenticated(user));
      });
    } else {
      emit(UnAuthenticated());
    }
  }

  Future<void> signOut() async {
    try {
      await _signoutUsecase.call();
      _user = null;
      emit(UnAuthenticated());
    } catch (error) {
      emit(AuthError(error.toString()));
    }
  }
}
