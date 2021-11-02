import 'package:flutter/material.dart';
import 'package:tembea/constants.dart';
import 'package:tembea/screens/admin/admin_components/drawer_menu.dart';
import 'package:tembea/screens/admin/admin_components/header_dashboard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static String id = 'dashboard_screen';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:   [
            const Expanded(
              //Default flex= 1
              child: DrawerMenu(),
            ),
            Expanded(
              //Takes 5/6 screen space
              flex: 5,
              child: Column(
                children: const [
                  HeaderDashboard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




