import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'page_addlist.dart';

class TaskPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage>
    with SingleTickerProviderStateMixin {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          _getToolbar(context),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Task',
                            style: new TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Lists',
                            style: new TextStyle(
                                fontSize: 28.0, color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: new Column(
                  children: <Widget>[
                    new Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                          border: new Border.all(color: Colors.black38),
                          borderRadius: BorderRadius.all(Radius.circular(7.0))),
                      child: new IconButton(
                        icon: new Icon(Icons.add),
                        onPressed: () {},
                        iconSize: 30.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text('Add List',
                          style: TextStyle(color: Colors.black45)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Container(
              height: 360.0,
              padding: EdgeInsets.only(bottom: 25.0),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(left: 40.0, right: 40.0),
                scrollDirection: Axis.horizontal,
                children: getExpenseItemsStatic(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getExpenseItemsStatic() {
    List<Map<String, dynamic>> staticData = [
      {
        "name": "Priority 1",
        "color": "0xFF805f9b",
        "tasks": [
          {"name": "Task 1", "isDone": false},
          {"name": "Task 2", "isDone": true},
          // Add more tasks as needed
        ],
      },
      {
        "name": "Priority 2",
        "color": "0xFF805f9b",
        "tasks": [
          {"name": "Task 3", "isDone": false},
          {"name": "Task 4", "isDone": true},
          // Add more tasks as needed
        ],
      },
      // Add more lists as needed
    ];

    return List.generate(staticData.length, (int index) {
      return buildListCard(staticData[index]);
    });
  }

  Widget buildListCard(Map<String, dynamic> listData) {
    // Extract data from the map
    String listName = listData["name"];
    String listColor = listData["color"];
    List<Map<String, dynamic>> tasks =
        List<Map<String, dynamic>>.from(listData["tasks"]);

    return GestureDetector(
      onTap: () {
        // Handle list tap
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        color: Color(int.parse(listColor)),
        child: Container(
          width: 220.0,
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
                  child: Container(
                    child: Text(
                      listName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(left: 50.0),
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.0, left: 15.0, right: 5.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 220.0,
                        child: ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (BuildContext ctxt, int i) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  tasks[i]["isDone"]
                                      ? FontAwesomeIcons.checkCircle
                                      : FontAwesomeIcons.circle,
                                  color: tasks[i]["isDone"]
                                      ? Colors.white70
                                      : Colors.white,
                                  size: 14.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                ),
                                Flexible(
                                  child: Text(
                                    tasks[i]["name"],
                                    style: tasks[i]["isDone"]
                                        ? TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: Colors.white70,
                                            fontSize: 17.0,
                                          )
                                        : TextStyle(
                                            color: Colors.white,
                                            fontSize: 17.0,
                                          ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void _addTaskPressed() {
  //   // Handle add task button press
  //   Navigator.of(context).push(
  //     new PageRouteBuilder(
  //       pageBuilder: (_, __, ___) => new NewTaskPage(),
  //       transitionsBuilder: (context, animation, secondaryAnimation, child) =>
  //           new ScaleTransition(
  //             scale: new Tween<double>(
  //               begin: 1.5,
  //               end: 1.0,
  //             ).animate(
  //               CurvedAnimation(
  //                 parent: animation,
  //                 curve: Interval(
  //                   0.50,
  //                   1.00,
  //                   curve: Curves.linear,
  //                 ),
  //               ),
  //             ),
  //             child: ScaleTransition(
  //               scale: Tween<double>(
  //                 begin: 0.0,
  //                 end: 1.0,
  //               ).animate(
  //                 CurvedAnimation(
  //                   parent: animation,
  //                   curve: Interval(
  //                     0.00,
  //                     0.50,
  //                     curve: Curves.linear,
  //                   ),
  //                 ),
  //               ),
  //               child: child,
  //             ),
  //           ),
  //     ),
  //   );
  // }

  Padding _getToolbar(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 1.0));

    // Padding(
    //   padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Image(
    //         width: 40.0,
    //         height: 40.0,
    //         fit: BoxFit.cover,
    //         image: AssetImage('assets/list.png'),
    //       ),
    //     ],
    //   ),
    // );
  }
}
