import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Locate extends StatefulWidget {
  @override
  _LocateState createState() => _LocateState();
}

class _LocateState extends State<Locate> {
  static final CameraPosition initial =
      CameraPosition(target: LatLng(27.9148, 78.0763), zoom: 19);
  GoogleMapController _controller;
  Set<Marker> marker = Set.from([]);
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "ZHCET AMU",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        flexibleSpace: Image(
          image: AssetImage('images/download.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: initial,
        mapType: MapType.normal,
        markers: marker,
        onMapCreated: (controller) {
          setState(() {
            _controller = controller;
          });
        },
        onTap: (coordinates) {
          _controller.animateCamera(CameraUpdate.newLatLng(coordinates));
          Marker mark = Marker(markerId: MarkerId('1'), position: coordinates);
          setState(() {
            marker.add(mark);
          });
        },
      ),
    );
  }
}
