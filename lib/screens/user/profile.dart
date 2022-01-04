import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tembea/components/card_info.dart';
import 'package:tembea/components/rounded_view_details_button.dart';
import 'package:tembea/screens/auth/login_screen.dart';


class Profile extends StatefulWidget {
  const Profile({
    Key? key
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  final user = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: user,
        builder: (context, AsyncSnapshot snapshot){
           if(snapshot.hasData){
             final currentUser = snapshot.data.data();
             return Column(
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     Text(
                         'Logout ${currentUser['username']}',
                       style: GoogleFonts.aladin(
                         textStyle:const TextStyle(
                           fontSize: 30,
                         )
                       ),
                     ),
                     const SizedBox(
                       width: 10,
                     ),
                     GestureDetector(
                       onTap: (){
                         _auth.signOut();
                         Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (r) => false);
                       },
                       child: const Icon(
                         IconData(0xe3b3, fontFamily: 'MaterialIcons'),
                         color: Colors.green,
                         size: 30,
                       ),
                     ),
                   ],
                 ),
                 SizedBox(
                   height: MediaQuery.of(context).size.height * 0.1,
                 ),
                 CardInfo(
                     title: 'Contact Info',
                     label: 'Email',
                     data: currentUser['email'],
                 ),
                 SizedBox(
                   height: MediaQuery.of(context).size.height * 0.03,
                 ),
                 CardInfo(
                   title: 'Basic Info',
                   label: 'Name',
                   data: currentUser['username'],
                 ),
                 SizedBox(
                   height: MediaQuery.of(context).size.height * 0.1,
                 ),
                 RoundedViewDetailsButton(
                     title: 'Edit Profile',
                     onPressed: (){}
                 ),
               ],
             );
           }
           else{
             return const CircularProgressIndicator(
               valueColor: AlwaysStoppedAnimation(Colors.green),
             );
           }
      }
    );
  }
}

