class LoginResponseItem {
  final String token;
  final String refreshToken;

  LoginResponseItem({
    required this.token,
    required this.refreshToken,
  });

  factory LoginResponseItem.fromJson(Map<String, dynamic> json) {
    return LoginResponseItem(
      token: json['token'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'refreshToken': refreshToken,
    };
  }
}
