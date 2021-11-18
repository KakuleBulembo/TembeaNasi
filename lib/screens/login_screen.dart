import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tembea/components/rounded_button.dart';
import 'package:tembea/constants.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tembea/screens/admin/dashboard_screen.dart';
import 'package:tembea/screens/user/user_home.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
 

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  bool role = false;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ModalProgressHUD(
          color: Colors.blue,
          inAsyncCall: showSpinner,
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
                        height: 150.0,
                        child: Image.asset('assets/images/logo.png'),
                      )
                  ),
              ],
                 ),
                      const SizedBox(
                        height: 48.0,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value){
                          email = value;
                        },
                        decoration: kInputDecoration.copyWith(
                          hintText: 'Enter email',
                        ),
                      ),
              const SizedBox(
                height: 48.0,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                ),
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value){
                  password = value;
                },
                decoration: kInputDecoration.copyWith(
                  hintText: 'Enter password',
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),

              RoundedButton(
                  buttonName: 'Login',
                  color: Colors.green,
                  onPressed: () async{
                    try{
                      setState(() {
                        showSpinner = true;
                      });
                      await _auth.signInWithEmailAndPassword(email: email, password: password);
                      User? currentUser = _auth.currentUser;
                      final DocumentSnapshot snap =
                      await FirebaseFirestore
                          .instance.collection("users")
                          .doc(currentUser!.uid).get();
                      role = snap['role'];
                      if(currentUser != null){
                        if(role == true){
                          setState(() {
                            showSpinner = false;
                          });
                          Navigator.pushReplacementNamed(context, DashboardScreen.id);
                        }
                        else if(role == false){
                          setState(() {
                            showSpinner = false;
                          });
                          Navigator.pushReplacementNamed(context, UserHome.id);
                        }
                      }
                      else{
                        print('Cannot connect  connect');
                      }
                    }
                    catch(e){
                      print(e);
                    }
                  },

              ),
              const SizedBox(
                height: 48,
              ),
               SignInButton(
                   Buttons.Google,
                   text: 'Sign In with Google',
                   onPressed: (){},
               ),
              const SizedBox(
                height: 10.0,
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                    const Text(
                      'You do not have an account ?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                      child: const Text(
                        'Sign Up',
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
    );
  }
}
