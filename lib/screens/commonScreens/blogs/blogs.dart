import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireachef/Helper.dart';
import 'package:hireachef/screens/commonScreens/blogs/blog_post.dart';

import '../../../Constants.dart';
import '../../../widgets/cards/blogs/blog_card.dart';
import '../../../widgets/navigation/bottom_navigation.dart';
import '../../../widgets/navigation/catering_navigation.dart';
import '../../../widgets/navigation/chef_navigation.dart';

class Blogs extends StatefulWidget {
  Blogs({Key? key}) : super(key: key);

  var id;

  Blogs.set({this.id});

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  @override
  TextEditingController search = TextEditingController();
  bool searchBoolean = false;

  searchTextField() {
    return TextField(
      controller: search,
    );
  }

  bottomNavigation() {
    if (widget.id == 1) {
      return navigationBar(context, 3);
    } else if (widget.id == 2) {
      return chefNavigation(context, 3);
    } else if (widget.id == 3) {
      return cateringNavigation(context, 3);
    }
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
                      child: Text(
                        widget.id == 1 ? "Recent Blogs" : "Blogs",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    widget.id != 1
                        ? GestureDetector(
                            onTap: () {
                              Get.to(() => BlogPost(id: Helper.loggedUser.id,option: 1,url: '',));
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
                          )
                        : Container(),
                  ],
                ),
              ),

              _blogs(),

            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigation(),
    );
  }


  Stream<QuerySnapshot> getBlogs(){
    if(Helper.loggedUser.type == 1){
      return  FirebaseFirestore.instance.collection('blogs')
          .snapshots();
    }else{
      return  FirebaseFirestore.instance.collection('blogs')
          .where('uid',isEqualTo: Helper.loggedUser.id)
          .snapshots();
    }
  }


  Widget _blogs(){
    return StreamBuilder(
        stream: getBlogs(),
        builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                 DocumentSnapshot document = snapshot.data!.docs[index];
                 Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                 String docId = document.id;
                 return blogCard(data,widget.id,docId);
              },
          );
        }
    );
  }


}
