import 'package:clean_flutter_poc/core/failure.dart';
import 'package:clean_flutter_poc/modules/auth/login/domain/entities/login_response_item.dart';
import 'package:clean_flutter_poc/modules/auth/login/domain/usecases/login_user.dart';
import 'package:clean_flutter_poc/modules/auth/login/presenters/bloc/auth_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'auth_bloc_test.mocks.dart';

@GenerateMocks([LoginUser])
void main() {
  late AuthBloc authBloc;
  late MockLoginUser mockLoginUser;

  setUp(() {
    mockLoginUser = MockLoginUser();
    authBloc = AuthBloc(mockLoginUser);
  });

  test('initial state should be AuthEmpty', () {
    expect(authBloc.state, AuthEmpty());
  });

  group('OnLoginEvent', () {
    final String testEmail = 'test@example.com';
    final String testPassword = 'password123';
    final LoginResponseItem testLoginResponseItem =
        LoginResponseItem(token: 'testToken', refreshToken: 'testRefreshToken');

    test('should emit [AuthLoading, LoginHasData] when login is successful',
        () async {
      // arrange
      when(mockLoginUser.execute(testEmail, testPassword))
          .thenAnswer((_) async => Right(testLoginResponseItem));

      // assert later
      final expected = [
        AuthLoading(),
        LoginHasData(testLoginResponseItem),
      ];
      expectLater(authBloc.stream, emitsInOrder(expected));

      // act
      authBloc.add(OnLoginEvent(testEmail, testPassword));
    });

    test('should emit [AuthLoading, AuthError] when login fails', () async {
      // arrange
      final ServerFailure testFailure = ServerFailure('Login failed');
      when(mockLoginUser.execute(testEmail, testPassword))
          .thenAnswer((_) async => Left(testFailure));

      // assert later
      final expected = [
        AuthLoading(),
        AuthError(testFailure.message),
      ];
      expectLater(authBloc.stream, emitsInOrder(expected));

      // act
      authBloc.add(OnLoginEvent(testEmail, testPassword));
    });
  });
}
