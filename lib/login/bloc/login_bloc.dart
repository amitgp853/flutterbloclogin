import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fire_login/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;
  LoginBloc({required this.userRepository}) : super(LoginInitial()) {
    @override
    Stream<LoginState> mapEventToState(LoginEvent event) async* {
      if (event is SignInButtonPressed) {
        yield LoginLoading();

        try {
          var user = await userRepository.signIn(event.email, event.password);
          yield LoginSucceed(user: user!);
        } catch (e) {
          yield LoginFailed(message: e.toString());
        }
      }
    }
  }
}
