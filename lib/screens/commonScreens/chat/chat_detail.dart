import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireachef/Constants.dart';

import '../../../Helper.dart';

class ChatDetail extends StatefulWidget {
  final String id, name, pic;
  const ChatDetail(
      {required this.id, required this.name, Key? key, required this.pic})
      : super(key: key);

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  TextEditingController msg = TextEditingController();

  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];

  List<Messages> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Constant.orange,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.pic),
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  widget.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
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
        child: Stack(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: _stream(),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
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
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: msg,
                        decoration: const InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () => message(),
                      backgroundColor: Colors.blue,
                      elevation: 0,
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future message() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection('messages').get().then((value) {
      Map<String, dynamic> data = {
        'from': Helper.loggedUser.id,
        'to': widget.id,
        'ids': ['${Helper.loggedUser.id}/${widget.id}'],
        'msg': msg.text.toString(),
        'count': value.docs.length,
        // 'count2': value.docs.length,
      };
      db.collection('messages').add(data);
    });

    msg.clear();
    // getData();
  }

  Stream<QuerySnapshot> getData() {
    list.clear();
    String op1 = '${Helper.loggedUser.id}/${widget.id}';
    String op2 = '${widget.id}/${Helper.loggedUser.id}';
    // var data = FirebaseFirestore.instance
    //     .collection('messages')
    //     .where('ids', arrayContainsAny: [op1, op2])
    //     // .orderBy('count', descending: false)
    //     .get();

    // data.then((value) => {
    //       value.docs.forEach((element) {
    //         var temp = Messages();
    //         temp.msg = element.get('msg');
    //         temp.count = element.get('count');
    //         temp.to = element.get('to');
    //         list.add(temp);
    //       })
    //     });

    return FirebaseFirestore.instance
        .collection('messages')
        .where('ids', arrayContainsAny: [op1, op2])
        .orderBy('count', descending: false)
        .snapshots();
  }

  Widget _stream() {
    //   ListView.builder(
    //     itemCount: list.length,
    //     itemBuilder: (BuildContext context, int index) {
    //     return Container(
    //                 padding: const EdgeInsets.only(
    //                     left: 14, right: 14, top: 10, bottom: 10),
    //                 child: Align(
    //                   alignment: (list.elementAt(index).from == widget.id
    //                       ? Alignment.topLeft
    //                       : Alignment.topRight),
    //                   child: Container(
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(20),
    //                       color: (list.elementAt(index).to == Helper.loggedUser.id
    //                           ? Colors.grey.shade200
    //                           : Colors.blue[200]),
    //                     ),
    //                     padding: const EdgeInsets.all(16),
    //                     child: Text(
    //                       list.elementAt(index).msg,
    //                       style: const TextStyle(fontSize: 15),
    //                     ),
    //                   ),
    //                 ),
    //               );
    //   }
    // );

    return StreamBuilder<QuerySnapshot>(
      stream: getData(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          //   reverse: true,
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          //   physics: const NeverScrollableScrollPhysics(),
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Container(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (data['from'] == widget.id
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (data['to'] == Helper.loggedUser.id
                            ? Colors.grey.shade200
                            : Colors.blue[200]),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        data['msg'],
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                );
              })
              .toList()
              .cast(),
        );
      },
    );
  }
}

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}
