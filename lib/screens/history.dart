import 'package:calculatorapp/models/historymodel.dart';
import 'package:calculatorapp/utils/dbhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CalcHistory extends StatefulWidget {
  @override
  _CalcHistoryState createState() => _CalcHistoryState();
}

class _CalcHistoryState extends State<CalcHistory> {
  Future<List<Map<String, dynamic>>> calculations;

  @override
  void initState() {
    reloadExpressions();
    super.initState();
  }

  void searchExpressions(String text) {
    setState(() {
      calculations = DatabaseHelper.dbhelp.searchExpression(text);
    });
  }

  void reloadExpressions() {
    setState(() {
      calculations = DatabaseHelper.dbhelp.getAllExpressions();
    });
  }

  showMatDialog(int id) async {
    HistoryModel snapshot = await DatabaseHelper.dbhelp.getExpression(id);
    TextEditingController editingController2 =
        new TextEditingController(text: snapshot.notes == 'No notes yet' ? '':snapshot.notes);
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 200,
              width: 400,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF270F33),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 60,
                    child: Text(
                      snapshot.expression,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Google',
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                          primaryColor: Color(0xFF562071),
                        platform: TargetPlatform.iOS
                      ),
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          autofocus: true,
                          controller: editingController2,
                          cursorColor: Color(0xFF55206F),
                          style: TextStyle(
                              color: Color(0xFF270F33),
                              fontFamily: 'Google',
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter notes',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Google',
                                fontSize: 17,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: SizedBox(
                      width: 320,
                      height: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3))),
                        onPressed: () {
                          DatabaseHelper.dbhelp.updateExpression(
                              id, editingController2.text.toString());
                          reloadExpressions();
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Save',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Google',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                            Icon(
                              LineIcons.check_circle,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        color: const Color(0xFF270F33),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: SizedBox(
            width: 100,
            child: TextField(
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Google',
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
              cursorColor: Color(0xFFE6CDF1),
              decoration: InputDecoration.collapsed(
                hintText: 'Search',
                hintStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Google',
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
              onChanged: (text) {
                setState(() {
                  searchExpressions(text);
                });
              },
            ),
          ),
          backgroundColor: Color(0xFF270F33),
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10),
              color: Colors.transparent,
              child: historyBuilder(),
            ),
          ],
        ));
  }

  FutureBuilder historyBuilder() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: calculations,
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData || snapshot.data.length == 0) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.do_not_disturb,
                size: 70,
                color: Color(0xFF270F33),
              ),
              Padding(padding: const EdgeInsets.all(5)),
              Text(
                'No history',
                style: TextStyle(
                  fontSize: 19,
                  color: Color(0xFF270F33),
                ),
              ),
            ],
          ));
        } else {
          return ListView.separated(
            itemCount: snapshot.data.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Color(0xFF270F33),
                  child: Row(
                    children: [
                      Padding(padding: const EdgeInsets.all(5)),
                      Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                secondaryBackground: Container(
                  color: Color(0xFF270F33),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                      ),
                      Padding(padding: const EdgeInsets.all(5)),
                    ],
                  ),
                ),
                onDismissed: (direction) {
                  DatabaseHelper.dbhelp
                      .deleteExpression(snapshot.data[index]['id']);
                  reloadExpressions();
                },
                child: ListTile(
//                leading: ,
                  title: Text(
                    snapshot.data[index]['expression'],
                    style: TextStyle(
                        color: Color(0xFF4E4E4E),
                        fontFamily: 'Google',
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    " " + snapshot.data[index]['notes'],
                    style: TextStyle(
                        color: Color(0xFF4E4E4E),
                        fontFamily: 'Google',
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      LineIcons.edit,
                      size: 24,
                      color: Color(0xFF270F33),
                    ),
                    onPressed: () {
                      showMatDialog(snapshot.data[index]['id']);
                    },
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
