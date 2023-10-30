import 'package:flutter/material.dart';
import 'package:project_one/Models/profile_details_model.dart';
import 'package:project_one/Services/apiservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
    List<ProfileDetails> profiledetailsList = [];

  String? profileImage;
  String? firstname;
  String? lastname;
  String? email;
  dynamic id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Profile Details',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<Map>(
              future: ApiServices().getProileDetails(id: id),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Text('Loading');
                return ListView.builder(itemBuilder: (context, index) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // CircleAvatar(
                        //   maxRadius: 70,
                        //   minRadius: 50,
                        //   backgroundImage: NetworkImage('$profileImage'),
                        // ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$firstname',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text('$lastname',
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                        Text('$email', style: TextStyle(color: Colors.white))
                      ],
                    ),
                  );
                });
              }),
        ));
  }
}
