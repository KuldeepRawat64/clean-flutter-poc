import 'package:flutter_test/flutter_test.dart';
import 'package:clean_flutter_poc/modules/auth/login/data/models/login_response_model.dart';
import 'package:clean_flutter_poc/modules/auth/login/domain/entities/login_response_item.dart';

void main() {
  final Map<String, dynamic> jsonMap = {
    'data': {
      'token': 'testToken',
      'refreshToken': 'testRefreshToken',
    }
  };

  final LoginResponseModel loginResponseModel = LoginResponseModel(
    token: 'testToken',
    refreshToken: 'testRefreshToken',
  );

  test('should be a subclass of LoginResponseItem entity', () {
    expect(loginResponseModel.toEntity(), isA<LoginResponseItem>());
  });

  test('fromJson should return a valid model', () {
    final result = LoginResponseModel.fromJson(jsonMap);
    expect(result, loginResponseModel);
  });

  test('toJson should return a valid JSON map', () {
    final result = loginResponseModel.toJson();
    expect(result, jsonMap);
  });

  test('toEntity should return a valid LoginResponseItem entity', () {
    final result = loginResponseModel.toEntity();
    expect(result, isA<LoginResponseItem>());
    expect(result.token, loginResponseModel.token);
    expect(result.refreshToken, loginResponseModel.refreshToken);
  });
}
