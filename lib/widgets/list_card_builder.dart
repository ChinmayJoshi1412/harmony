import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harmony/const/colors.dart';
import 'package:harmony/utils/providers/top_level_providers.dart';

import '../Task.dart';

final rebuildTriggerProvider = StateProvider((ref) => false);

Widget buildListCard(int si) {
  String listName = "";
  if (si == 1) {
    listName = "High Priority";
  } else if (si == 2) {
    listName = "Medium Priority";
  } else if (si == 3) {
    listName = "Low Priority";
  }
  String listColor = "0xFF805f9b";

  return Consumer(
    builder: (context, ref, child) {
      final tasksW = ref.watch(priorityListProvider)[si - 1];
      final tasksR = (ref.read(priorityListProvider.notifier).state)[si - 1];
      final shouldRebuild = ref.watch(rebuildTriggerProvider);

      return GestureDetector(
        onTap: () {
          // Handle list tap
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          color: pColor,
          child: Container(
            width: 250.0,
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
                            itemCount: tasksW.length,
                            itemBuilder: (BuildContext ctxt, int ci) {
                              return GestureDetector(
                                onTap: () {
                                  ref
                                      .read(priorityListProvider.notifier)
                                      .update((state) {
                                    // Update logic
                                    state[si - 1][ci].isdone =
                                        !state[si - 1][ci].isdone;
                                    return state;
                                  });
                                  ref
                                      .read(rebuildTriggerProvider.notifier)
                                      .update((state) => true);
                                  ref
                                      .read(rebuildTriggerProvider.notifier)
                                      .update((state) => false);
                                },
                                child: ListTile(
                                    leading: Icon(
                                      tasksW[ci].isdone
                                          ? FontAwesomeIcons.circleCheck
                                          : FontAwesomeIcons.circle,
                                      color: tasksW[ci].isdone
                                          ? Colors.white70
                                          : Colors.white,
                                      size: 20.0,
                                    ),
                                    title: tasksW[ci].isdone
                                        ? Text(
                                            tasksW[ci].name,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          )
                                        : Text(
                                            tasksW[ci].name,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                    trailing: GestureDetector(
                                        onTap: () {
                                          tasksR.removeAt(ci);
                                          ref
                                              .read(rebuildTriggerProvider
                                                  .notifier)
                                              .update((state) => true);
                                          ref
                                              .read(rebuildTriggerProvider
                                                  .notifier)
                                              .update((state) => false);
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          size: 20,
                                          color: Colors.white70,
                                        ))),
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
    },
  );
}
