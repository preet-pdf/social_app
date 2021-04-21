import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:social_app/services/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  String authorName, title, desc;

  File selectedImage;
  final picker = ImagePicker();
  bool _isLoading = false;
  CrudMethods crudMethods = new CrudMethods();

  Future getImage() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  /*Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = image;
    });
  }*/

  Future<void> uploadBlog() async {
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });

      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");
      final UploadTask task = firebaseStorageRef.putFile(selectedImage);

      /// uploading image to firebase storage
      /*StorageReference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");
      final StorageUploadTask task = firebaseStorageRef.putFile(selectedImage);*/

      /*var downloadUrl = await (await task */ /*.onComplete*/ /*).ref.getDownloadURL();
      print("this is url $downloadUrl");*/

      var imageUrl;
      await task.whenComplete(() async {
        try {
          imageUrl = await firebaseStorageRef.getDownloadURL();
        } catch (onError) {
          print("Error");
        }

        print(imageUrl);
      });

      Map<String, String> blogMap = {
        "imgUrl": imageUrl,
        "authorName": authorName,
        "title": title,
        "desc": desc
      };

      /*Map<String, dynamic> blogData = {
        "imgUrl": imageUrl,
        "author": authorTextEditingController.text,
        "title": titleTextEditingController.text,
        "desc": descTextEditingController.text
      };*/

      /*crudMethods.addData(blogMap).then((result) {
        Navigator.pop(context);
      });
    } else {}
  }*/

      crudMethods.addData(blogMap).then((value) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      });

      // upload the blog info
    }
  }

  //
  /*TextEditingController titleTextEditingController =
      new TextEditingController();
  TextEditingController descTextEditingController = new TextEditingController();
  TextEditingController authorTextEditingController =
      new TextEditingController();*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style: TextStyle(fontSize: 22),
            ),
            Text(
              "Blog",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              uploadBlog();
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.file_upload)),
          )
        ],
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: selectedImage != null
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 170,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  selectedImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 170,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6)),
                              width: MediaQuery.of(context).size.width,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.black45,
                              ),
                            )),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(hintText: "Author Name"),
                          onChanged: (val) {
                            authorName = val;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: "Title"),
                          onChanged: (val) {
                            title = val;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: "Desc"),
                          onChanged: (val) {
                            desc = val;
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}