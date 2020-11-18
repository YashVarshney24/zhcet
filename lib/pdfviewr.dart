import "package:flutter/material.dart";
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewer extends StatefulWidget {
  _PdfViewerState createState() => _PdfViewerState();

  final String urlpath;
  PdfViewer({this.urlpath});
}

class _PdfViewerState extends State<PdfViewer> {
  int totalpages = 0;
  int currentpage = 1;
  bool pdfready = false;
  PDFViewController pdfViewController;
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          PDFView(
            filePath: widget.urlpath,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: true,
            onError: (e) {
              print(e.toString());
            },
            onRender: (_pages) {
              setState(() {
                totalpages = _pages;
                pdfready = true;
              });
            },
            onViewCreated: (PDFViewController pd) {
              pdfViewController = pd;
            },
            onPageChanged: (int page, int total) {
              setState(() {});
            },
          ),
          pdfready == false
              ? Center(child: CircularProgressIndicator())
              : Offstage(),
        ]),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            currentpage > 1
                ? FloatingActionButton.extended(
                    onPressed: () {
                      currentpage -= 1;
                      pdfViewController.setPage(currentpage);
                    },
                    backgroundColor: Colors.red,
                    label: Text("Go to ${currentpage - 1}"),
                  )
                : Offstage(),
            currentpage < totalpages
                ? FloatingActionButton.extended(
                    onPressed: () {
                      currentpage += 1;
                      pdfViewController.setPage(currentpage);
                    },
                    backgroundColor: Colors.green,
                    label: Text("Go to ${currentpage + 1}"),
                  )
                : Offstage()
          ],
        ));
  }
}
