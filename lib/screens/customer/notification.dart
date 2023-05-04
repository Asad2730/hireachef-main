import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireachef/Helper.dart';
import 'package:hireachef/widgets/navigation/bottom_navigation.dart';

import '../../Constants.dart';
import '../../widgets/cards/customer/conversation_card.dart';
import '../../widgets/cards/customer/notification_card.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {



  @override
  Widget build(BuildContext context) {
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
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Notifications",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              _stream()
            ],
          ),
        ),
      ),
      bottomNavigationBar: navigationBar(context, 2),
    );

  }




  Future<List<Map<String, dynamic>>> getData2() async {
    List<Future<Map<String, dynamic>>> userQueries = [];

    QuerySnapshot requests = await FirebaseFirestore.instance.collection('requests')
        .where('uid', isEqualTo: Helper.loggedUser.id)
        .where('status',isEqualTo: 1)
        .get();

    Set<String> processedIds = {}; // Store processed docIds in a set

    requests.docs.forEach((requestDoc) {
     // print('ok ${requestDoc.data()['time']}');
      String docId = requestDoc
          .get('ids')
          .firstWhere((id) => id != Helper.loggedUser.id);
      if (!processedIds.contains(docId)) {
        userQueries.add(FirebaseFirestore.instance
            .collection('users')
            .doc(docId)
            .get()
            .then((doc) => {'id': doc.id,'data':requestDoc.data(), ...doc.data()!}));
        processedIds.add(docId); // Add processed docId to the set
      }
    });

    List<Map<String, dynamic>> users = await Future.wait(userQueries);
    return users;
  }


  Stream<QuerySnapshot> getData() {

    var requests = FirebaseFirestore.instance.collection('requests')
        .where('uid', isEqualTo: Helper.loggedUser.id)
        .where('status',isEqualTo: 1)
        .snapshots();

    return requests;
  }

  Widget _stream2() {

    return StreamBuilder<QuerySnapshot>(
      stream: getData(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

        if (snapshot.hasError) {
          return const Text('Something went wrong!');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        if(snapshot.data?.size == 0){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:const [
              SizedBox(height: 60,),
              Image(image: AssetImage('assets/notification.png'),width: 200,),
              SizedBox(height: 20,),
              Text("Nothing here!!!",style: TextStyle(fontSize: 16),)
            ],
          );
        }

        return ListView(
          reverse: true,
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 10,bottom: 10),
          physics: const NeverScrollableScrollPhysics(),
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
            Map<String, dynamic> data =
            document.data()! as Map<String, dynamic>;
            print(data);
            print(Helper.loggedUser.id);
            return notificationCard(
                "Lorem User",
                "has accepted your request",
                data['time'],
                'assets/avatar.png');
          }).toList().cast(),
        );

      },
    );
  }

  Widget _stream() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: getData2(),
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 16),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context, int index) {
            Map<String, dynamic> data = snapshot.data![index];
            String id = data['id'];
            print('Req ${data['data']['time']}');
            return notificationCard(
                data['username'],
                "has accepted your request",
                data['data']['time'],
                'assets/avatar.png');
          },
        );
      },
    );
  }


}
