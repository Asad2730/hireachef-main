import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireachef/Constants.dart';
import 'package:hireachef/widgets/cards/customer/chef_cards.dart';
import 'package:hireachef/widgets/navigation/bottom_navigation.dart';
import 'package:hireachef/widgets/navigation/top_nav_card.dart';
import '../../Helper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();
  bool searchBoolean = false;
  String searchText = '';
  var usernames = [];

  searchTextField() {
    return TextField(
      controller: search,
      onChanged: (value) {
        setState(() {
          searchText = value;
        });
      },
    );
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.white,
      appBar: AppBar(
        title: !searchBoolean
            ? const Image(
                image: AssetImage('assets/text-logo.png'),
                width: 170,
              )
            : searchTextField(),
        backgroundColor: Constant.orange,
        iconTheme: IconThemeData(color: Constant.white),
        elevation: 0,
        actions: !searchBoolean
            ? [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: ()  {
                    usernames.clear();
                    setState(
                      () {
                        searchBoolean = true;
                        searchText = '';
                        search.clear();
                      },
                    );
                  },
                ),
              ]
            : [
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    usernames.clear();
                    setState(
                      () {
                        searchBoolean = false;
                        searchText = '';
                        search.clear();
                      },
                    );
                  },
                ),
              ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Constant.orange,
              Constant.white,
            ],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                width: Get.width,
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    topNavCard("Chefs", 2, refresh),
                    topNavCard("Caterers", 3, refresh),
                    topNavCard("Cuisines", 4, refresh),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "OUR TOP CHEFS",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                width: Get.width,
                height: 240,
                child: _card(0, Axis.horizontal),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "You Might Also Like",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              _card(1, Axis.vertical),
              _card2(1, Axis.vertical),
            ],
          ),
        ),
      ),
      bottomNavigationBar: navigationBar(context, 0),
    );
  }

  Stream<QuerySnapshot> getDatas() {
    return FirebaseFirestore.instance
        .collection('users')
        .where('username', whereIn: usernames)
        .snapshots();
  }

  Stream<QuerySnapshot> getData() {
    //usernames.clear();
    if (searchText != '') {
      if (Helper.type == 4) {
        return FirebaseFirestore.instance.collection('cuisines').where('name',
            whereIn: [
              searchText.toLowerCase(),
              searchText.toUpperCase()
            ]).snapshots();
      } else {
        Stream<QuerySnapshot<Map<String, dynamic>>> res = const Stream.empty();
        var rs = FirebaseFirestore.instance
            .collection('users')
            .where('type', isEqualTo: Helper.type)
            .where('username', whereIn: [
          searchText.toLowerCase(),
          searchText.toUpperCase()
        ]).snapshots();

        rs.listen((event) {
          int len = event.size;
          if (len == 0) {

            var dishes = FirebaseFirestore.instance
                .collection('dishes')
                .where('name', whereIn: [
              searchText.toLowerCase(),
              searchText.toUpperCase()
            ]).snapshots();

            dishes.listen((e) {
              int len2 = e.size;
              if (len2 != 0) {
                for (var doc in e.docs) {
                  var uid = doc.data()['uid'];
                  var r = FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .snapshots();
                  r.listen((data) {
                    var name = data.data()!['username'];
                    if (name != null && name.isNotEmpty) {
                      if (!usernames.contains(name)) {
                        usernames.add(name);
                        print(name);
                      }
                    }
                  });
                }
              }
            });
          } else {
            rs = res;
          }
        });

        return rs;
      }
    } else {
      if (Helper.type == 4) {
        return FirebaseFirestore.instance.collection('cuisines').snapshots();
      } else {
        return FirebaseFirestore.instance
            .collection('users')
            .where('type', isEqualTo: Helper.type)
            .snapshots();
      }
    }
  }

  Widget _card(int op, Axis axis) {
    String name = 'username';
    if (Helper.type == 4) {
      name = 'name';
    }
    print('Empty:${usernames.isEmpty}');
    return StreamBuilder<QuerySnapshot>(
      stream: usernames.isEmpty ? getData() : getDatas(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return ListView.builder(
          scrollDirection: axis,
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            String cid = document.id;

            if (op == 0) {
              return chefCard2(
                  data['pic'] ?? -1,
                  data[name],
                  "a professional cook, typically the chief cook in a restaurant or hotel.",
                  data,
                  cid,
                  data['rating'] ?? 0.0);
            }
          },
        );
      },
    );
  }

  Widget _card2(int op, Axis axis) {
    String name = 'username';
    if (Helper.type == 4) {
      name = 'name';
    }

    return StreamBuilder<QuerySnapshot>(
      stream: usernames.isEmpty ? getData() : getDatas(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return ListView.builder(
          scrollDirection: axis,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            String cid = document.id;
            if (op != 0) {
              return chefCard(
                  data['pic'] ?? -1,
                  data[name],
                  "a professional cook, typically the chief cook in a restaurant or hotel.",
                  data,
                  cid,
                  data['rating'] ?? 0.0);
            }
          },
        );
      },
    );
  }
}
