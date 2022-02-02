import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int touchedIndex = -1;
  int cinema = 0;
  int restaurant = 0;
  int hotel = 0;
  int event = 0;
  int game = 0;
  int gym = 0;
  int pool = 0;
  int total = 0;

  @override
  void initState() {
    getDataAnalysis();
    super.initState();
  }

  getDataAnalysis() async{
    await FirebaseFirestore.instance
        .collection('interest')
        .doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
         setState(() {
           cinema = value.data()!['Cinema'];
           restaurant = value.data()!['Restaurant'];
           hotel = value.data()!['Hotel'];
           event = value.data()!['Event'];
           game = value.data()!['Game'];
           gym = value.data()!['Gym'];
           pool = value.data()!['Pool'];
         });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            Text(
              'Users interest',
              style: GoogleFonts.acme(
                textStyle:const TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 1.3,
              child: Card(
                color: kBackgroundColor,
                child: Row(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                                touchCallback: (FlTouchEvent event, pieTouchResponse){
                                  setState(() {
                                    if (!event.isInterestedForInteractions ||
                                        pieTouchResponse == null ||
                                        pieTouchResponse.touchedSection == null) {
                                      touchedIndex = -1;
                                      return;
                                    }
                                    touchedIndex = pieTouchResponse
                                        .touchedSection!.touchedSectionIndex;
                                  });
                                }),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: showingSections(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children:const [
                Indicator(
                  activityName: 'Cinema',
                  color: Color(0xff0293ee),
                ),
                SizedBox(
                  height: 10,
                ),
                Indicator(
                    activityName: 'Hotel',
                    color: Color(0xfff8b250),
                ),
                SizedBox(
                  height: 10,
                ),
                Indicator(
                    activityName: 'Restaurant',
                    color: Color(0xff845bef)
                ),
                SizedBox(
                  height: 10,
                ),
                Indicator(
                  activityName: 'Event',
                  color: Colors.red,
                ),
                SizedBox(
                  height: 10,
                ),
                Indicator(
                    activityName: 'Game',
                    color: Colors.purple,
                ),
                SizedBox(
                  height: 10,
                ),
                Indicator(
                    activityName: 'Gym',
                    color: Colors.pink,
                ),
                SizedBox(
                  height: 10,
                ),
                Indicator(
                    activityName: 'Pool',
                    color: Colors.orange,
                ),
              ],
            )
          ],
        ),
    );
  }
  List<PieChartSectionData> showingSections() {
    return List.generate(7, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: cinema.toDouble(),
            title: '$cinema',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: hotel.toDouble(),
            title: '$hotel',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: restaurant.toDouble(),
            title: '$restaurant',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.red,
            value: event.toDouble(),
            title: '$event',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 4:
          return PieChartSectionData(
            color: Colors.purple,
            value: game.toDouble(),
            title: '$game',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 5:
          return PieChartSectionData(
            color: Colors.pink,
            value: gym.toDouble(),
            title: '$gym',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 6:
          return PieChartSectionData(
            color: Colors.orange,
            value: pool.toDouble(),
            title: '$pool',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    Key? key,
    required this.activityName,
    required this.color,
  }) : super(key: key);
  final String activityName;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: color,
          child:const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(' '),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          activityName,
          style: GoogleFonts.acme(
            textStyle: TextStyle(
              color: color,
              fontSize: 20
            )
          ),
        )
      ],
    );
  }
}
