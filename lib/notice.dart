import 'dart:io';

import 'package:chatapp/pdfviewr.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:path_provider/path_provider.dart';
//import 'package:payementapp/pdfviewr.dart';

class Noticepage extends StatefulWidget {
  _NoticepageState createState() => _NoticepageState();
}

class _NoticepageState extends State<Noticepage> {
  List pf = [];
  List bn = [];
  bool dataisshare = false;
  geturlpdf(String val) async {
    try {
      print(val);
      var data = await http.get("https://amu.ac.in/" + val);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File fil = File("${dir.path}/myonlinepd.pdf");
      File urlfile = await fil.writeAsBytes(bytes);
      if (urlfile.path != null) {
        print(urlfile.path);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PdfViewer(urlpath: urlfile.path)));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getupcomingnotice() async {
    String url = "https://amu.ac.in/tpozhcetnc.jsp?did=10166";
    var response = await http.get(url);
//print(response.body);
    dom.Document document = parser.parse(response.body);
    var bd = document.getElementsByClassName("sidepanel widget_posts");
    print("recent post");

    var data = bd[0].getElementsByTagName("a");
    print("\n");
    for (var i = 0; i < data.length; i++) {
      bn.add(data[i]
          .innerHtml
          .replaceAll('<img src="images/new.gif" height="12">', ""));
    }
    var hr = bd[0]
        .getElementsByTagName('a')
        .where((e) => e.attributes.containsKey('href'))
        .map((e) => e.attributes['href'])
        .toList();
    pf = hr;
    print(hr.length);
//print(document);
//print(bn[10]);
    print("pdf");
    setState(() {
      dataisshare = true;
    });
  }

  void initState() {
    super.initState();
    getupcomingnotice();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Training And Placment office Notices",
            //textAlign: TextAlign.right,
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          flexibleSpace: Image(
            image: AssetImage('images/download.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        body: Container(
            //margin: EdgeInsets.all(13.0),
            color: Colors.white,
            child: dataisshare == false
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: bn.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onDoubleTap: () {
                            geturlpdf(pf[index]);
                          },
                          child: Column(children: [
                            Container(
                                height: 160,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.amber[200]),
                                child: Text(bn[index],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800))),
                            SizedBox(height: 15)
                            /*Card(child:
            ListTile(
             title:Text(bn[index],style:TextStyle(color:Colors.red,fontSize:14)),
             )
           )*/
                          ]));
                    })));
  }
}
