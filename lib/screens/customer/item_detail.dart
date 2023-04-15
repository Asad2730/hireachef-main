import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hireachef/Helper.dart';
import 'package:intl/intl.dart';

import '../../Constants.dart';

class ItemDetail extends StatefulWidget {
  final String dishId;
  final  Map<String, dynamic> data;
  const ItemDetail({required this.dishId,required this.data,Key? key}) : super(key: key);

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {



  @override
  Widget build(BuildContext context) {
    double price = widget.data['price'];
    String url = widget.data['url'];
    String description = widget.data['description'];
    String name = widget.data['name'];
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
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
               url,
                height: 130,
                width:130,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Text(
                 name,
                  style:const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$ $price',
                  style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
             Text(
               description,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () => sendRequest(),
              child: Container(
                width: Get.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Constant.orange,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Request For Quote",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future sendRequest() async{
    final FirebaseFirestore db = FirebaseFirestore.instance;
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('h:mm a').format(now);
    Map<String,dynamic> data = {
      'uid':Helper.loggedUser.id,
      'dishId':widget.dishId,
       'status':0,
       'time':formattedTime,
    };

    await db.collection('requests').add(data);
    Fluttertoast.showToast(msg: 'Request sent successfully!');
    Get.back();

  }


}
