import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tembea/constants.dart';

class SearchEngine extends StatefulWidget {
  const SearchEngine({
    Key? key,
    required this.onChanged,
    required this.text
  }) : super(key: key);
  final ValueChanged<String> onChanged;
  final String text;

  @override
  State<SearchEngine> createState() => _SearchEngineState();
}

class _SearchEngineState extends State<SearchEngine> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.green,
      decoration: InputDecoration(
        hintText: 'Search',
        fillColor: kSecondaryColor,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10.0),),
        ),
        prefixIcon: Container(
          padding: const  EdgeInsets.all(16.0 * 0.75),
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(10.0),),
          ),
          child: SvgPicture.asset('assets/icons/Search.svg'),
        ),
        suffixIcon: widget.text.isNotEmpty
            ? GestureDetector(
          child:const Icon(Icons.close, color: Colors.green,),
          onTap: () {
            controller.clear();
            widget.onChanged('');
            FocusScope.of(context).requestFocus(FocusNode());
          },
        )
            : null,
      ),
      onChanged: widget.onChanged,
    );
  }
}