import 'package:equatable/equatable.dart';

class LoginResponseItem extends Equatable {
  final String token;
  final String refreshToken;

  LoginResponseItem({
    required this.token,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [
        token,
        refreshToken,
      ];
}
