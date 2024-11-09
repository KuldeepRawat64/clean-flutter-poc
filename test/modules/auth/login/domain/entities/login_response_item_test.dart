import 'package:flutter_test/flutter_test.dart';
import 'package:clean_flutter_poc/modules/auth/login/domain/entities/login_response_item.dart';

void main() {
  group('LoginResponseItem', () {
    test('props are correct', () {
      final loginResponseItem = LoginResponseItem(
        token: 'test_token',
        refreshToken: 'test_refresh_token',
      );

      expect(loginResponseItem.props, ['test_token', 'test_refresh_token']);
    });

    test('instances with same values are equal', () {
      final loginResponseItem1 = LoginResponseItem(
        token: 'test_token',
        refreshToken: 'test_refresh_token',
      );

      final loginResponseItem2 = LoginResponseItem(
        token: 'test_token',
        refreshToken: 'test_refresh_token',
      );

      expect(loginResponseItem1, loginResponseItem2);
    });

    test('instances with different values are not equal', () {
      final loginResponseItem1 = LoginResponseItem(
        token: 'test_token_1',
        refreshToken: 'test_refresh_token_1',
      );

      final loginResponseItem2 = LoginResponseItem(
        token: 'test_token_2',
        refreshToken: 'test_refresh_token_2',
      );

      expect(loginResponseItem1, isNot(loginResponseItem2));
    });
  });
}
