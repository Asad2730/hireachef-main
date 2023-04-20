import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Constants.dart';

class BlogDetail extends StatefulWidget {
  final  data;
  const BlogDetail({required this.data,Key? key}) : super(key: key);

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child:  Image.network(
                  widget.data['url'] ,
                  width: 130,
                  height: 130,
                ),
              ),
              const SizedBox(height: 20,),
               Text(  widget.data['title'].toString().toUpperCase(),style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
               Text(widget.data['subTitle'].toString(),style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
               Text(widget.data['description'].toString(),),

            ],
          ),
        ),
      ),
    );
  }

}
