import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tembea/components/viewData/view_price.dart';
import 'package:tembea/components/viewData/view_time.dart';

import '../rounded_view_details_button.dart';

class BottomPlaceView extends StatelessWidget {
  const BottomPlaceView({
    Key? key,
    required this.activityName,
    required this.priceLabel,
    required this.price,
    required this.activityDescription,
    required this.openingTimeLabel,
    required this.closingTimeLabel,
    required this.openingTime,
    required this.closingTime,
    required this.location,
    required this.labelButton,
    required this.onPressedFormButton,
  }) : super(key: key);
  final String activityName;
  final String priceLabel;
  final String price;
  final String activityDescription;
  final String openingTimeLabel;
  final String openingTime;
  final String closingTimeLabel;
  final String closingTime;
  final String location;
  final String labelButton;
  final VoidCallback onPressedFormButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text(
              activityName,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
         ViewPrice(
           label: priceLabel,
           color: Colors.amber,
           data: price,
         ),
          Center(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    activityDescription,
                    style: const TextStyle(
                      height: 1.5,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Row(
              children: [
                ViewTime(
                  label: openingTimeLabel,
                  color: Colors.green,
                  data: openingTime,
                ),
                ViewTime(
                  label: closingTimeLabel,
                  color: Colors.red,
                  data: closingTime,
                ),
              ],
            ),
          ),
          Center(
            child: Row(
              children: [
                ViewTime(
                  label: 'Location',
                  color: Colors.white,
                  data: location,
                ),
              ],
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
                      title: labelButton,
                      onPressed: onPressedFormButton,
                    ),
                  ),
                ),
              ),
            ],
          ) : Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    height: 50,
                    child: RoundedViewDetailsButton(
                      title: 'Edit Form',
                      onPressed: onPressedFormButton,
                    ),
                  ),
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}



