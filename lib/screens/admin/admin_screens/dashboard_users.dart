import 'package:flutter/material.dart';
import 'package:tembea/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tembea/components/responsive.dart';


class DashboardUsers extends StatefulWidget {
  const DashboardUsers({Key? key}) : super(key: key);

  @override
  _DashboardUsersState createState() => _DashboardUsersState();
}

class _DashboardUsersState extends State<DashboardUsers> {
  final _users = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: kSecondaryColor,
        borderRadius:
          BorderRadius.all(Radius.circular(10.0))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'System Users',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: Colors.white70,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: StreamBuilder<QuerySnapshot>(
              stream: _users.collection('users').orderBy('ts', descending: true).snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  final userDetails = snapshot.data!.docs;
                  List<DataRow> usersData = [];
                  for(var userDetail in userDetails){
                    final userUsername = userDetail.data()['username'];
                    final userEmail = userDetail.data()['email'];
                    final isAdmin = userDetail.data()['role'];
                    final userData = DataRow(
                      cells: [
                        if(Responsive.isWeb(context))
                          DataCell(
                            Text(userUsername, style: kTextColor2),
                          ),
                        DataCell(
                          Text(userEmail, style: kTextColor2),
                        ),
                        DataCell(
                          Text(isAdmin.toString(), style: kTextColor2),
                        ),
                      ],
                    );
                    usersData.add(userData);
                  }
                  return DataTable(
                      columns: [
                        if(Responsive.isWeb(context))
                          const DataColumn(
                            label: Text(
                              'Username',
                              style: kTextColor,
                            ),
                          ),
                        const DataColumn(
                          label: Text(
                            'Email',
                            style: kTextColor,
                          ),
                        ),
                        const DataColumn(
                          label: Text(
                            'isAdmin',
                            style: kTextColor,
                          ),
                        ),
                      ],
                      rows: List.generate(usersData.length, (index) => usersData[index])
                  );
                }
                else{
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

              }
            ),
          ),
        ],
      ),
    );
  }
}
