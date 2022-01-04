import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class CardInfo extends StatelessWidget {
  const CardInfo({
    Key? key,
    required this.title,
    required this.label,
    required this.data,
  }) : super(key: key);
  final String title;
  final String label;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kSecondaryColor,
      shadowColor: kSecondaryColor,
      elevation: 0.5,
      shape:const RoundedRectangleBorder(
        side: BorderSide(color: kSecondaryColor, width: 1),
        borderRadius: BorderRadius.all(
            Radius.circular(8)
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.aldrich(
                          textStyle:const TextStyle(
                            color: Colors.amber,
                            fontSize: 23,
                          )
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.aldrich(
                          textStyle:const TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                          )
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      data,
                      style: GoogleFonts.aldrich(
                          textStyle:const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
