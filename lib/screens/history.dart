import 'package:calculatorapp/models/historymodel.dart';
import 'package:calculatorapp/utils/dbhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalcHistory extends StatefulWidget {
  @override
  _CalcHistoryState createState() => _CalcHistoryState();
}

class _CalcHistoryState extends State<CalcHistory> {
  Future<List<Map<String, dynamic>>> calculations;
  bool searchMode = false;

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
        new TextEditingController(text: snapshot.notes);
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 210,
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller:
                          TextEditingController(text: snapshot.expression),
                      readOnly: true,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3),
                    ),
                    TextField(
                      controller: editingController2,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter notes'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3),
                    ),
                    SizedBox(
                      width: 320,
                      height: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3))),
                        onPressed: () {
                          DatabaseHelper.dbhelp.updateUser(
                              id, editingController2.text.toString());
                          reloadExpressions();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Google',
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                        color: const Color(0xFF4E4E4E),
                      ),
                    )
                  ],
                ),
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
              Icons.arrow_back_ios,
              size: 21,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: searchMode
              ? SizedBox(
                  width: 100,
                  child: TextField(
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Google',
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
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
                        if (searchMode == true)
                          searchExpressions(text);
                      });

                    },
                  ),
                )
              : Text(
                  'History',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Google',
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
          actions: [
            IconButton(
              icon: searchMode ? Icon(Icons.close) : Icon(Icons.search),
              onPressed: () {
                setState(() {
                  if (searchMode == false) {
                    searchMode = true;
                  } else {
                    searchMode = false;
                    reloadExpressions();
                  }
                });
              },
            )
          ],
          backgroundColor: Color(0xFF4E4E4E),
        ),
        body: Stack(
          children: [
            Container(
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
                 Icon(Icons.do_not_disturb, size: 50, color: Color(0xFF4E4E4E),),
                Text(
                  'No history',
                  style: TextStyle(fontSize: 19, color: Color(0xFF4E4E4E)),
                ),
              ],
            )
          );
        } else {
          return ListView.separated(
            itemCount: snapshot.data.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Color(0xFF4E4E4E),
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
                  color: Color(0xFF4E4E4E),
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
                      Icons.edit,
                      size: 21,
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
