import 'package:calculatorapp/models/historymodel.dart';
import 'package:calculatorapp/utils/dbhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalcHistory extends StatefulWidget {
  @override
  _CalcHistoryState createState() => _CalcHistoryState();
}

class _CalcHistoryState extends State<CalcHistory> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 21,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'History',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Google',
              fontSize: 20,
              fontWeight: FontWeight.w400),
        ),
        backgroundColor: Color(0xFF4E4E4E),
      ),
      body: Container(
        color: Colors.transparent,
        child: historyBuilder(),
      ),
    );
  }

  FutureBuilder historyBuilder() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DatabaseHelper.dbhelp.getAllExpressions(),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('No data', style: TextStyle(fontSize: 22),),
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
                    onPressed: () {},
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
