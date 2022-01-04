import 'package:flutter/material.dart';

class AdminAnalysis {
  final String? svgSrc, total, title, highRated;
  final int? percentage;
  final Color? color;
  final VoidCallback? onPressed;

  AdminAnalysis({
    this.svgSrc,
    this.title,
    this.highRated,
    this.total,
    this.percentage,
    this.color,
    this.onPressed
  });
}

List adminAnalysis = [
  AdminAnalysis(
    title: "Events",
    total: "120 Events",
    svgSrc: "assets/icons/menu_events.svg",
    highRated: "High Rated: Safari Rally",
    color: const Color(0xFFFFA113),
    percentage: 75,
    onPressed: (){},
  ),
  AdminAnalysis(
    title: "Restaurants",
    total: "50 Restaurants",
    svgSrc: "assets/icons/menu_restaurants.svg",
    highRated: "High Rated: CJ's",
    color: Colors.green,
    percentage: 35,
    onPressed: (){},
  ),
  AdminAnalysis(
    title: "Hotels",
    total: "35 Hotels",
    svgSrc: "assets/icons/menu_hotels.svg",
    highRated: "High Rated: Ibis Styles",
    color: Colors.yellow,
    percentage: 28,
    onPressed: (){},
  ),

  AdminAnalysis(
    title: "Games",
    total: "30 Games",
    svgSrc: "assets/icons/menu_games.svg",
    highRated: "High Rated: Village Bowl",
    color:const Color(0xFF007EE5),
    percentage: 10,
    onPressed: (){},
  ),
  AdminAnalysis(
    title: "Gyms",
    total: "70 gyms",
    svgSrc: "assets/icons/menu_gyms.svg",
    highRated: "High Rated: Marcos Fitness & Beauty Parlour",
    color: Colors.red,
    percentage: 40,
    onPressed: (){},
  ),
  AdminAnalysis(
    title: "Pools",
    total: "20 pools",
    svgSrc: "assets/icons/menu_pool.svg",
    highRated: "High Rated: Anna",
    color: Colors.pink,
    percentage: 5,
    onPressed: (){},
  ),
  AdminAnalysis(
    title: "Cinema",
    total: "5 cinema",
    svgSrc: "assets/icons/menu_cinema.svg",
    highRated: "High Rated: Imax",
    color: Colors.deepPurple,
    percentage: 5,
    onPressed: (){},
  ),
];