import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:malaysiatour/infoScreen.dart';
import 'package:malaysiatour/location.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MainScreen());

class MainScreen extends StatefulWidget {
  final Location loc;

  const MainScreen({Key key, this.loc}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List destData;
  double screenHeight, screenWidth;
  bool _visible = false;
  String curstate = "Kedah";
  String titlecenter = "No Destination Found";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightBlue,
            title: Text(
              'Destination List',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: _visible
                    ? new Icon(Icons.expand_more)
                    : new Icon(Icons.expand_less),
                onPressed: () {
                  setState(() {
                    if (_visible) {
                      _visible = false;
                    } else {
                      _visible = true;
                    }
                  });
                },
              ),
            ],
          ),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Visibility(
                  visible: _visible,
                  child: Card(
                      elevation: 10,
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () => _sortItem("Kedah"),
                                        color: Colors.blue[200],
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Kedah",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () => _sortItem("Kelantan"),
                                        color: Colors.blue[200],
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Kelantan",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () => _sortItem("Perlis"),
                                        color: Colors.blue[200],
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Perlis",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () => _sortItem("Johor"),
                                        color: Colors.blue[200],
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Johor",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () => _sortItem("Perak"),
                                        color: Colors.blue[200],
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Perak",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () => _sortItem("Selangor"),
                                        color: Colors.blue[200],
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Selangor",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () => _sortItem("Melaka"),
                                        color: Colors.blue[200],
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Melaka",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () =>
                                            _sortItem("Negeri Sembilan"),
                                        color: Colors.blue[200],
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Negeri Sembilan",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () => _sortItem("Pahang"),
                                        color: Colors.blue[200],
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Pahang",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () => _sortItem("Penang"),
                                        color: Colors.blue[200],
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Penang",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () => _sortItem("Sabah"),
                                        color: Colors.blue[200],
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Sabah",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () => _sortItem("Sarawak"),
                                        color: Colors.blue[200],
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Sarawak",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () =>
                                            _sortItem("Terengganu"),
                                        color: Colors.blue[200],
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Terengganu",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ))),
                ),
                Text(curstate,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                destData == null
                    ? Flexible(
                        child: Container(
                            child: Center(
                                child: Text(
                        titlecenter,
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ))))
                    : Expanded(
                        child: GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio:
                                (screenWidth / screenHeight) / 0.8,
                            children: List.generate(destData.length, (index) {
                              return Container(
                                  child: Card(
                                      elevation: 10,
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () =>
                                                  _onImageDisplay(index),
                                              child: Container(
                                                height: screenHeight / 6,
                                                width: screenWidth / 4,
                                                child: ClipOval(
                                                    child: CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  imageUrl:
                                                      "http://slumberjer.com/visitmalaysia/images/${destData[index]['imagename']}",
                                                  placeholder: (context, url) =>
                                                      new CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          new Icon(Icons.error),
                                                )),
                                              ),
                                            ),
                                            Text(destData[index]['loc_name'],
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                            Text(destData[index]['state'],
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                            MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                              minWidth: 100,
                                              height: 30,
                                              child: Text(
                                                'Info',
                                              ),
                                              color: Colors.blue[200],
                                              textColor: Colors.black,
                                              elevation: 10,
                                              onPressed: () => _toInfo(index),
                                            ),
                                          ],
                                        ),
                                      )));
                            })))
              ],
            ),
          ),
        ));
  }

  void _loadData() {
    String urlLoadJobs =
        "http://slumberjer.com/visitmalaysia/load_destinations.php";
    http.post(urlLoadJobs, body: {}).then((res) {
      setState(() {
        var extractdata = json.decode(res.body);
        destData = extractdata["locations"];
      });
    }).catchError((err) {
      print(err);
    });
    _loadPref();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: new Text(
              'Are you sure?',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: new Text(
              'Do you want to exit MALAYSIA TOUR',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Text(
                    "Exit",
                    style: TextStyle(
                      color: Colors.blue[900],
                    ),
                  )),
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.blue[900],
                    ),
                  )),
            ],
          ),
        ) ??
        false;
  }

  void _sortItem(String state) {
    try {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: true);
      pr.style(message: "Searching...");
      pr.show();
      String urlLoadJobs =
          "http://slumberjer.com/visitmalaysia/load_destinations.php";
      http.post(urlLoadJobs, body: {
        "state": state,
      }).then((res) {
        setState(() {
          curstate = state;
          var extractdata = json.decode(res.body);
          destData = extractdata["locations"];
          FocusScope.of(context).requestFocus(new FocusNode());

          pr.hide();
        });
      }).catchError((err) {
        print(err);
        pr.hide();
      });
      pr.hide();
    } catch (e) {
      Toast.show("Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
    _savePref();
  }

  _onImageDisplay(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: new Container(
              color: Colors.white,
              height: screenHeight / 2.2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: screenWidth / 1.5,
                      width: screenWidth / 1.5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.scaleDown,
                              image: NetworkImage(
                                  "http://slumberjer.com/visitmalaysia/images/${destData[index]['imagename']}")))),
                ],
              ),
            ));
      },
    );
  }

  void _toInfo(int index) {
    Location _loc = new Location(
        pid: destData[index]['pid'],
        locname: destData[index]['loc_name'],
        state: destData[index]['state'],
        description: destData[index]['description'],
        latitude: double.parse(destData[index]['latitude']),
        longitude: double.parse(destData[index]['longitude']),
        url: destData[index]['url'],
        contact: destData[index]['contact'],
        address: destData[index]['address'],
        imagename: destData[index]['imagename']);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => InfoScreen(
                  loc: _loc,
                )));
  }

  _savePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('state', curstate);
  }

  _loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    curstate = prefs.getString('state');
    return curstate;
  }
}
