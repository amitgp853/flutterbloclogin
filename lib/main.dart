import 'package:fire_login/register/bloc/register_bloc.dart';
import 'package:fire_login/repositories/user_repository.dart';
import 'package:fire_login/view/home_page.dart';
import 'package:fire_login/view/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/bloc/auth_bloc.dart';
import 'login/bloc/login_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  UserRepository _userRepository =
      UserRepository(firebaseAuth: FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(userRepository: _userRepository),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(userRepository: _userRepository),
        ),
        BlocProvider(
          create: (context) => LoginBloc(userRepository: _userRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is UnauthenticateState) {
          return SplashScreen();
        } else if (state is AuthenticateState) {
          return HomePage();
        }
        return Container();
      },
    );
  }
}
