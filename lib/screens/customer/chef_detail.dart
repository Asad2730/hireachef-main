import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireachef/widgets/cards/customer/dishes_cards.dart';

import '../../Constants.dart';
import '../../Helper.dart';
import '../../widgets/cards/catering/cuisine_card.dart';

class ChefDetail extends StatefulWidget {

  final Map<String,dynamic> data;
  final String cid;
  const ChefDetail({required this.cid,required this.data,Key? key}) : super(key: key);
  @override
  State<ChefDetail> createState() => _ChefDetailState();
}

class _ChefDetailState extends State<ChefDetail> {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                   widget.data['username'],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.star,
                    color: Constant.white,
                    size: 15,
                  ),
                  const SizedBox(width: 5),
                  const Text("4.5"),
                ],
              ),
              const Text("+92 3xx xxxxxxx"),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Dishes",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 15,
              ),

            _dishes(),

            ],
          ),
        ),
      ),
    );
  }

  Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance.collection('dishes')
        .where('uid', isEqualTo:widget.cid)
        .snapshots();
  }


  Widget _dishes(){
    return StreamBuilder<QuerySnapshot>(
      stream: getData(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            String did = document.id;
            return  dishesCard(data['url'],data['name'] ,
                data['description'], '4.3',data['price'],
                did,data);

          },
        );
      },
    );

  }

}
