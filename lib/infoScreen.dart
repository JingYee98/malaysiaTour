import 'package:flutter/material.dart';
import 'package:malaysiatour/location.dart';
import 'dart:async';
import 'package:malaysiatour/mainScreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() => runApp(InfoScreen());

class InfoScreen extends StatefulWidget {
  final Location loc;

  const InfoScreen({Key key, this.loc}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  List destData;
  double screenHeight, screenWidth;
  Completer<GoogleMapController> _mapController = Completer();
  MarkerId markerId1 = MarkerId("12");
  Set<Marker> markers = Set();

  @override
  void initState() {
    super.initState();
    print("info screen");
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.loc.locname + " , " + widget.loc.state),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Flexible(
                  child: Container(
                    height: screenHeight / 3,
                    width: screenWidth / 2,
                    decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl:
                          "http://slumberjer.com/visitmalaysia/images/${widget.loc.imagename}",
                      placeholder: (context, url) =>
                          new SizedBox(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Flexible(
                  child: Card(
                    child: Table(
                        defaultColumnWidth: FlexColumnWidth(1.0),
                        columnWidths: {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(7),
                        },
                        children: [
                          TableRow(children: [
                            TableCell(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 150,
                                  child: Text("Description",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black))),
                            ),
                            TableCell(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 150,
                                child: Text(widget.loc.description,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black)),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 30,
                                  child: Text("URL",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black))),
                            ),
                            TableCell(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 30,
                                child: GestureDetector(
                                  child: Text(widget.loc.url,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black)),
                                  onTap: () => _url(),
                                ),
                              ),
                            )
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 50,
                                  child: Text("Address",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black))),
                            ),
                            TableCell(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 50,
                                child: Text(widget.loc.address,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black)),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 30,
                                  child: Text("Phone",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black))),
                            ),
                            TableCell(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 30,
                                child: GestureDetector(
                                    child: Text(widget.loc.contact,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black)),
                                    onTap: () => _call()),
                              ),
                            )
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 30,
                                  child: Text("Location",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black))),
                            ),
                            TableCell(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 30,
                                child: FlatButton(
                                  color: Colors.blue[200],
                                  onPressed: () => {_loadMap()},
                                  child: Icon(
                                    MdiIcons.locationEnter,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ]),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future<bool> _onBackPressed() {
    return Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MainScreen())) ??
        false;
  }

  _loadMap() {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, newSetState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: Text(
                "Location",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              titlePadding: EdgeInsets.all(5),
              actions: <Widget>[
                Text(
                  widget.loc.address,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: screenHeight / 2 ?? 600,
                  width: screenWidth ?? 360,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    markers: markers.toSet(),
                    initialCameraPosition: CameraPosition(
                        target:
                            LatLng(widget.loc.latitude, widget.loc.longitude),
                        zoom: 14.0),
                    onMapCreated: (controller) {
                      _mapController.complete(controller);
                    },
                  ),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  height: 30,
                  child: Text('Close'),
                  color: Colors.blue[200],
                  textColor: Colors.black,
                  elevation: 10,
                  onPressed: () =>
                      {markers.clear(), Navigator.of(context).pop(false)},
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future <void> _call() async{
    await launch('tel:+6${widget.loc.contact}');
  }

  Future <void> _url() async{
    await launch('https:${widget.loc.url}');
  }
}
