import 'package:clean_flutter_poc/modules/auth/login/domain/entities/login_response_item.dart';
import 'package:clean_flutter_poc/modules/auth/login/presenters/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthState', () {
    test('AuthEmpty supports value comparison', () {
      expect(AuthEmpty(), AuthEmpty());
    });

    test('AuthLoading supports value comparison', () {
      expect(AuthLoading(), AuthLoading());
    });

    test('AuthError supports value comparison', () {
      expect(AuthError('Error message'), AuthError('Error message'));
    });

    test('AuthError props are correct', () {
      expect(AuthError('Error message').props, ['Error message']);
    });

    test('LoginHasData supports value comparison', () {
      final loginResponseItem =
          LoginResponseItem(token: 'token', refreshToken: 'refreshToken');
      expect(LoginHasData(loginResponseItem), LoginHasData(loginResponseItem));
    });

    test('LoginHasData props are correct', () {
      final loginResponseItem =
          LoginResponseItem(token: 'token', refreshToken: 'refreshToken');
      expect(LoginHasData(loginResponseItem).props, [loginResponseItem]);
    });
  });
}
