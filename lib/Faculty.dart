import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:path_provider/path_provider.dart';

import 'pdfviewr.dart';
//import 'package:payementapp/pdfviewr.dart';

//import 'package:payementapp/pdfviewr.dart';
//import 'package:razorpay_flutter/razorpay_flutter.dart';
//import 'package:toast/toast.dart';
class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  List pf = [];
  List pp = [];
  bool dataisshare = false;
  var cv;
  List nm = [];

  List teachername = [];
  List teacherpost = [];
  void initState() {
    super.initState();
    getteacherdata();
  }

  // bool cvready=false;
  geturlpdf() async {
    try {
      print(pf[0]);
      var data = await http.get("https://amu.ac.in/${pf[0]}");
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File fil = File("${dir.path}/myonlinepd.pdf");
      File urlfile = await fil.writeAsBytes(bytes);
      return urlfile;
    } catch (e) {
      print(e.toString());
    }
  }

  getupcomingnotice() async {
    List bn = [];
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
  }

  getteacherdata() async {
    String url = "https://amu.ac.in/dfacultylist.jsp?did=30";
    var response = await http.get(url);
    dom.Document document = parser.parse(response.body);
    var vn = document.getElementsByClassName("recent_posts_content");
    print(vn.length);
    for (var i = 0; i < vn.length; i++) {
      nm.add(vn[i]
          .getElementsByTagName("a")
          .where((e) => e.attributes.containsKey('href'))
          .map((e) => e.attributes['href'])
          .toList());
    }

    for (var i = 0; i < nm.length; i++) {
      pp.add(nm[i][0]);
    }

//print(nmi.length);
    for (var i = 0; i < vn.length; i++) {
      teachername.add(vn[i].getElementsByTagName("strong")[0].innerHtml);
      //print(ll.length);
    }
    print(teachername);
    for (var i = 0; i < vn.length; i++) {
      teacherpost.add(vn[i].getElementsByTagName("p")[0].innerHtml.trim());
    }
    print(teacherpost);

    setState(() {
      dataisshare = true;
    });
  }

  geturlpdf1() async {
    try {
      print("fine");
      var data = await http.get(cv[0]);
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

  getteachercv(String val) async {
    print(val);
    var response = await http.get("https://amu.ac.in/" + val);
    dom.Document document = parser.parse(response.body);
    var p =
        document.getElementsByClassName("span3 module_cont module_text_area");
    cv = p[0]
        .getElementsByTagName("a")
        .where((e) => e.attributes.containsKey('href'))
        .map((e) => e.attributes['href'])
        .toList();
    print(cv);
    geturlpdf1();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Computer Science Faculty",
            //textAlign: TextAlign.right,
            style: TextStyle(color: Colors.black),
          ),
          flexibleSpace: Image(
            image: AssetImage('images/download.jpg'),
            fit: BoxFit.cover,
          ),
          centerTitle: true,
          leading: Icon(
            Icons.person,
            color: Colors.black,
          ),
        ),
        body: Container(
            //margin: EdgeInsets.all(13.0),
            color: Colors.white,
            child: dataisshare == false
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: teachername.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            getteachercv(pp[index]);
                          },
                          child: Card(
                              child: ListTile(
                                  title: Text(teachername[index],
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 14)),
                                  trailing: Text(teacherpost[index],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)))));

                      /*Column(children:
         [Container(
          height: 60,
          padding: EdgeInsets.only(left:8),
           decoration: BoxDecoration(
            //borderRadius: BorderRadius.only(),
            color: Colors.grey[100]
           ),
           //color: Colors.black,
           width: MediaQuery.of(context).size.width-10,
           child:Row(mainAxisAlignment:MainAxisAlignment.start,
             children: [
              
            Text(teachername[index],style:TextStyle(color:Colors.orange,fontSize:13)),
            SizedBox(width:10),
            Text(teacherpost[index],style:TextStyle(color:Colors.black,fontSize:12,fontWeight:FontWeight.bold))
           ],)
          
         ),
         SizedBox(height: 10,)
         ]);*/
                    })
            /*Column(children:[
         SizedBox(height: 200,),
       
        RaisedButton(child:Text("Pay Now"),onPressed:(){getteacherdata();}),
        RaisedButton(child:Text("Pdf viewer"),onPressed:(){
       geturlpdf().then((f){
      
      }
       });


        },        
        ),
        RaisedButton(child:Text("cv Now"),onPressed:(){getteachercv();}),
         RaisedButton(child:Text("Pdf viewer2"),onPressed:(){
       geturlpdf1().then((f){
      if(f.path!=null){
        print(f.path);
        Navigator.push(context,MaterialPageRoute(builder: (context)=>PdfViewer(urlpath:f.path)));
      }
       });
         },)
        ]
        )*/

            ));
  }
}
