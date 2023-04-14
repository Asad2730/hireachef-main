import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hireachef/Helper.dart';

import '../../Constants.dart';

class PasswordEdit extends StatefulWidget {
  const PasswordEdit({Key? key}) : super(key: key);

  @override
  State<PasswordEdit> createState() => _PasswordEditState();
}

class _PasswordEditState extends State<PasswordEdit> {

  final FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController new_password = TextEditingController();
  TextEditingController conirm_password = TextEditingController();

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(
              height: 30,
            ),
            const Text("New Password"),
            TextField(
              controller: new_password,
              decoration: const InputDecoration(isDense: true),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text("Confirm Password"),
            TextField(
              controller: conirm_password,
              decoration: const InputDecoration(isDense: true),
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: ()=>update(),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  alignment: Alignment.center,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Constant.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.5,
                        offset: Offset(1, 1), // Shadow position
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "Update Password",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future update() async{
    if(new_password.text.toString().trim() == conirm_password.text.toString().trim()){
      await db.collection('users').doc(Helper.loggedUser.id)
          .update({'password':new_password.text.toString()});
      Fluttertoast.showToast(msg: 'Password updated!');
      Get.back();
    }else{
      Fluttertoast.showToast(msg: 'Error:both passwords should match!');
    }
  }

}
