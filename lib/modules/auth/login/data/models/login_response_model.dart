import 'package:clean_flutter_poc/modules/auth/login/domain/entities/login_response_item.dart';
import 'package:equatable/equatable.dart';

class LoginResponseModel extends Equatable {
  final String token;
  final String refreshToken;

  LoginResponseModel({
    required this.token,
    required this.refreshToken,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json)
      : token = json['data']['token'],
        refreshToken = json['data']['refreshToken'];

  LoginResponseItem toEntity() => LoginResponseItem(
        token: token,
        refreshToken: refreshToken,
      );

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'token': token,
        'refreshToken': refreshToken,
      }
    };
  }

  @override
  List<Object?> get props => [
        token,
        refreshToken,
      ];
}
