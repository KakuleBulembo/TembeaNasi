import 'package:flutter/material.dart';
import '../../../components/search_engine.dart';
import '../../../components/profile_card.dart';
import 'package:tembea/components/responsive.dart';
import 'package:tembea/components/menu_controller.dart';
import 'package:provider/provider.dart';

class HeaderDashboard extends StatelessWidget {
  const HeaderDashboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
           Row(
             children: [
               if(!Responsive.isWeb(context))
               IconButton(
                   onPressed: context.read<MenuController>().controlMenu,
                   icon: const Icon(Icons.menu)
               ),
               if(!Responsive.isMobile(context))
               Text(
                   'Dashboard',
                 style: Theme.of(context).textTheme.headline6!.copyWith(
                   color: Colors.white,
                 ),
               ),
               if(!Responsive.isMobile(context))
               Spacer(
                 flex: Responsive.isWeb(context) ? 2 : 1,
               ),
                const Expanded(
                   child: SearchEngine(),
               ),
               const ProfileCard(),
             ],
           ),
          ],
        ),
      ),
    );
  }
}

