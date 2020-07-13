import 'package:flutter/material.dart';
import 'dart:async';
//import 'image.dart';

import 'package:calculatorapp/screens/generate.dart';

import 'package:line_icons/line_icons.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import 'dart:ui';
import 'package:pdf/widgets.dart' as pw;

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  final pdf = pw.Document();
  String _result = "";
  String _value = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
                actions: <Widget>[
//                  IconButton(
//                      icon: Icon(Icons.camera_alt),
//                      onPressed: () {
//                        Navigator.of(context).push(MaterialPageRoute(
//                            builder: (context) => ImageFile()));
//                      })
                ],
                leading: IconButton(
                  icon: Icon(
                    LineIcons.arrow_left,
                    size: 21,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                title: Text(
                  'QR Code',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Google',
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
                elevation: 0,
                backgroundColor: Color(0xFF2B1137)),
            body: Form(
              child: new Builder(
                builder: (BuildContext context) {
                  return new Stack(
                    children: <Widget>[
                      new Container(
                        // height: 230,
                        width: 1000,
                        margin: EdgeInsets.only(left: 70, top: 15),
                      ),
                      new Container(
                        height: 400,
                        margin: EdgeInsets.fromLTRB(30, 80, 30, 10),
                        child: new Card(
                          color: Colors.white,
                          elevation: 5.0,
                          margin: EdgeInsets.only(right: 15.0, left: 15.0),
                          child: new Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: <Widget>[
                              Center(
                                child: new Container(
                                    margin: EdgeInsets.all(20),
                                    child: Text('Result :',
                                        style: TextStyle(
                                            fontFamily: 'Google',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400))),
                              ),
                              Center(
                                child: new Container(
                                  height: 230,
                                  margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                                  child: new Image.asset(
                                    'assets/images/scan.jpg',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              Center(
                                child: new Container(
                                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    child: _value == ''
                                        ? Text('Nothing scanned yet')
                                        : Linkify(
                                            text: '$_value',
                                            style: TextStyle(fontSize: 16),
                                          )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      new Container(
                        padding: EdgeInsets.fromLTRB(40, 500, 40, 20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              new FlatButton(
                                padding: EdgeInsets.all(10),
                                onPressed: () => scan(),
                                child: Text('Scan QR Code',
                                    style: TextStyle(
                                        fontFamily: 'Google',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                        color: Color(0xFF2B1137), width: 2.0)),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                              FlatButton(
                                padding: EdgeInsets.all(10),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new Generate()));
                                },
                                child: Text('Generate QR Code',
                                    style: TextStyle(
                                        fontFamily: 'Google',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                        color: Color(0xFF2B1137), width: 2.0)),
                              )
                            ]),
                      )
                    ],
                  );
                },
              ),
            ));
  }

  Future scan() async {
    _result =
        await FlutterBarcodeScanner.scanBarcode('#004297', 'Cancel', true);
    setState(() {
      _value = _result;
    });
  }
}
