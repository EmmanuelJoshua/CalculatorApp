import 'package:flutter/cupertino.dart';
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
  BorderRadiusGeometry radius = BorderRadius.all(Radius.circular(10));
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Builder(
        builder: (BuildContext context) {
          return Stack(
            children: <Widget>[
              Container(
                height: 300,
                margin: EdgeInsets.fromLTRB(30, 30, 30, 10),
                decoration: BoxDecoration(
                    color: Color(0xFFF4F4F4),
                    borderRadius: radius,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFFF1F1F1),
                          blurRadius: 15.0,
                          offset: Offset(0.3, 4.0))
                    ]),
                child: Material(
                  type: MaterialType.transparency,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Container(
                            width: 12.0,
                            height: 60.0,
                            color: Colors.transparent,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              height: 1.5,
                              width: 19,
                              color: Color(0xFFD1D1D3),
                            ),
                          ),
                          Text('Result',
                              style: TextStyle(
                                  fontFamily: 'Google',
                                  fontSize: 16,
                                  color: Color(0xFF270F33),
                                  fontWeight: FontWeight.w600))
                        ],
                      ),
                      Center(
                        child: Container(
                          height: 150,
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                          child: Image.asset(
                            'assets/images/qr-code2.png',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 58.3,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xFF270F33),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFFF1F1F1),
                                    blurRadius: 15.0,
                                    offset: Offset(0.3, 4.0))
                              ],
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(14),
                                  bottomLeft: Radius.circular(14))),
                          child: _value == ''
                              ? Text('Nothing scanned yet',
                                  style: TextStyle(
                                      fontFamily: 'Google',
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600))
                              : Linkify(
                                  text: '$_value',
                                  style: TextStyle(
                                      fontFamily: 'Google',
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600))),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(40, 380, 40, 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: radius,
                          gradient: LinearGradient(
                              colors: [
                                Color(0xFFD46286),
                                Color(0xFF781C50),
                              ],
                              tileMode: TileMode.mirror,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                        ),
                        child: FlatButton(
                          padding: EdgeInsets.all(10),
                          onPressed: () => scan(),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 7, right: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Scan',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Google',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                Icon(
                                  LineIcons.qrcode,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: radius,
                          gradient: LinearGradient(
                              colors: [
                                Color(0xFFD46286),
                                Color(0xFF781C50),
                              ],
                              tileMode: TileMode.mirror,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                        ),
                        child: FlatButton(
                          padding: EdgeInsets.all(10),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Generate()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 7, right: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Generate',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Google',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                Icon(
                                  LineIcons.arrow_circle_o_right,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ]),
              )
            ],
          );
        },
      ),
    );
  }

  Future scan() async {
    _result = await FlutterBarcodeScanner.scanBarcode(
      '#004297',
      'Cancel',
      true,
    );
    setState(() {
      _value = _result;
    });
  }
}
