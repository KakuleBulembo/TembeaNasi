import 'package:flutter/material.dart';
import 'package:tembea/components/menu_controller.dart';
import 'package:tembea/constants.dart';
import 'package:tembea/screens/admin/admin_components/drawer_menu.dart';
import 'package:tembea/screens/admin/admin_components/header_dashboard.dart';
import 'package:tembea/screens/admin/admin_screens/dashboard_body.dart';
import 'package:tembea/components/responsive.dart';
import 'package:provider/provider.dart';
import 'package:tembea/screens/admin/admin_screens/dashboard_users.dart';
import 'admin_screens/dashbord_event.dart';



class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static String id = 'dashboard_screen';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size ;
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer:  DrawerMenu(
        onIndexChanged: (int value){
          setState(() {
            selectedIndex = value;
          });

      }, selectedIndex: selectedIndex,),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:   [
            if(Responsive.isWeb(context))
              Expanded(
              //Default flex= 1
              child:  DrawerMenu(
                onIndexChanged: (int value){
                  setState(() {
                    selectedIndex = value;
                  });
                }, selectedIndex: selectedIndex,),
            ),
            Expanded(
              //Takes 5/6 screen space
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children:   [
                       const HeaderDashboard(),
                       const SizedBox(
                         height: 16.0,
                       ),
                      if(selectedIndex == 1 || selectedIndex == 0)
                      Responsive(
                          mobile:  AdminInfoGrid(
                            childAspectRatio: _size.width < 700 ? 1.3 : 1,
                            crossAxisCount: _size.width < 700 ? 2 : 4,
                          ),
                          tablet: const AdminInfoGrid(),
                          web: AdminInfoGrid(
                            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
                          ),
                      ),
                      if(selectedIndex == 2)
                        const Text('Profile'),
                      if(selectedIndex == 3)
                        const DashboardUsers(),
                      if(selectedIndex == 4)
                        const DashboardEvent(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


