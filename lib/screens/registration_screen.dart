import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:tembea/components/rounded_button.dart';
import 'package:tembea/constants.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static const String id =  'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String username;
  late String email;
  late String password;
  late String confirmPassword;
  final _auth = FirebaseAuth.instance;
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding:const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if(MediaQuery.of(context).viewInsets.bottom==0)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 150,
                        child: Image.asset('assets/images/logo.png'),
                    ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
             TextField(
              textAlign: TextAlign.center,
              style:const TextStyle(
                color: Colors.white,
              ),
              onChanged: (value){
                username = value;
              },
               decoration: kInputDecoration.copyWith(
                 hintText: 'Enter username',
               ),
            ),
            const SizedBox(
              height: 20.0,
            ),

            TextField(
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
              onChanged: (value){
                email = value;
              },
              decoration: kInputDecoration.copyWith(
                hintText: 'Enter email',
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              style: const TextStyle(
                color: Colors.white,
              ),
              onChanged: (value){
                password = value;
              },
              decoration: kInputDecoration.copyWith(
                hintText: 'Enter password',
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              style: const TextStyle(
                color: Colors.white,
              ),
              onChanged: (value){
                confirmPassword = value;
              },
              decoration: kInputDecoration.copyWith(
                hintText: 'Confirm password',
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            RoundedButton(
              buttonName: 'Register',
              color: Colors.lightGreen,
              onPressed: () async{
                try{
                  if(confirmPassword == password){
                    final user = await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) async{
                      User? currentUser = FirebaseAuth.instance.currentUser;
                      await FirebaseFirestore.instance.collection("users").doc(currentUser!.uid).set({
                        'uid' : currentUser.uid,
                        'username': username,
                        'role' : isAdmin,
                      });
                    });
                    if(user != null){
                      print('User registered');
                    }
                  }
                  else{
                    print('Password does not match');
                  }
                }
                catch(e){
                  print (e);
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SignInButton(
            Buttons.Google,
            text: 'Sign Up with Google',
            onPressed: (){},
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    'Already have an account?',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: const Text(
                        'Sign In',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
