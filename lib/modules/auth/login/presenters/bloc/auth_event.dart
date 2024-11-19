part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class OnLoginEvent extends AuthEvent {
  // This event will trigger on login button click
  // And the entered username and password will be passed to this event
  final String username;
  final String password;

  OnLoginEvent(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}
