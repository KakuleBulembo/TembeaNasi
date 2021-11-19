import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tembea/components/viewData/view_details_body.dart';
import 'package:tembea/components/viewData/view_details_header.dart';
import 'package:tembea/screens/admin/admin_screens/update_form.dart';

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
          child: SizedBox(
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
                          child: ViewDetailsBody(
                              location: widget.item['Location'],
                              label: 'Date',
                              labelData: DateFormat('dd/MM/yyyy')
                                  .format(DateTime.fromMicrosecondsSinceEpoch(widget.item['Date'].microsecondsSinceEpoch)),
                          description: widget.item['Description'],
                            buttonTitle: 'edit view',
                            onPressedButton: (){
                                Navigator
                                    .push(context, MaterialPageRoute(builder: (context){
                                      return UpdateForm(item: widget.item);
                                }));
                            },
                          ),
                        ),
                      ),
                      ViewDetailsHeader(
                        activityName: widget.item['Name'],
                        activityPrice: 'Ksh ${widget.item['Price']}',
                        activityUrl: widget.item['PhotoUrl'],
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
