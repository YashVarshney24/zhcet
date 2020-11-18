import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  clickphoto() async {
    var picker = ImagePicker();
    await picker.getImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ZHCETAPP",
          style: TextStyle(color: Colors.black),
        ),
        flexibleSpace: Image(
          image: AssetImage('images/download.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: 10,
          ),
        ],
      ),
    );
  }
}
