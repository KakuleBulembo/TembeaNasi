import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tembea/components/inputField/input_password_field.dart';
import 'package:tembea/components/inputField/rounded_input_field.dart';
import 'package:tembea/components/rounded_elevated_button.dart';
import 'package:tembea/components/show_toast.dart';
import 'package:tembea/constants.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tembea/screens/user/interest.dart';
import 'registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tembea/screens/admin/admin_screens/dashboard_screen.dart';
import 'package:tembea/screens/user/user_home.dart';

 

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  bool role = false;
  bool showSpinner = false;
  bool obscurePass = true;
  Map ? interest;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: showSpinner,
      opacity: 0.5,
      color: Colors.green,
      progressIndicator: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.green),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(MediaQuery.of(context).viewInsets.bottom==0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                            tag: 'logo',
                            child: SizedBox(
                              height: 100.0,
                              child: Image.asset('assets/images/logo.png'),
                            )
                        ),
                    ],
                       ),
                            const SizedBox(
                              height: 18.0,
                            ),
                            RoundedInputField(
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'Please enter the email';
                                }
                                return null;
                              },
                              hintText: 'Enter Email',
                              icon: Icons.email,
                              onChanged: (value){
                                email = value;
                              },
                            ),
                    const SizedBox(
                      height: 18.0,
                    ),
                    InputPasswordField(
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter the email';
                        }
                        return null;
                      },
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
                    const SizedBox(
                      height: 18.0,
                    ),
                    RoundedElevatedButton(
                        label: 'Login',
                        color: Colors.green,
                        onPressed: ()async{
                          try{
                            if(_formKey.currentState!.validate()){
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
                              if(role == true){
                                setState(() {
                                  showSpinner = false;
                                });
                                Navigator.pushReplacementNamed(context, DashboardScreen.id);
                              }
                              else if(role == false){
                                final DocumentSnapshot snapshot =
                                await FirebaseFirestore
                                    .instance.collection("users")
                                    .doc(currentUser.uid).get();
                                interest = snapshot['interest'];
                                if(interest!.containsValue(true)){
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  Navigator.pushReplacementNamed(context, UserHome.id);
                                }
                                else{
                                  Navigator.pushReplacementNamed(context, Interest.id);
                                }
                              }
                            }
                          }
                          catch(e){
                            setState(() {
                              showSpinner = false;
                            });
                            showToast(
                                message: 'Wrong Credentials',
                                color: Colors.red
                            );
                            print(e);
                          }
                        }
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
          ),
        ),
      ),
    );
  }
}
