import 'package:cloud_firestore/cloud_firestore.dart';
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

class AdminInfoGrid extends StatelessWidget {
  const AdminInfoGrid({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);
  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('activities').snapshots(),
      builder: (context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: adminAnalysis.length,
            shrinkWrap: true,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: childAspectRatio,
            ),
            itemBuilder: (context, index)  => AdminInfoAnalysis(info: adminAnalysis[index],),
          );
        }
        return Container();
      },
    );
  }
}

class AdminAnalysisData {
  final String? svgSrc, total, title, highRated;
  final int? percentage;
  final Color? color;
  final VoidCallback? onPressed;

  AdminAnalysisData({
    this.svgSrc,
    this.title,
    this.highRated,
    this.total,
    this.percentage,
    this.color,
    this.onPressed
  });
}
