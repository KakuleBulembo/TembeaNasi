import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../rounded_view_details_button.dart';

class ViewDetailsBody extends StatelessWidget {
  const ViewDetailsBody({
    Key? key,
    required this.location,
    required this.label,
    required this.labelData,
    required this.description,
    required this.buttonTitle,
    required this.onPressedButton
  }) : super(key: key);

  final String location;
  final String label;
  final String labelData;
  final String description;
  final String buttonTitle;
  final VoidCallback onPressedButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text('Location', style: TextStyle(color: Colors.white,)),
                    Text(
                      location,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  children: [
                    Text(label,style:const TextStyle(color: Colors.white,)),
                    Text(
                      labelData,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding:const EdgeInsets.only(
            top: 16.0,
            left: 30,
            right: 30,
          ),
          child: Text(
            description,
            style:const TextStyle(
              height: 1.5,
              color: Colors.white,
            ),
          ),
        ),
        (defaultTargetPlatform != TargetPlatform.iOS || defaultTargetPlatform != TargetPlatform.android) ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  height: 50,
                  child:  RoundedViewDetailsButton(
                    title: buttonTitle,
                    onPressed: onPressedButton,
                  ),
                ),
              ),
            ) ,
          ],
        ) : Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  height: 50,
                  child: RoundedViewDetailsButton(title: 'edit view', onPressed: (){},),
                ),
              ),
            ) ,
          ],
        )
      ],
    );
  }
}

