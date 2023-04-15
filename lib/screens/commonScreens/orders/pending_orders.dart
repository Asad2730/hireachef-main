import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireachef/widgets/navigation/chef_navigation.dart';

import '../../../Constants.dart';
import '../../../Helper.dart';
import '../../../widgets/cards/chef/order_card.dart';

class PendingOrders extends StatefulWidget {
  const PendingOrders({Key? key}) : super(key: key);

  @override
  State<PendingOrders> createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {

  void refresh() {
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              _list(),
            ],
          ),
        ),
      ),

    );
  }

  Future<List<Notifications>> getData() async {
    List<Notifications> list = [];
    List<Temp> temp1 = [], temp2 = [];

    QuerySnapshot requests =
    await FirebaseFirestore.instance.collection('requests').where('status', isEqualTo: 0).get();

    List<Future<void>> futures = [];

    for (var i in requests.docs) {

      String uid = i.get('uid');
      String dishId = i.get('dishId');
      String time = i.get('time');

      DocumentReference user = FirebaseFirestore.instance.collection('users').doc(uid);
      futures.add(user.get().then((value) {
        var t = Temp();
        t.ob1 = value.get('username');
        t.ob2 = time;
        t.ob3 = i.id;
        temp1.add(t);
      }));

      DocumentReference dish = FirebaseFirestore.instance.collection('dishes').doc(dishId);
      futures.add(dish.get().then((value) {
        var t = Temp();
        t.ob1 = value.get('name');
        t.ob2 = value.get('url');
        temp2.add(t);
      }));
    }

    await Future.wait(futures);

    for (int i = 0; i < temp1.length; i++) {
      var notification = Notifications();
      notification.userName = temp1.elementAt(i).ob1;
      notification.time = temp1.elementAt(i).ob2;
      notification.id = temp1.elementAt(i).ob3;
      notification.dishName = temp2.elementAt(i).ob1;
      notification.url = temp2.elementAt(i).ob2;
      notification.id = temp1.elementAt(i).ob3;
      list.add(notification);
    }

    return list;
  }


  Widget _list() {
    return FutureBuilder<List<Notifications>>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<List<Notifications>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return const Text('Something went wrong!');
        }
        if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const Text('No data found.');
        }
        return ListView.builder(
          reverse: true,
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 10,bottom: 10),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context, int i) {
            var notification = snapshot.data![i];
            return pendingOrderCard(
                notification.userName, notification.dishName,
                notification.time, notification.url,
                notification.id,refresh);
          },
        );
      },
    );
  }


}

class Temp{
  late String ob1,ob2,ob3;
}
