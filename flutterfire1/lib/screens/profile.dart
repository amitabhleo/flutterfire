import 'dart:io';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _imageLink =
      "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg";

  late File _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
      child: Column(
        children: <Widget>[
          _imageLink != null
              ? CircleAvatar(
                  maxRadius: 100.0,
                  child: ClipOval(
                    child: Image.network(
                      _imageLink,
                      fit: BoxFit.cover,
                      width: 190,
                      height: 190,
                    ),

                    //child: Image.network(
                    // 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                  ),
                )
              : CircleAvatar(
                  maxRadius: 100.0,
                  child: ClipOval(
                    child: Image.network(
                        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                  ),
                ),
          SizedBox(
            height: 30,
          ),
          TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green)),
            onPressed: () async {
              //File _image;
              final picker = ImagePicker();
              // Future getImage() async {
              final pickedfile = (await picker.getImage(
                  source: ImageSource.camera, imageQuality: 50));
              setState(() {
                if (pickedfile != null) {
                  _image = File(pickedfile.path);
                  uploadpic(context);
                  //print('image link : $_image');
                } else {
                  print('No image selected.');
                }
              });
            },
            child: Text("Upload Photo"),
          ),
        ],
      ),
    );
  }

  Future uploadpic(BuildContext context) async {
    firebase_storage.Reference fireBaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('pictures')
        .child("image1");

    firebase_storage.UploadTask uploadTask = fireBaseStorageRef.putFile(_image);
    //StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    var dowurl = await (await uploadTask).ref.getDownloadURL();
    if (dowurl != null) {
      CircularProgressIndicator();
      print('Download URL : $dowurl');
      _imageLink = dowurl;
    }
    setState(() {
      if (dowurl != null) {
        _imageLink = dowurl;
      } else {
        print('No image url saved.');
      }
    });
  }

  // print('image downloaded $dowurl');
}
