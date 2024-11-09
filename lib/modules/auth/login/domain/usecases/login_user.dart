import 'package:clean_flutter_poc/core/failure.dart';
import 'package:clean_flutter_poc/modules/auth/login/domain/entities/login_response_item.dart';
import 'package:clean_flutter_poc/modules/auth/login/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUser {
  final LoginRepository _loginRepository;
  LoginUser(this._loginRepository);

  Future<Either<Failure, LoginResponseItem>> execute(
      String email, String password) async {
    return await _loginRepository.login_user(email, password);
  }
}
