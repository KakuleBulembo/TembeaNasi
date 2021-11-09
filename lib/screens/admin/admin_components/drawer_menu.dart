import 'package:flutter/material.dart';
import 'package:tembea/screens/admin/admin_components/drawer_list_title.dart';
import 'package:tembea/components/responsive.dart';
import 'package:tembea/constants.dart';

class DrawerMenu extends StatelessWidget {
   DrawerMenu({
    Key? key,
    required this.onIndexChanged,
    required this.selectedIndex,
  }) : super(key: key);

  final Function onIndexChanged;
  late int selectedIndex;

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
              Container(
                color: selectedIndex == 1 ? Theme.of(context).primaryColorLight.withOpacity(0.1) : Colors.transparent,
                child: DrawerListTitle(
                  selectedIndex: selectedIndex == 1,
                  title: 'Dashboard',
                  svgSource: 'assets/icons/menu_dashboard.svg',
                  onPressed: (){
                    onIndexChanged(1);
                    if(Responsive.isMobile(context)){
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
              Container(
                color: selectedIndex == 2 ? Theme.of(context).primaryColorLight.withOpacity(0.1) : Colors.transparent,
                child: DrawerListTitle(
                  selectedIndex: selectedIndex == 2,
                    title: 'Profile',
                    svgSource: 'assets/icons/menu_profile.svg',
                    onPressed: (){
                      onIndexChanged(2);
                      if(Responsive.isMobile(context)){
                        Navigator.pop(context);
                      }
                    }
                ),
              ),
              Container(
                color: selectedIndex == 3 ? kPrimaryColor.withOpacity(0.1) : Colors.transparent,
                child: DrawerListTitle(
                  selectedIndex: selectedIndex == 3,
                    title: 'Users',
                    svgSource: 'assets/icons/menu_users.svg',
                    onPressed: (){
                      onIndexChanged(3);
                      if(Responsive.isMobile(context)){
                        Navigator.pop(context);
                      }
                    }
                ),
              ),
              Container(
                color: selectedIndex == 4 ? const Color(0xFFFFA113).withOpacity(0.1) : Colors.transparent,
                child: DrawerListTitle(
                    title: 'Events',
                    selectedIndex: selectedIndex == 4,
                    svgSource: 'assets/icons/menu_events.svg',
                    onPressed: (){
                      onIndexChanged(4);
                      if(Responsive.isMobile(context)){
                        Navigator.pop(context);
                      }
                    }
                ),
              ),
              Container(
                color: selectedIndex == 5 ? const Color(0xFFA4CDFF).withOpacity(0.1) : Colors.transparent,
                child: DrawerListTitle(
                    title: 'Libraries',
                    selectedIndex: selectedIndex == 5,
                    svgSource: 'assets/icons/menu_libraries.svg',
                    onPressed: (){
                      onIndexChanged(5);
                      if(Responsive.isMobile(context)){
                        Navigator.pop(context);
                      }
                    }
                ),
              ),
              Container(
                color: selectedIndex == 6 ? Colors.deepPurple.withOpacity(0.1) : Colors.transparent,
                child: DrawerListTitle(
                    title: 'Music Club',
                    selectedIndex: selectedIndex == 6,
                    svgSource: 'assets/icons/menu_music.svg',
                    onPressed: (){
                      onIndexChanged(6);
                      if(Responsive.isMobile(context)){
                        Navigator.pop(context);
                      }
                    }
                ),
              ),
              Container(
                color: selectedIndex == 7 ? const Color(0xFF007EE5).withOpacity(0.1) : Colors.transparent,
                child: DrawerListTitle(
                    title: 'Games',
                    selectedIndex: selectedIndex == 7,
                    svgSource: 'assets/icons/menu_games.svg',
                    onPressed: (){
                      onIndexChanged(7);
                      if(Responsive.isMobile(context)){
                        Navigator.pop(context);
                      }
                    }
                ),
              ),
              Container(
                color: selectedIndex == 8 ? Colors.red.withOpacity(0.1) : Colors.transparent,
                child: DrawerListTitle(
                    title: 'Gyms',
                    selectedIndex: selectedIndex == 8,
                    svgSource: 'assets/icons/menu_gyms.svg',
                    onPressed: (){
                      onIndexChanged(8);
                      if(Responsive.isMobile(context)){
                        Navigator.pop(context);
                      }
                    }
                ),
              ),
              Container(
                color: selectedIndex == 9 ? Colors.green.withOpacity(0.1) : Colors.transparent,
                child: DrawerListTitle(
                    title: 'Restaurants',
                    selectedIndex: selectedIndex == 9,
                    svgSource: 'assets/icons/menu_restaurants.svg',
                    onPressed: (){
                      onIndexChanged(9);
                      if(Responsive.isMobile(context)){
                        Navigator.pop(context);
                      }
                    }
                ),
              ),
              Container(
                color: selectedIndex == 10 ? Colors.yellow.withOpacity(0.1) : Colors.transparent,
                child: DrawerListTitle(
                    title: 'Hotels',
                    selectedIndex: selectedIndex == 10,
                    svgSource: 'assets/icons/menu_hotels.svg',
                    onPressed: (){
                      onIndexChanged(10);
                      if(Responsive.isMobile(context)){
                        Navigator.pop(context);
                      }
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

