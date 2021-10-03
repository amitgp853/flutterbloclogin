import 'package:fire_login/login/bloc/login_bloc.dart';
import 'package:fire_login/view/signupscreen.dart';
import 'package:fire_login/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page.dart';

class SignInScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late LoginBloc loginBloc;

  @override
  Widget build(BuildContext context) {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context);
          },
        ),
        title: Text('Sign In'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSucceed) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => HomePage()));
                  }
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                  if (state is LoginLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is LoginFailed) {
                    return buildError(state.message);
                  } else if (state is LoginSucceed) {
                    emailController.text = '';
                    passwordController.text = '';
                    return Container();
                  }
                  return Container();
                }),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'Email',
                textInputType: TextInputType.emailAddress,
                obscureText: false,
                controller: emailController,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'Password',
                textInputType: TextInputType.visiblePassword,
                obscureText: true,
                controller: passwordController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        loginBloc.add(SignInButtonPressed(
                            email: emailController.text,
                            password: passwordController.text));
                      },
                      child: Text('Sign In')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SignUpScreen(),
                          ),
                        );
                      },
                      child: Text('Sign Up')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildError(String message) {
    return Text(
      message,
      style: TextStyle(color: Colors.red),
    );
  }
}
