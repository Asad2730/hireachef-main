import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireachef/screens/catering/add_cuisine.dart';
import 'package:hireachef/widgets/cards/catering/cuisine_card.dart';
import '../../Constants.dart';
import '../../Helper.dart';
import '../../widgets/navigation/catering_navigation.dart';
import '../../widgets/navigation/chef_navigation.dart';

class CateringHome extends StatefulWidget {
  const CateringHome({Key? key}) : super(key: key);

  @override
  State<CateringHome> createState() => _CateringHomeState();
}

class _CateringHomeState extends State<CateringHome> {
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
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Cuisines",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const AddCuisine());

                      },
                      child: Container(
                        width: 80,
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
              _cuisines(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: cateringNavigation(context, 0),
    );
  }


  Stream<QuerySnapshot> getCuisines() {

    if(searchText != ''){
      return FirebaseFirestore.instance.collection('cuisines')
          .where('uid', isEqualTo:Helper.loggedUser.id)
          .where('name', isEqualTo:searchText)
          .snapshots();
    }else{
      return FirebaseFirestore.instance.collection('cuisines')
          .where('uid', isEqualTo:Helper.loggedUser.id)
          .snapshots();
    }

  }


  Widget _cuisines(){
    return StreamBuilder<QuerySnapshot>(
      stream: getCuisines(),
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
            String docId = document.id;
            return  cuisineCard(data['url'],data['name'] ,data['description'],data['price'],docId);
          },
        );
      },
    );

  }


}
