import 'package:flutter/material.dart';
import 'package:tembea/components/rounded_button.dart';
import 'auth/registration_screen.dart';
import 'auth/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: SizedBox(

                    child: Image.asset('assets/images/logo.png'),
                    height: 70,
                  ),
                ),
                const Text(
                  'Tembea',
                  style: TextStyle(
                    fontSize: 45.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
            const SizedBox(
              height: 50.0,
            ),
             RoundedButton(
               buttonName: 'Login',
               color: Colors.green,
               onPressed: (){
                 Navigator.pushNamed(context, LoginScreen.id);
               },
             ),
            RoundedButton(
                buttonName: 'Register',
                color: Colors.lightGreen,
                onPressed: (){
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
            ),
          ],
        ),
      ),
    );
  }
}

