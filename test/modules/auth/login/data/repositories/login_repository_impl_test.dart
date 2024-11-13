import 'package:clean_flutter_poc/core/failure.dart';
import 'package:clean_flutter_poc/modules/auth/login/data/models/login_response_model.dart';
import 'package:clean_flutter_poc/modules/auth/login/data/remote_data_sources/login_remote_data_source.dart';
import 'package:clean_flutter_poc/modules/auth/login/data/repositories/login_repository_impl.dart';
import 'package:clean_flutter_poc/modules/auth/login/domain/entities/login_response_item.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'login_repository_impl_test.mocks.dart';

@GenerateMocks([LoginRemoteDataSource])
void main() {
  late LoginRepositoryImpl repository;
  late MockLoginRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockLoginRemoteDataSource();
    repository = LoginRepositoryImpl(mockRemoteDataSource);
  });

  group('login_user', () {
    final String testEmail = 'test@example.com';
    final String testPassword = 'password123';
    final LoginResponseItem testLoginResponseItem =
        LoginResponseItem(token: 'testToken', refreshToken: 'testRefreshToken');

    test(
        'should return LoginResponseItem when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.loginUser(testEmail, testPassword)).thenAnswer(
          (_) async => LoginResponseModel(
              token: 'testToken', refreshToken: 'testRefreshToken'));

      // act
      final result = await repository.login_user(testEmail, testPassword);

      // assert
      expect(result, Right(testLoginResponseItem));
      verify(mockRemoteDataSource.loginUser(testEmail, testPassword));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test(
        'should return ServerFailure when the call to remote data source fails',
        () async {
      // arrange
      when(mockRemoteDataSource.loginUser(testEmail, testPassword))
          .thenThrow(ServerFailure('Failed to log in'));

      // act
      final result = await repository.login_user(testEmail, testPassword);

      // assert
      expect(result, Left(ServerFailure('Failed to log in')));
      verify(mockRemoteDataSource.loginUser(testEmail, testPassword));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ServerFailure when an unknown error occurs', () async {
      // arrange
      when(mockRemoteDataSource.loginUser(testEmail, testPassword))
          .thenThrow(Exception('Unknown error'));

      // act
      final result = await repository.login_user(testEmail, testPassword);

      // assert
      expect(result, Left(ServerFailure('Unknown error')));
      verify(mockRemoteDataSource.loginUser(testEmail, testPassword));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
