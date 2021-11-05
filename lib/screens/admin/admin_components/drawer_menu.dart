import 'package:flutter/material.dart';
import 'package:tembea/screens/admin/admin_components/drawer_list_title.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                child: Image.asset('assets/images/logo.png'),
              ),
              DrawerListTitle(
                title: 'Dashboard',
                svgSource: 'assets/icons/menu_dashboard.svg',
                onPressed: (){},
              ),
              DrawerListTitle(
                  title: 'Profile',
                  svgSource: 'assets/icons/menu_profile.svg',
                  onPressed: (){}
              ),
              DrawerListTitle(
                  title: 'Users',
                  svgSource: 'assets/icons/menu_users.svg',
                  onPressed: (){}
              ),
              DrawerListTitle(
                  title: 'Events',
                  svgSource: 'assets/icons/menu_events.svg',
                  onPressed: (){}
              ),
              DrawerListTitle(
                  title: 'Libraries',
                  svgSource: 'assets/icons/menu_libraries.svg',
                  onPressed: (){}
              ),
              DrawerListTitle(
                  title: 'Music Club',
                  svgSource: 'assets/icons/menu_music.svg',
                  onPressed: (){}
              ),
              DrawerListTitle(
                  title: 'Games',
                  svgSource: 'assets/icons/menu_games.svg',
                  onPressed: (){}
              ),
              DrawerListTitle(
                  title: 'Gyms',
                  svgSource: 'assets/icons/menu_gyms.svg',
                  onPressed: (){}
              ),
              DrawerListTitle(
                  title: 'Restaurants',
                  svgSource: 'assets/icons/menu_restaurants.svg',
                  onPressed: (){}
              ),
              DrawerListTitle(
                  title: 'Hotels',
                  svgSource: 'assets/icons/menu_hotels.svg',
                  onPressed: (){}
              ),
            ],
          ),
        ),
      ),
    );
  }
}

