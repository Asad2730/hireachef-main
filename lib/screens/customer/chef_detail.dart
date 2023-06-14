import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hireachef/widgets/cards/customer/dishes_cards.dart';
import 'package:intl/intl.dart';

import '../../Constants.dart';
import '../../Helper.dart';

class ChefDetail extends StatefulWidget {
  final Map<String, dynamic> data;
  final String cid;
  const ChefDetail({required this.cid, required this.data, Key? key})
      : super(key: key);
  @override
  State<ChefDetail> createState() => _ChefDetailState();
}

class _ChefDetailState extends State<ChefDetail> {
  @override
  Widget build(BuildContext context) {
    String type = 'Dishes';
    if (Helper.type == 4) {
      type = 'Cuisines';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Image(
          image: AssetImage('assets/text-logo.png'),
          width: 170,
        ),
        backgroundColor: Constant.orange,
        iconTheme: IconThemeData(color: Constant.white),
        elevation: 0,
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
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(200.0),
                child: const Image(
                  image: AssetImage("assets/avatar-2.jpg"),
                  width: 130,
                  height: 130,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Helper.type != 4
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.data['username'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  : const Text(''),
              Helper.type != 4 ? const Text("+92 3xx xxxxxxx") : const Text(''),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  type,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: Colors.orange,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  onPressed: () => sendRequest(),
                  child: const Text(
                    'Hire this chef',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              _dishes(),
            ],
          ),
        ),
      ),
    );
  }

  Future<Stream<QuerySnapshot>> getData() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: widget.data['email'])
        .get();
    final docSnapshot = querySnapshot.docs.first;
    String docId = docSnapshot.id;

    Stream<QuerySnapshot> response;
    if (Helper.type == 4) {
      response = FirebaseFirestore.instance.collection('cuisines').snapshots();
    } else {
      response = FirebaseFirestore.instance
          .collection('dishes')
          .where('uid', isEqualTo: docId)
          .snapshots();
    }
    return response;
  }

  Widget _dishes() {
    return FutureBuilder<Stream<QuerySnapshot>>(
      future: getData(),
      builder: (BuildContext context,
          AsyncSnapshot<Stream<QuerySnapshot>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return StreamBuilder<QuerySnapshot>(
          stream: snapshot.data,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String did = document.id;

                return dishesCard(data['url'], data['name'],
                    data['description'], data['price'], did, data);
              },
            );
          },
        );
      },
    );
  }

  Future sendRequest() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('h:mm a').format(now);
    Map<String, dynamic> data = {
      'uid': Helper.loggedUser.id,
      'dishId': '',
      'status': 0,
      'time': formattedTime,
      'ids': [Helper.loggedUser.id, widget.cid],
    };

    await db.collection('requests').add(data);
    Fluttertoast.showToast(msg: 'Request sent successfully!');
  }
}
