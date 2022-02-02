import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../constants.dart';

class CinemaSchedule extends StatefulWidget {
  const CinemaSchedule({
    Key? key,
    required this.cinema,
  }) : super(key: key);
  final DocumentSnapshot cinema;

  @override
  _CinemaScheduleState createState() => _CinemaScheduleState();
}

class _CinemaScheduleState extends State<CinemaSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movie Weekly Program',
          style: GoogleFonts.acme(
            textStyle:const TextStyle(
                fontSize: 25,
                color: Colors.green
            ),
          ),
        ),
        backgroundColor: kBackgroundColor,
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('activities')
                .doc(widget.cinema.reference.id)
                .collection('schedule')
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                final movies = snapshot.data.docs;
                List<Movies> movieWidget = [];
                for(var movie in movies){
                  final movieTitle = movie.data()['name'];
                  final startTime = DateTime.fromMicrosecondsSinceEpoch(movie.data()['time']
                      .microsecondsSinceEpoch);
                  final DateTime endTime = startTime.add(const Duration(hours: 2));
                  movieWidget.add(Movies(movieTitle , startTime, endTime, const Color(0xFF0F8644), false));
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SfCalendar(
                      view: CalendarView.schedule,
                      timeSlotViewSettings:const TimeSlotViewSettings(
                        startHour: 15,
                        endHour: 24,
                      ),
                      dataSource: MovieDataSource(movieWidget),
                      monthViewSettings: MonthViewSettings(
                          showAgenda: true,
                          monthCellStyle: MonthCellStyle(
                            textStyle: GoogleFonts.acme(
                              textStyle:const TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          )
                      ),
                    ),
                  ],
                );
              }
              else {
                return Container();
              }
            }
        ),
      ),
    );
  }
}
class MovieDataSource extends CalendarDataSource {
  MovieDataSource(List<Movies> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].movieName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}



class Movies {
  Movies(this.movieName, this.from, this.to, this.background, this.isAllDay);

  String movieName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}