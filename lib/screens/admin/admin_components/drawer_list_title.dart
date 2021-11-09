import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerListTitle extends StatelessWidget {
  final String title, svgSource;
  final VoidCallback onPressed;
  final bool selectedIndex;

  const DrawerListTitle({required this.title, required this.svgSource, required this.onPressed, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      selected: selectedIndex,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSource,
        color: Colors.white54,
        height: 16.0,
      ),
      title:  Text(
        title,
        style: const TextStyle(
          color: Colors.white54,
        ),
      ),
    );
  }
}
