import 'package:flutter/material.dart';
import 'package:tembea/constants.dart';

class ViewDetailsHeader extends StatelessWidget {
  const ViewDetailsHeader({
    Key? key,
    required this.activityName,
    required this.activityPrice,
    required this.activityUrl,
    required this.updateImageFunction
  }) : super(key: key);

  final String activityName;
  final String activityPrice;
  final String activityUrl;
  final VoidCallback updateImageFunction;

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
                  child: Stack(
                    clipBehavior: Clip.none,

                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(activityUrl),
                        radius: 90.0,
                      ),
                      Positioned(
                          bottom: 0,
                          right: -25,
                          child: RawMaterialButton(
                            onPressed: updateImageFunction,
                            elevation: 2.0,
                            fillColor: kBackgroundColor,
                            child:const Icon(Icons.camera_alt_outlined, color: Colors.white,),
                            padding:const EdgeInsets.all(15.0),
                            shape: const CircleBorder(),
                          )),
                    ],
                  ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}