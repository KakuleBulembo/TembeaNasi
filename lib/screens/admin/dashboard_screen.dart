import 'package:flutter/material.dart';
import 'package:tembea/components/menu_controller.dart';
import 'package:tembea/constants.dart';
import 'package:tembea/screens/admin/admin_components/drawer_menu.dart';
import 'package:tembea/screens/admin/admin_components/header_dashboard.dart';
import 'package:tembea/screens/admin/admin_components/admin_analysis.dart';
import 'package:tembea/screens/admin/admin_components/dashboard_body.dart';
import 'package:tembea/components/responsive.dart';
import 'package:provider/provider.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static String id = 'dashboard_screen';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size ;
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: const DrawerMenu(),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:   [
            if(Responsive.isWeb(context))
             const Expanded(
              //Default flex= 1
              child:  DrawerMenu(),
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
}

