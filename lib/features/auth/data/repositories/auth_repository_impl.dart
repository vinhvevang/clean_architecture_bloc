import 'package:bloc_nearly_complete/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  bool login(int tax, String username, String password) {
    return tax == 11111 && username == 'demo' && password == '123456';
  }
}
