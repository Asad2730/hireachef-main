import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireachef/Helper.dart';
import '../../Constants.dart';
import '../../widgets/cards/chef/dish_card.dart';
import '../../widgets/navigation/chef_navigation.dart';
import '../commonScreens/dishes/add_dish.dart';

class ChefHome extends StatefulWidget {
  const ChefHome({Key? key}) : super(key: key);

  @override
  State<ChefHome> createState() => _ChefHomeState();
}

class _ChefHomeState extends State<ChefHome> {
  TextEditingController search = TextEditingController();
  bool searchBoolean = false;
  String searchText = '';
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
            onPressed: () {
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
      body:  Container(
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
              Container(
                margin:const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Dishes",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>const AddDish());
                      },
                      child: Container(
                        width:80,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Constant.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Add +",
                          style: TextStyle(
                            color: Constant.orange,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
             _dishes(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: chefNavigation(context, 0),
    );
  }


  Stream<QuerySnapshot> getDishes() {

    if(searchText != ''){
      return FirebaseFirestore.instance.collection('dishes')
          .where('uid', isEqualTo:Helper.loggedUser.id)
          .where('name',whereIn: [searchText.toLowerCase(),searchText.toUpperCase()])
          .snapshots();
    }else{
      return FirebaseFirestore.instance.collection('dishes')
          .where('uid', isEqualTo:Helper.loggedUser.id)
          .snapshots();
    }

  }


  Widget _dishes(){
    return StreamBuilder<QuerySnapshot>(
      stream: getDishes(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            String docId = document.id;
            print(data['name']);
            return  dishCard(data['url'],data['name'] ,data['description'], data['price'],docId);
          },
        );
      },
    );

  }

}
