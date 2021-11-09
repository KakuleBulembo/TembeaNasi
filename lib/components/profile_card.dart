import 'package:flutter/material.dart';
import 'package:tembea/constants.dart';
import 'responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileCard extends StatefulWidget {
   const ProfileCard({
    Key? key,
  }) : super(key: key);


  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  String? email = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration:  BoxDecoration(
        color: kSecondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children:  [
          if(!Responsive.isMobile(context))
           Padding(
            padding: const  EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              email != null ? email! : 'No email',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const Icon(Icons.keyboard_arrow_down)
        ],
      ),
    );
  }
}
