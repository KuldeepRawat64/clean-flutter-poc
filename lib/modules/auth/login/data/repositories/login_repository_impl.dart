import 'package:clean_flutter_poc/core/failure.dart';
import 'package:clean_flutter_poc/modules/auth/login/data/remote_data_sources/login_remote_data_source.dart';
import 'package:clean_flutter_poc/modules/auth/login/domain/entities/login_response_item.dart';
import 'package:clean_flutter_poc/modules/auth/login/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource dataSource;

  LoginRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, LoginResponseItem>> login_user(
      String username, String password) async {
    try {
      final user = await dataSource.loginUser(username, password);
      return Right(user.toEntity());
    } on ServerFailure {
      return Left(ServerFailure('Failed to log in'));
    } catch (e) {
      return Left(ServerFailure('Unknown error'));
    }
  }
}
