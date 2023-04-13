import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireachef/widgets/navigation/bottom_navigation.dart';
import 'package:hireachef/widgets/navigation/catering_navigation.dart';
import 'package:hireachef/widgets/navigation/chef_navigation.dart';

import '../../../Constants.dart';
import '../../../widgets/cards/customer/conversation_card.dart';

class ChatMain extends StatefulWidget {
  ChatMain({Key? key}) : super(key: key);
  var id;
  ChatMain.set({this.id});
  @override
  State<ChatMain> createState() => _ChatMainState();
}

class _ChatMainState extends State<ChatMain> {


  bottomNavigation(){
    if(widget.id==1){
      return navigationBar(context, 1);
    }else if (widget.id==2){
      return chefNavigation(context, 1);
    }else if (widget.id==3){
      return cateringNavigation(context, 1);
    }else if (widget.id==4){

    }
  }


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
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Conversations",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Colors.grey.shade100
                      )
                  ),
                ),
              ),
              ListView.builder(
                itemCount: 15,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 16),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return convoCard(
                    "Jane Russel",
                    "Awesome Setup",
                    'assets/avatar.png',
                    "Yesterday",
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigation()
    );
  }
}
