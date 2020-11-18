import 'package:chatapp/Faculty.dart';
import 'package:chatapp/locate.dart';
import 'package:chatapp/notice.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'USER NAME',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('images/download.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
              leading: Icon(Icons.person),
              title: Text('Faculty'),
              onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()))
                  }),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Notices'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Noticepage()))
            },
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Chat'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.location_searching),
            title: Text('Locate'),
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Locate()))
            },
          ),
          ListTile(
            leading: Icon(Icons.developer_board),
            title: Text('Developers'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
      ),
    );
  }
}
