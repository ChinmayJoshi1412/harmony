import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../../Task.dart';
import '../providers/top_level_providers.dart';

Future<void> getSchedule(WidgetRef ref, {required String tasks}) async {
  print("Entered" + tasks);
  tasks = tasks + " done";
  var url = Uri.parse("http://127.0.0.1:5001/get-schedule?tasks=${tasks}");
  Response response = await get(url);
  List<Task> highPriority = [];
  List<Task> mediumPriority = [];
  List<Task> lowPriority = [];
  List<dynamic> map = json.decode(response.body);
  map.sort((a, b) => b[1].compareTo(a[1]));

  for (var activity in map) {
    double calories = activity[1];
    if (calories > 1000) {
      highPriority.add(Task(name: activity[0]));
    } else if (calories >= 500) {
      mediumPriority.add(Task(name: activity[0]));
    } else {
      lowPriority.add(Task(name: activity[0]));
    }
  }
  print("Response" + response.body);
  (ref.read(priorityListProvider.notifier).state)[0]
      .addAll(highPriority); // Add 'high' items to index 0
  (ref.read(priorityListProvider.notifier).state)[1]
      .addAll(mediumPriority); // Add 'medium' to index 0
  (ref.read(priorityListProvider.notifier).state)[2].addAll(lowPriority);
  print((ref.read(priorityListProvider.notifier).state)[0][0].name);
}
