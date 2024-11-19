import 'dart:io';

import 'package:clean_flutter_poc/modules/auth/login/domain/entities/login_response_item.dart';
import 'package:clean_flutter_poc/modules/auth/login/presenters/bloc/auth_bloc.dart';
import 'package:clean_flutter_poc/modules/auth/login/presenters/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class FakeAuthEvent extends Fake implements AuthEvent {}

class FakeAuthState extends Fake implements AuthState {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUpAll(() async {
    HttpOverrides.global = null;
    registerFallbackValue(FakeAuthEvent());
    registerFallbackValue(FakeAuthState());

    final di = GetIt.instance;
    di.registerFactory(() => mockAuthBloc);
  });

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });
  final tLoginresponse = LoginResponseItem(
    token: 'token',
    refreshToken: 'refreshToken',
  );

  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<AuthBloc>(
        create: (context) => mockAuthBloc,
        child: body,
      ),
    );
  }

  testWidgets(
    'login button should trigger state to change from empty to loading',
    (WidgetTester tester) async {
      // arrange
      when(() => mockAuthBloc.state).thenReturn(AuthEmpty());

      // act
      await tester.pumpWidget(_makeTestableWidget(LoginPage()));
      await tester.pump(); // Ensure the widget tree is built
      await tester.enterText(find.byType(TextFormField).at(0), 'kuldeeprwt64');
      await tester.enterText(find.byType(TextFormField).at(1), 'Pass@123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // assert
      verify(() => mockAuthBloc.add(OnLoginEvent('kuldeeprwt64', 'Pass@123')))
          .called(1);
      expect(find.byType(ElevatedButton), equals(findsOneWidget));
    },
  );

  testWidgets(
    'should show progress indicator when state is loading',
    (WidgetTester tester) async {
      // arrange
      when(() => mockAuthBloc.state).thenReturn(AuthLoading());

      // act
      await tester.pumpWidget(_makeTestableWidget(LoginPage()));

      // assert
      expect(find.byType(CircularProgressIndicator), equals(findsOneWidget));
    },
  );

  testWidgets(
    'should show widget contain weather data when state is has data',
    (WidgetTester tester) async {
      // arrange
      when(() => mockAuthBloc.state).thenReturn(LoginHasData(tLoginresponse));

      // act
      await tester.pumpWidget(_makeTestableWidget(LoginPage()));
      await tester.runAsync(() async {
        final HttpClient client = HttpClient();
        await client.getUrl(Uri.parse(
            'https://72cdf1ad-46cc-4c1e-8e74-4ae6d7dc34bd.mock.pstmn.io/post'));
      });
      await tester.pumpAndSettle();

      // assert
      expect(find.byKey(Key('login_data')), equals(findsOneWidget));
    },
  );
}
