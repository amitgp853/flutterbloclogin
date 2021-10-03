import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fire_login/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository userRepository;
  RegisterBloc({required this.userRepository}) : super(RegisterInitial()) {
    @override
    Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
      if (event is SignUpButtonPressed) {
        yield RegisterLoading();
        try {
          var user = await userRepository.signUp(event.email, event.password);
          yield RegisterSucceed(user: user!);
        } catch (e) {
          yield RegisterFailed(message: e.toString());
        }
      }
    }
  }
}
