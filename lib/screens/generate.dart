import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

class Generate extends StatefulWidget {
  @override
  _GenerateState createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  GlobalKey globalKey = new GlobalKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String qrData = "http://www.google.com";
  TextEditingController teText = new TextEditingController();
  bool qr = true;
  BorderRadiusGeometry radius = BorderRadius.all(Radius.circular(10));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                LineIcons.arrow_left,
                size: 21,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    LineIcons.share_alt,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    try {
                      RenderRepaintBoundary boundary =
                          globalKey.currentContext.findRenderObject();
                      var image = await boundary.toImage();

                      ByteData byteData = await image.toByteData(
                        format: ImageByteFormat.png,
                      );
                      Uint8List pngBytes = byteData.buffer.asUint8List();

                      final tempDir = await getTemporaryDirectory();
                      final file =
                          await new File('${tempDir.path}/image.png').create();
                      await file.writeAsBytes(pngBytes);

                      ShareExtend.share(
                        file.path,
                        "file",
                      );
                    } catch (e) {
                      print(e.toString());
                    }
                  })
            ],
            title: Text(
              'Generate QR',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Google',
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
            elevation: 0,
            backgroundColor: Color(0xFF2B1137)),
        body: Container(
            child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(19),
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xFF270F33),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFFF1F1FE),
                          blurRadius: 15.0,
                          offset: Offset(0.3, 4.0))
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(14))),
                child: RepaintBoundary(
                    key: globalKey,
                    child: qr == true
                        ? QrImage(
                            data: qrData,
                            size: 200,
                            padding: EdgeInsets.fromLTRB(10, 10, 20, 20),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          )
                        : BarCodeImage(
                            params: Code39BarCodeParams(
                              "$qrData",
                              lineWidth:
                                  2.0, // width for a single black/white bar (default: 2.0)
                              barHeight:
                                  90.0, // height for the entire widget (default: 100.0)
                              withText:
                                  true, // Render with text label or not (default: false)
                            ),
                            onError: (error) {
                              // Error handler
                              _scaffoldKey.currentState.showSnackBar(
                                  new SnackBar(
                                      content: new Text('Capslock is off')));
                              print('error = $error');
                            },
                          ))),
            SizedBox(height: 20.0),
            Row(
              children: [
                Container(
                  width: 2.0,
                  height: 5.0,
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
                Text('Get your own QR Code',
                    style: TextStyle(
                        fontFamily: 'Google',
                        fontSize: 16,
                        color: Color(0xFF270F33),
                        fontWeight: FontWeight.w600))
              ],
            ),
            Container(
              height: 55,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 12),
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFFF1F1FD),
                        blurRadius: 15.0,
                        offset: Offset(0.3, 4.0))
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              child: TextField(
                controller: teText,
                style: TextStyle(
                    fontFamily: 'Google',
                    fontSize: 16,
                    color: Color(0xFF270F33),
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration.collapsed(
                    hintText: 'Enter the Data/Link',
                    hintStyle: TextStyle(
                        fontFamily: 'Google',
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    focusColor: Color(0xFF2B1137),
                    fillColor: Color(0xFF2B1137),
                    hoverColor: Color(0xFF2B1137)),
              ),
            ),
            Divider(),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 5)),
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
              child: new FlatButton(
                padding: EdgeInsets.all(10),
                onPressed: () {
                  setState(() {
                    qr = true;
                  });
                  if (teText.text.isEmpty) {
                    setState(() {
                      qrData = 'http://google.com';
                    });
                  } else {
                    setState(() {
                      qrData = teText.text;
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 7, right: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Generate QR Code',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Google',
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
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
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 5)),
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
              child: new FlatButton(
                padding: EdgeInsets.all(10),
                onPressed: () {
                  setState(() {
                    qr = false;
                  });
                  if (teText.text.isEmpty) {
                    setState(() {
                      qrData = 'http://google.com';
                    });
                  } else {
                    setState(() {
                      qrData = teText.text;
                    });
                  }
                  //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> new Generate()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 7, right: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Generate bar code',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Google',
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        LineIcons.barcode,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
