import 'package:clean_flutter_poc/modules/auth/login/presenters/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthEvent', () {
    test('OnLoginEvent props should contain username and password', () {
      // arrange
      const username = 'testUser';
      const password = 'testPassword';
      final event = OnLoginEvent(username, password);

      // assert
      expect(event.props, [username, password]);
    });

    test(
        'OnLoginEvent should be equal to another OnLoginEvent with same values',
        () {
      // arrange
      const username = 'testUser';
      const password = 'testPassword';
      final event1 = OnLoginEvent(username, password);
      final event2 = OnLoginEvent(username, password);

      // assert
      expect(event1, event2);
    });

    test(
        'OnLoginEvent should not be equal to another OnLoginEvent with different values',
        () {
      // arrange
      final event1 = OnLoginEvent('user1', 'password1');
      final event2 = OnLoginEvent('user2', 'password2');

      // assert
      expect(event1, isNot(event2));
    });
  });
}
