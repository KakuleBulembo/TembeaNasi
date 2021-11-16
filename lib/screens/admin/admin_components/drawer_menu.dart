import 'package:flutter/material.dart';
import 'package:tembea/screens/admin/admin_components/drawer_list_title.dart';
import 'package:tembea/components/responsive.dart';
import 'package:tembea/constants.dart';

class DrawerMenu extends StatefulWidget {
   DrawerMenu({
    Key? key,
    required this.onIndexChanged,
    required this.selectedIndex,
  }) : super(key: key);

  final Function onIndexChanged;
  late int selectedIndex;

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
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
                color: widget.selectedIndex == 1 ? Theme.of(context).primaryColorLight.withOpacity(0.1) : Colors.transparent,
                child: DrawerListTitle(
                  selectedIndex: widget.selectedIndex == 1,
                  title: 'Dashboard',
                  svgSource: 'assets/icons/menu_dashboard.svg',
                  onPressed: (){
                    widget.onIndexChanged(1);
                    if(Responsive.isMobile(context)){
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
              Container(
                color: widget.selectedIndex == 2 ? Theme.of(context).primaryColorLight.withOpacity(0.1) : Colors.transparent,
                child: DrawerListTitle(
                  selectedIndex: widget.selectedIndex == 2,
                    title: 'Profile',
                    svgSource: 'assets/icons/menu_profile.svg',
                    onPressed: (){
                      widget.onIndexChanged(2);
                      if(Responsive.isMobile(context)){
                        Navigator.pop(context);
                      }
                    }
                ),
              ),
              Container(
                color: widget.selectedIndex == 3 ? kPrimaryColor.withOpacity(0.1) : Colors.transparent,
                child: DrawerListTitle(
                  selectedIndex: widget.selectedIndex == 3,
                    title: 'Users',
                    svgSource: 'assets/icons/menu_users.svg',
                    onPressed: (){
                      widget.onIndexChanged(3);
                      if(Responsive.isMobile(context)){
                        Navigator.pop(context);
                      }
                    }
                ),
              ),
              Container(
                color: widget.selectedIndex == 4 ? const Color(0xFFFFA113).withOpacity(0.1) : Colors.transparent,
                child: DrawerListTitle(
                    title: 'Events',
                    selectedIndex: widget.selectedIndex == 4,
                    svgSource: 'assets/icons/menu_events.svg',
                    onPressed: (){
                      widget.onIndexChanged(4);
                      if(Responsive.isMobile(context)){
                        Navigator.pop(context);
                      }
                    }
                ),
              ),
              Container(
                color: widget.selectedIndex == 5 ? const Color(0xFFA4CDFF).withOpacity(0.1) : Colors.transparent,
                child: DrawerListTitle(
                    title: 'Libraries',
                    selectedIndex: widget.selectedIndex == 5,
                    svgSource: 'assets/icons/menu_libraries.svg',
                    onPressed: (){
                      widget.onIndexChanged(5);
                      if(Responsive.isMobile(context)){
                        Navigator.pop(context);
                      }
                    }
                ),
              ),
              Container(
                color: widget.selectedIndex == 6 ? Colors.deepPurple.withOpacity(0.1) : Colors.transparent,
                child: DrawerListTitle(
                    title: 'Music Club',
                    selectedIndex: widget.selectedIndex == 6,
                    svgSource: 'assets/icons/menu_music.svg',
                    onPressed: (){
                      widget.onIndexChanged(6);
                      if(Responsive.isMobile(context)){
                        Navigator.pop(context);
                      }
                    }
                ),
              ),
              Container(
                color: widget.selectedIndex == 7 ? const Color(0xFF007EE5).withOpacity(0.1) : Colors.transparent,
                child: DrawerListTitle(
                    title: 'Games',
                    selectedIndex: widget.selectedIndex == 7,
                    svgSource: 'assets/icons/menu_games.svg',
                    onPressed: (){
                      widget.onIndexChanged(7);
                      if(Responsive.isMobile(context)){
                        Navigator.pop(context);
                      }
                    }
                ),
              ),
              Container(
                color: widget.selectedIndex == 8 ? Colors.red.withOpacity(0.1) : Colors.transparent,
                child: DrawerListTitle(
                    title: 'Gyms',
                    selectedIndex: widget.selectedIndex == 8,
                    svgSource: 'assets/icons/menu_gyms.svg',
                    onPressed: (){
                      widget.onIndexChanged(8);
                      if(Responsive.isMobile(context)){
                        Navigator.pop(context);
                      }
                    }
                ),
              ),
              Container(
                color: widget.selectedIndex == 9 ? Colors.green.withOpacity(0.1) : Colors.transparent,
                child: DrawerListTitle(
                    title: 'Restaurants',
                    selectedIndex: widget.selectedIndex == 9,
                    svgSource: 'assets/icons/menu_restaurants.svg',
                    onPressed: (){
                      widget.onIndexChanged(9);
                      if(Responsive.isMobile(context)){
                        Navigator.pop(context);
                      }
                    }
                ),
              ),
              Container(
                color: widget.selectedIndex == 10 ? Colors.yellow.withOpacity(0.1) : Colors.transparent,
                child: DrawerListTitle(
                    title: 'Hotels',
                    selectedIndex: widget.selectedIndex == 10,
                    svgSource: 'assets/icons/menu_hotels.svg',
                    onPressed: (){
                      widget.onIndexChanged(10);
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

