import 'package:flutter/material.dart';
import 'package:project_one/Services/apiservice.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title:
              const Text('HomeScreen', style: TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<Map>(
            future: ApiServices().getPosts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!['data'].length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> obj =
                            snapshot.data!['data'][index];
                        return InkWell(
                          onTap: () {
                            ApiServices().getProileDetails(id: obj['id']);
                          },
                          child: Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                maxRadius: 70,
                                minRadius: 50,
                                // backgroundImage: NetworkImage(snapshot
                                //     .data!['data'][index]['avatar']
                                //     .toString()),
                                backgroundImage: NetworkImage(obj['avatar']),
                              ),
                              title: Row(
                                children: [
                                  // Text(snapshot.data!['data'][index]
                                  //     ['first_name']),
                                  Text(obj['first_name']),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  //       Text( snapshot.data!['data'][index]['last_name']),
                                  Text(obj['last_name']),
                                ],
                              ),
                              subtitle:
                                  //    Text(snapshot.data!['data'][index]['email']),
                                  Text(obj['email']),
                            ),
                          ),
                        );

                        // Container(
                        //   child: Text(snapshot.data!['data'][index]['first_name']),
                        // );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (snapshot.data!['page'] <
                            snapshot.data!['total_pages'])
                          InkWell(
                            onTap: () {
                              setState(() {
                                ApiServices().page++;
                              });
                            },
                            child: const SizedBox(
                              width: 60,
                              height: 30,
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    color: Colors.white,
                                    backgroundColor: Colors.black),
                              ),
                            ),
                          ),
                        if (snapshot.data!['page'] > 1)
                          InkWell(
                            onTap: () {
                              setState(() {
                                ApiServices().page--;
                              });
                            },
                            child: const SizedBox(
                              width: 60,
                              height: 30,
                              child: Text(
                                'Previous',
                                style: TextStyle(
                                    color: Colors.white,
                                    backgroundColor: Colors.black),
                              ),
                            ),
                          )
                      ],
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}
