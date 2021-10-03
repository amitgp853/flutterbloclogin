import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fire_login/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository userRepository;
  AuthBloc({required this.userRepository}) : super(AuthInitial()) {
    @override
    Stream<AuthState> mapEventToState(
      AuthEvent event,
    ) async* {
      yield UnauthenticateState();
      if (event is AppLoaded) {
        try {
          var isSignedIn = await userRepository.isSignedIn();
          if (isSignedIn) {
            var user = await userRepository.getCurrentUser();
            yield AuthenticateState(user: user!);
          } else
            yield UnauthenticateState();
        } catch (e) {
          UnauthenticateState();
        }
      }
    }
  }
}
