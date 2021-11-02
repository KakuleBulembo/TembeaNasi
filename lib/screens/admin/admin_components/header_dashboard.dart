import 'package:flutter/material.dart';
import '../../../components/search_engine.dart';
import '../../../components/profile_card.dart';

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
               Text(
                   'Dashboard',
                 style: Theme.of(context).textTheme.headline6!.copyWith(
                   color: Colors.white,
                 ),
               ),
               const Spacer(
                 flex: 2,
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

