import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/widgets/widgets.dart';

class LoadDataFromFirestore extends StatefulWidget {
  @override
  _LoadDataFromFirestoreState createState() => _LoadDataFromFirestoreState();
}

class _LoadDataFromFirestoreState extends State<LoadDataFromFirestore> {
  @override
  void initState() {
    super.initState();
    getDriversList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }

  QuerySnapshot querySnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context,),
      body: _showDrivers(),
    );
  }

  //build widget as prefered
  //i'll be using a listview.builder
  Widget _showDrivers() {
    //check if querysnapshot is null
    if (querySnapshot != null) {
      return ListView.builder(
        //primary: false,
        itemCount: querySnapshot.docs.length,

        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                  child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text("${querySnapshot.docs[index].data()['Title']}",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  SizedBox(
                    height: 8,
                  ),
                  Text(index.toRadixString(2),
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("${querySnapshot.docs[index].data()['Disc']}",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(color: Colors.blueAccent)
                ],
              )),
            ],

//             child: Column(
//               children: <Widget>[
// //load data into widgets
//                 Text(
//                   "${querySnapshot.docs[index].data()['Title']}",
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//                 Text(
//                   "${querySnapshot.docs[index].data()['Disc']}",
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ],
//             ),
          );
        },
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  //get firestore instance
  getDriversList() async {
    return await FirebaseFirestore.instance
        .collection('University')
        .orderBy("index", descending: false)
        .get();
  }
}
