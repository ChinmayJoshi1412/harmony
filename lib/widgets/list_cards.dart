// import 'package:flutter/material.dart';
// import 'package:harmony/Task.dart';

// Widget buildListCard(List<Task> plist, int i) {
//     // Extract data from the map
//     String listName = "";
//     if (i == 1) {
//       listName = "High Priority";
//     } else if (i == 2) {
//       listName = "Medium Priority";
//     } else if (i == 3) {
//       listName = "Low Priority";
//     }
//     String listColor = "0xFF805f9b";
//     List<Task> tasks = plist;

//     return GestureDetector(
//       onTap: () {
//         // Handle list tap
//       },
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(8.0)),
//         ),
//         color: Color(int.parse(listColor)),
//         child: Container(
//           width: 250.0,
//           child: Container(
//             child: Column(
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
//                   child: Container(
//                     child: Text(
//                       listName,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 19.0,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 5.0),
//                   child: Row(
//                     children: <Widget>[
//                       Expanded(
//                         flex: 2,
//                         child: Container(
//                           margin: EdgeInsets.only(left: 50.0),
//                           color: Colors.white,
//                           height: 1.5,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 30.0, left: 15.0, right: 5.0),
//                   child: Column(
//                     children: <Widget>[
//                       SizedBox(
//                         height: 220.0,
//                         child: ListView.builder(
//                           itemCount: tasks.length,
//                           itemBuilder: (BuildContext ctxt, int i) {
//                             return GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   tasks[i].isdone = !tasks[i].isdone;
//                                 });
//                               },
//                               child: ListTile(
//                                   leading: Icon(
//                                     tasks[i].isdone
//                                         ? FontAwesomeIcons.checkCircle
//                                         : FontAwesomeIcons.circle,
//                                     color: tasks[i].isdone
//                                         ? Colors.white70
//                                         : Colors.white,
//                                     size: 20.0,
//                                   ),
//                                   title: tasks[i].isdone
//                                       ? Text(
//                                           tasks[i].name,
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 20.0,
//                                               decoration:
//                                                   TextDecoration.lineThrough),
//                                         )
//                                       : Text(
//                                           tasks[i].name,
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 20.0,
//                                           ),
//                                         ),
//                                   trailing: GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           tasks.removeAt(i);
//                                         });
//                                       },
//                                       child: Icon(
//                                         Icons.delete,
//                                         size: 20,
//                                         color: Colors.white70,
//                                       ))),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }