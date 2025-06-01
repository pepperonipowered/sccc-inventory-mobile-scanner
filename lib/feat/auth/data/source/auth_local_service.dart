import 'package:drift/drift.dart';
import 'package:sccc_v3/core/database/database.dart';
import 'package:sccc_v3/service_locator.dart';

abstract class AuthLocalService {
  Future<String?> getToken();
  Future<void> setToken(String token);
  Future<void> removeToken();
}

class AuthLocalServiceImpl implements AuthLocalService {
  final AppDatabase _db = getIt<AppDatabase>();

  @override
  Future<String?> getToken() async {
    final result = await _db.select(_db.localUser).getSingleOrNull();
    return result?.token;
  }

  @override
  Future<void> removeToken() async {
    await _db.delete(_db.localUser).go();
  }

  @override
  Future<void> setToken(String token) async {
    await _db.into(_db.localUser).insertOnConflictUpdate(LocalUserCompanion.insert(id: Value(1), token: token));
  }
}
