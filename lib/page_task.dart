import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harmony/utils/helpers/process_tasks.dart';
import 'package:harmony/utils/providers/top_level_providers.dart';
import 'package:harmony/widgets/list_card_builder.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harmony/const/colors.dart';
import 'loading_screen.dart';

import 'utils/helpers/work_rest_scheduler.dart';
import 'widgets/harmony_header.dart';
import 'widgets/row_buttons.dart';

// TODO: Make a working Machine Learning Model
// TODO: Change the UI to somethings better

class TaskPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskPageState();
}

class _TaskPageState extends ConsumerState<TaskPage>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  int index = 1;

  // Convert into state provider
  String new_task = "";
  @override
  void initState() {
    print(generateWorkRestSchedule(DateTime.now()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            body: ListView(
              children: <Widget>[
                //_getToolbar(context),
                Column(
                  children: <Widget>[
                    harmonyHeader(),
                    Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: new Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RowButtons(
                                buttonName: "Add Task",
                                icon: Icons.add,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          backgroundColor: sColor,
                                          elevation: 20,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 20,
                                                      horizontal: 20),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: TextField(
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10),
                                                          border:
                                                              InputBorder.none,
                                                          hintText: 'New Task',
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .grey[600],
                                                              fontSize: 15),
                                                        ),
                                                        onChanged: (val) {
                                                          new_task = val;
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 20),
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            elevation: 0,
                                                            backgroundColor:
                                                                pColor,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            )),
                                                    onPressed: () async {
                                                      (ref
                                                              .read(
                                                                  taskListProvider
                                                                      .notifier)
                                                              .state)
                                                          .add(new_task);

                                                      updateTaskString();

                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .pop('dialog');
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                      setState(() {
                                                        isLoading = true;
                                                      });

                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                    },
                                                    child: Text('Add',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                              ),
                              RowButtons(
                                buttonName: "Process",
                                icon: Icons.refresh,
                                onPressed: () async {
                                  await getSchedule(ref, tasks: new_task);

                                  ref.read(taskListProvider.notifier).state =
                                      [];
                                  updateTaskString();
                                  ;
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("   Tasks:",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5), // Add spacing
                          getTasks(),
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
                    child: ListView.builder(
                        itemCount: ref.watch(priorityListProvider).length,
                        itemBuilder: (BuildContext context, int index) {
                          print("index" + index.toString());
                          return buildListCard(
                            index + 1,
                          );
                        },
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(left: 40.0, right: 40.0),
                        scrollDirection: Axis.horizontal),
                  ),
                ),
              ],
            ),
          );
  }

  void updateTaskString() {
    new_task = ref.read(taskListProvider.notifier).state.join(" ");
    print("Update Task String: " + new_task);
  }

  Widget getTasks() {
    return SingleChildScrollView(
      child: Container(
        height: 100, // Set a height for the tasks area
        child: ListView.builder(
          itemCount: ref.watch(taskListProvider).length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(ref.watch(taskListProvider)[index]),
                    InkWell(
                        onTap: () {
                          setState(() {
                            ref
                                .read(taskListProvider.notifier)
                                .state
                                .removeAt(index);
                            updateTaskString();
                          });
                        },
                        child: Icon(Icons.delete))
                  ]),
            );
          },
        ),
      ),
    );
  }
}
