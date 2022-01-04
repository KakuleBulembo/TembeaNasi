import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tembea/constants.dart';
import 'package:tembea/screens/user/profile.dart';
import 'package:tembea/screens/user/search_dashboard.dart';
import 'package:tembea/screens/user/user_dashboard.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);
  static String id = 'user_home';

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Column(
        children: [
          Padding(
            padding:const EdgeInsets.only(
              top: 60,
              left: 10,
              right: 10,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                        'assets/images/logo.png',
                      width: 70,
                      height: 70,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                        'Tembea Nasi',
                      style: GoogleFonts.pacifico(
                        textStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.green.withOpacity(0.8),
                        )
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  height: 20,
                  color: Colors.green,
                ),
                const SizedBox(
                  height: 20,
                ),
                if(index == 0)
                  const UserDashboard(),
                if(index == 1)
                  const SearchDashboard(),
                if(index == 4)
                  const Profile(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: kSecondaryColor,
        index: index,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.green.withOpacity(0.8),
        items: const[
          Icon(Icons.home, size: 30,),
          Icon(Icons.search, size: 30,),
          Icon(Icons.favorite, size: 30,),
          Icon(IconData(0xeb4b, fontFamily: 'MaterialIcons'),size: 30,),
          Icon(Icons.person, size: 30,),
        ],
        onTap: (index) => setState(() {
          this.index = index;
        }),
      ),
    );
  }
}
