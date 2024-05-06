import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harmony/Task.dart';

final taskListProvider = StateProvider<List<String>>((ref) {
  return [];
});

final priorityListProvider = StateProvider<List<List<Task>>>((ref) {
  return [[], [], []];
});
