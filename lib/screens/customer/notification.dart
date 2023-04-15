import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireachef/Helper.dart';
import 'package:hireachef/widgets/navigation/bottom_navigation.dart';

import '../../Constants.dart';
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

  Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance.collection('requests')
        .where('uid', isEqualTo: Helper.loggedUser.id)
         .where('status',isEqualTo: 1)
        .snapshots();
  }

  Widget _stream() {

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


}
