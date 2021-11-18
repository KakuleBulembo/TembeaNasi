import 'package:flutter/material.dart';

class ViewDetailsHeader extends StatelessWidget {
  const ViewDetailsHeader({
    Key? key,
    required this.activityName,
    required this.activityPrice,
    required this.activityUrl
  }) : super(key: key);

  final String activityName;
  final String activityPrice;
  final String activityUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Activity', style: TextStyle(color: Colors.white,)),
          Text(
            activityName,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                      children: [
                        const TextSpan(
                            text: 'Price\n',
                            style: TextStyle(color: Colors.white,)
                        ),
                        TextSpan(
                          text: activityPrice,
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ]
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 90.0,
                    child: ClipOval(
                      child: Image.network(
                          activityUrl
                      ),
                    ),
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}