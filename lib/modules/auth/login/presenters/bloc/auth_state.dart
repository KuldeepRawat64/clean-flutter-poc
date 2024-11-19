part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthEmpty extends AuthState {}
// This is our Default state for AuthBloc
// Means for Every Event inside this bloc will be have AuthEmpty as default

class AuthLoading extends AuthState {}
// This is our loading state whenever we will execute our usecase

class AuthError extends AuthState {
// This is our error state from API call No data found, Connection error etc.

  final String message;
// message is our object for showing the error to use user in UI screens

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class LoginHasData extends AuthState {
// This state is for successful data retrieval of LoginResponseItem object
// and nothing else
  final LoginResponseItem result;

  LoginHasData(this.result);

  @override
  List<Object?> get props => [result];
}
