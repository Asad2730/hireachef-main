import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:hireachef/widgets/textfields/text_field.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Constants.dart';

class EditDish extends StatefulWidget {
  final String name,description,id,url;
  final double price;
  const EditDish({Key? key, required this.name, required this.description,
    required this.price, required this.id, required this.url}) : super(key: key);

  @override
  State<EditDish> createState() => _EditDishState();
}

class _EditDishState extends State<EditDish> {

  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();

  var imageFile;

  getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    name.text = widget.name;
    description.text = widget.description;
    price.text = widget.price.toString();
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
              GestureDetector(
                onTap: (){
                  getFromGallery();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200.0),
                  child: imageFile!=null?Image.file(imageFile,width: 130,height: 130,):const Image(
                    image: AssetImage("assets/camera.png"),
                    width: 130,
                    height: 130,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              textField(name, "Item Name", Icons.drive_file_rename_outline),
              textField(price, "Price", Icons.monetization_on_outlined),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: TextFormField(
                  maxLines: 4,
                  controller: description,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Description",
                    prefixIcon: Icon(Icons.description_outlined),
                  ),
                ),
              ),
              GestureDetector(
                onTap: ()=>addDish(),
                child: Container(
                  width: Get.width,
                  height: 50,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Constant.orange,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Add Item",
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
      ),
    );
  }


  Future addDish() async{
    try{
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      String downloadURL = widget.url;
      if(imageFile != null){

        final FirebaseStorage storage = FirebaseStorage.instance;
        final Reference ref = storage.ref().child('dish/$uniqueFileName');
        final TaskSnapshot uploadTask = await ref.putFile(imageFile);
        downloadURL = await uploadTask.ref.getDownloadURL();
      }

      Map<String,dynamic> data = {
        'name':name.text.toString(),
        'price':double.parse(price.text.toString()),
        'description':description.text.toString(),
        'url': downloadURL,
      };

     await FirebaseFirestore.instance
          .collection('dishes')
          .doc(widget.id)
          .update(data);

      Fluttertoast.showToast(msg: 'updated!');
      Get.back();
    }catch(ex){
      print('ex $ex');
      Fluttertoast.showToast(msg: ex.toString());
    }
  }

}
