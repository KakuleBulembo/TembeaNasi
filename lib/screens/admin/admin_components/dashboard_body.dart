import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tembea/screens/admin/admin_components/admin_analysis.dart';
import 'package:tembea/constants.dart';

class AdminInfoAnalysis extends StatelessWidget {
  const AdminInfoAnalysis({
    Key? key,
    required this.info,
  }) : super(key: key);

  final AdminAnalysis info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0 * 0.7),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: info.color!.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0))
                ),
                child: SvgPicture.asset(
                  info.svgSrc!,
                  color: info.color,
                ),
              ),
              const Icon(
                Icons.more_vert,
                color: Colors.white54,
              )
            ],
          ),

          Text(
            info.title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),

          ProgressLine(color: info.color!, percentage: info.percentage!),

          Text(
            info.total!,
            style: TextStyle(
              color: info.color,
            ),
          ),

          Text(
            info.highRated!,
            style: Theme.of(context).textTheme
                .caption!
                .copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = kPrimaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color color;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(10,))
          ),
        ),
        LayoutBuilder(builder: (context, constraints) => Container(
          width: constraints.maxWidth * (percentage/100),
          height: 5,
          decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10,))
          ),
        ),
        ),
      ],
    );
  }
}