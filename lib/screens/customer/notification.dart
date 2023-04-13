import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireachef/widgets/navigation/bottom_navigation.dart';

import '../../Constants.dart';
import '../../widgets/cards/customer/notification_card.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  var is_notification = false;

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
        child: is_notification ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:const [
            Image(image: AssetImage('assets/notification.png'),width: 200,),
            SizedBox(height: 20,),
            Text("Nothing here!!!",style: TextStyle(fontSize: 16),)
          ],
        ):SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Notifications",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              notificationCard("Lorem User","has accepted your request","8:58pm",'assets/avatar.png'),
              notificationCard("Lorem User","has accepted your request","8:58pm",'assets/avatar.png'),
              notificationCard("Lorem User","has accepted your request","8:58pm",'assets/avatar.png'),
              notificationCard("Lorem User","has accepted your request","8:58pm",'assets/avatar.png'),
              notificationCard("Lorem User","has accepted your request","8:58pm",'assets/avatar.png'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: navigationBar(context, 2),
    );

  }
}
