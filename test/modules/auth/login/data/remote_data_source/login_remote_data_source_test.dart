import 'package:clean_flutter_poc/core/failure.dart';
import 'package:clean_flutter_poc/modules/auth/login/data/models/login_response_model.dart';
import 'package:clean_flutter_poc/modules/auth/login/data/remote_data_sources/login_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'dart:convert';
import 'login_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late LoginRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;
  final String testUsername = 'test@example.com';
  final String testPassword = 'password123';
  final LoginResponseModel testLoginResponseModel = LoginResponseModel(
    token: 'testToken',
    refreshToken: 'testRefreshToken',
  );

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = LoginRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('loginUser', () {
    test('should return LoginResponseModel when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async =>
          http.Response(json.encode(testLoginResponseModel.toJson()), 200));

      // act
      final result = await dataSource.loginUser(testUsername, testPassword);

      // assert
      expect(result, equals(testLoginResponseModel));
      verify(mockHttpClient.post(
        Uri.parse(
            'https://72cdf1ad-46cc-4c1e-8e74-4ae6d7dc34bd.mock.pstmn.io/post'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': testUsername, 'password': testPassword}),
      )).called(1);
    });

    test('should throw ServerFailure when the response code is not 200',
        () async {
      // arrange
      when(mockHttpClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Something went wrong', 404));

      // act
      final call = dataSource.loginUser(testUsername, testPassword);

      // assert
      expect(() => call, throwsA(isA<ServerFailure>()));
      verify(mockHttpClient.post(
        Uri.parse(
            'https://72cdf1ad-46cc-4c1e-8e74-4ae6d7dc34bd.mock.pstmn.io/post'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': testUsername, 'password': testPassword}),
      )).called(1);
    });
  });
}
