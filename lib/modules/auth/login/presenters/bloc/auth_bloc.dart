import 'package:clean_flutter_poc/modules/auth/login/domain/entities/login_response_item.dart';
import 'package:clean_flutter_poc/modules/auth/login/domain/usecases/login_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/transformers.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser _loginUser;
// This is LoginUser usecase we created inside domain/usecases folder

  AuthBloc(this._loginUser) : super(AuthEmpty()) {
// The default state for this whole bloc is AuthEmpty

    on<OnLoginEvent>(
// The bloc will reach here when the OnLoginEvent is triggered from UI
      (event, emit) async {
        final username = event.username;
        final password = event.password;
// By using event. we will access the parameters taken by the event from UI

        emit(AuthLoading());
// emit keyword in Flutter Bloc is used to send or "emit"
// a new state to the UI or any other listeners.

        final result = await _loginUser.execute(username, password);
// Here we are running the execute method of the
        result.fold(
// We are checking the result of the execute method
          (failure) {
            // If the result is a failure we are emitting AuthError
            emit(AuthError(failure.message));
          },
          (data) {
            // If the result is a success we are emitting LoginHasData
            emit(LoginHasData(data));
          },
        );
      },
      transformer: debounce(Duration(milliseconds: 500)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
