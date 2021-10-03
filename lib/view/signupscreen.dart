import 'package:fire_login/register/bloc/register_bloc.dart';
import 'package:fire_login/view/home_page.dart';
import 'package:fire_login/view/signinscreen.dart';
import 'package:fire_login/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late RegisterBloc registerBloc;

  @override
  Widget build(BuildContext context) {
    registerBloc = BlocProvider.of<RegisterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context);
          },
        ),
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocListener<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSucceed) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => HomePage()));
                  }
                },
                child: BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                  if (state is RegisterLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is RegisterFailed) {
                    return buildError(state.message);
                  } else if (state is RegisterSucceed) {
                    emailController.text = '';
                    passwordController.text = '';
                    return Container();
                  }
                  return Container();
                }),
              ),
              Text('Fill in the application form'),
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
                        registerBloc.add(SignUpButtonPressed(
                            email: emailController.text,
                            password: passwordController.text));
                      },
                      child: Text('Sign Up')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SignInScreen(),
                          ),
                        );
                      },
                      child: Text('Sign In')),
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
