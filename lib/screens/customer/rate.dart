import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hireachef/Helper.dart';
import 'package:hireachef/widgets/navigation/bottom_navigation.dart';
import 'package:hireachef/widgets/navigation/catering_navigation.dart';
import 'package:hireachef/widgets/navigation/chef_navigation.dart';

import '../../../Constants.dart';
import '../../../widgets/cards/customer/conversation_card.dart';

class Rate extends StatefulWidget {
  const Rate({Key? key}) : super(key: key);

  @override
  State<Rate> createState() => _RateState();
}

class _RateState extends State<Rate> {

  late double rate;

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
          child:  SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Rate",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                _list(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: navigationBar(context, 5)
    );
  }


  Future<List<Map<String, dynamic>>> getData() async {
    List<Future<Map<String, dynamic>>> userQueries = [];

    QuerySnapshot requests = await FirebaseFirestore.instance
        .collection('requests')
        .where('ids', arrayContainsAny: [Helper.loggedUser.id])
        .where('status',isEqualTo: 1)
        .get();

    Set<String> processedIds = {}; // Store processed docIds in a set

    requests.docs.forEach((requestDoc) {
      String docId = requestDoc
          .get('ids')
          .firstWhere((id) => id != Helper.loggedUser.id);
      if (!processedIds.contains(docId)) {
        userQueries.add(FirebaseFirestore.instance
            .collection('users')
            .doc(docId)
            .get()
            .then((doc) => {'id': doc.id, ...doc.data()!}));
        processedIds.add(docId); // Add processed docId to the set
      }
    });

    List<Map<String, dynamic>> users = await Future.wait(userQueries);
    return users;
  }





  Widget _list() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 16),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context, int index) {
            Map<String, dynamic> data = snapshot.data![index];
            String id = data['id'];
            return Column(
              children: [
                const SizedBox(height: 10,),
                Text(data['username'].toString().toUpperCase()),
                const SizedBox(height: 10,),
                 RatingBar.builder(
                 initialRating: 1,
                 minRating: 1,
                 direction: Axis.horizontal,
                 allowHalfRating: true,
                 itemCount: 5,
                 itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                 itemBuilder: (context, _) => const Icon(
                   Icons.star,
                   color: Colors.amber,
                 ),
                 onRatingUpdate: (rating) {
                   rate = rating;
                 },

               ),
               const SizedBox(height: 10,),
               TextButton(onPressed: (){
                 _updateRate(id, rate);
               },child: const Text('RATE',style: TextStyle(color: Colors.purple),)),
              ],
            );
          },
        );
      },
    );
  }


  Future<void> _updateRate(String id, double rating) async {
    try {
      final CollectionReference db = FirebaseFirestore.instance.collection('users');
      final docSnapshot = await db.doc(id).get();
      print('${docSnapshot.exists}');
      if (!docSnapshot.exists) {
        await db.doc(id).set({'rating': rating, 'rateCount': 1});
      } else {
        final data = docSnapshot.data() as Map<String, dynamic>;
        if (data != null) {
          final previousRating = (data['rating'] ?? 0.0) as double;
          final rateCount = (data['rateCount'] ?? 0) as int;
          final newRating = (previousRating * rateCount + rating) / (rateCount + 1);
          await db.doc(id).set({'rating': newRating, 'rateCount': rateCount + 1}, SetOptions(merge: true));
        }
      }

      Fluttertoast.showToast(msg: 'Rated');
    } catch (ex) {
      print(ex);
    }
  }


}
