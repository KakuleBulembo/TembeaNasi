import 'package:flutter/material.dart';
import 'package:tembea/constants.dart';

class EventForm extends StatelessWidget {
  const EventForm({Key? key}) : super(key: key);
  static String id = 'event_form';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('assets/images/logo.png'),
            ),
            const SizedBox(
              height: 16.0,
            ),
             Container(
               padding: const EdgeInsets.only(top: 16, left: 30, right: 30.0, bottom: 16),
              decoration: const BoxDecoration(
                color: kSecondaryColor,
              ),
              height: 500,
                width: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                      'Event',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
                    ),
                     SizedBox(
                      height: 16,
                      child: Container(
                        width: double.infinity,
                        color: kSecondaryColor.withOpacity(0.9),
                      ),
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      cursorColor: Colors.blue,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration:  kActivityForm.copyWith(
                        labelText: 'Event\'s Name'
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      cursorColor: Colors.blue,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration:  kActivityForm.copyWith(
                          labelText: 'Event\'s Location'
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      cursorColor: Colors.blue,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration:  kActivityForm.copyWith(
                          labelText: 'Event\'s participation price'
                      ),
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
