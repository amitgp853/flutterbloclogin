import 'package:fire_login/view/signinscreen.dart';
import 'package:fire_login/view/signupscreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                height: 250,
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => SignInScreen(),
                            ),
                          );
                        },
                        child: Text('Sign In')),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => SignUpScreen(),
                            ),
                          );
                        },
                        child: Text('Sign Up')),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Join by Sign In or Sign Up'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
