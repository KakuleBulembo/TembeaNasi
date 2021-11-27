import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:tembea/components/inputField/input_password_field.dart';
import 'package:tembea/components/inputField/rounded_input_field.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tembea/components/rounded_elevated_button.dart';
import 'package:tembea/components/show_toast.dart';
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
  bool obscurePass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                        tag: 'logo',
                        child: SizedBox(
                          height: 100,
                            child: Image.asset('assets/images/logo.png'),
                        ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                 RoundedInputField(
                     hintText: 'Enter Username',
                     icon: Icons.person,
                     onChanged: (value){
                       username = value;
                     }
                 ),
                RoundedInputField(
                    hintText: 'Enter Email',
                    icon: Icons.email,
                    onChanged: (value){
                      email = value;
                    }
                ),
                InputPasswordField(
                  hintText: 'Enter Password',
                  obscureText: obscurePass,
                  onTap: () {
                    setState(() {
                      if(obscurePass == true){
                        obscurePass = false;
                      }
                      else{
                        obscurePass = true;
                      }
                    });
                  },
                  onChanged: (value) {
                    password = value;
                  },
                ),
                InputPasswordField(
                  hintText: 'Confirm Password',
                  obscureText: obscurePass,
                  onTap: () {
                    setState(() {
                      if(obscurePass == true){
                        obscurePass = false;
                      }
                      else{
                        obscurePass = true;
                      }
                    });
                  },
                  onChanged: (value) {
                    confirmPassword = value;
                  },
                ),
                RoundedElevatedButton(
                    label: 'Register',
                  color: Colors.lightGreen,
                    onPressed: () async{
                      try{
                        if(confirmPassword == password){
                          await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) async{
                            User? currentUser = FirebaseAuth.instance.currentUser;
                            await FirebaseFirestore.instance.collection("users").doc(currentUser!.uid).set({
                              'uid' : currentUser.uid,
                              'username': username,
                              'role' : isAdmin,
                              'email': currentUser.email,
                              'ts': DateTime.now(),
                            });
                          });
                          Navigator.pushReplacementNamed(context, LoginScreen.id);
                        }
                        else{
                          showToast(
                              message: 'Password does not match',
                              color: Colors.red);
                        }
                      }
                      catch(e){
                        showToast(
                            message: e.toString(),
                            color: Colors.red);
                      }
                    },
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
        ),
      ),
    );
  }
}