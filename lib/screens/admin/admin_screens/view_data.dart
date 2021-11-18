import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import 'package:flutter/foundation.dart';

class ViewData extends StatefulWidget {
   const ViewData({
    Key? key,
    required this.item,
  }) : super(key: key);
  final DocumentSnapshot item;
  static String id = 'view_data';

  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 600,
            child: Column(
              children: [
                SizedBox(
                  height: size.height,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: size.height * 0.12,
                          left: 8.0,
                          right: 8.0
                        ),
                        margin: EdgeInsets.only(top: size.height * 0.3),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.3),
                          borderRadius:const BorderRadius.only(
                              topLeft: Radius.circular(24),
                            topRight: Radius.circular(24)
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 60.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          const Text('Location', style: TextStyle(color: Colors.white,)),
                                          Text(
                                            widget.item['Location'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                              fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      child: Column(
                                        children: [
                                          const Text('Date',style: TextStyle(color: Colors.white,)),
                                          Text(
                                            DateFormat('dd-MM-yyyy').
                                            format(DateTime.fromMicrosecondsSinceEpoch(widget.item['Date'].microsecondsSinceEpoch)),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding:const EdgeInsets.only(
                                    top: 16.0,
                                    left: 30,
                                    right: 30,
                                  ),
                                child: Text(
                                  widget.item['Description'],
                                  style:const TextStyle(
                                    height: 1.5,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              (defaultTargetPlatform != TargetPlatform.iOS || defaultTargetPlatform != TargetPlatform.android) ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                                    child: SizedBox(
                                      height: 50,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18),
                                          ),
                                          primary: kBackgroundColor,
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0 * 1.5, vertical: 16.0),
                                        ),
                                        child:Text(
                                          'Edit Activity'.toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onPressed: (){},
                                      ),
                                    ),
                                  ) ,
                                ],
                              ) : Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                                      child: SizedBox(
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18),
                                            ),
                                            primary: kBackgroundColor,
                                            padding: const EdgeInsets.symmetric(horizontal: 16.0 * 1.5, vertical: 16.0),
                                          ),
                                          child:Text(
                                            'Edit Activity'.toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: (){},
                                        ),
                                      ),
                                    ),
                                  ) ,
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Activity', style: TextStyle(color: Colors.white,)),
                            Text(
                              widget.item['Name'],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Price\n',
                                            style: TextStyle(color: Colors.white,)
                                          ),
                                        TextSpan(
                                            text: 'Ksh ${widget.item['Price']}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4!
                                                .copyWith(
                                                color: Colors.white,
                                              fontWeight: FontWeight.bold
                                            ),
                                        ),
                                      ]
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 90.0,
                                      child: ClipOval(
                                        child: Image.network(
                                          widget.item['PhotoUrl'],
                                        ),
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
