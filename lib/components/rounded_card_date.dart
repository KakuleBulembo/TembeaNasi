import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tembea/components/square_button.dart';
import '../constants.dart';

class RoundedCardDate extends StatelessWidget {
  const RoundedCardDate({
    Key? key,
    required this.title,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Card(
              color: kBackgroundColor,
              shadowColor: kBackgroundColor,
              elevation: 15,
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
                    Text(
                      title,
                      style: GoogleFonts.acme(
                        textStyle: TextStyle(
                          color: Colors.green.withOpacity(0.8),
                          fontSize: 25,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.green,
                      height: 20,
                    ),
                    DateButton(
                      text: text,
                      onPressed: onPressed,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}