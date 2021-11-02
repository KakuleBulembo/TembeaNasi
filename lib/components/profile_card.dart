import 'package:flutter/material.dart';
import 'package:tembea/constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

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
        children: const [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'kakulebulembo@gmail.com',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Icon(Icons.keyboard_arrow_down)
        ],
      ),
    );
  }
}
