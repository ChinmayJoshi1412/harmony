import 'package:intl/intl.dart';

Map<String, String> generateWorkRestSchedule(DateTime wakeUpTime) {
    // Set wake-up time to 6 AM with handling for past times
    DateTime startTime = wakeUpTime.isBefore(DateTime.now())
        ? wakeUpTime.add(const Duration(days: 1))
        : wakeUpTime;
    startTime = DateTime(startTime.year, startTime.month, startTime.day, 6);

    DateTime currentTime = startTime.add(const Duration(hours: 1, minutes: 30));

    final DateFormat formatter = DateFormat('HH:mm');
    Map<String, String> schedule = {};

    int numCycles = ((14.5 * 60) ~/ 110).toInt();

    for (int i = 0; i < numCycles; i++) {
      final isWorkPeriod = i % 2 == 0;
      if (isWorkPeriod && i > 0 && i % 4 == 0) {
        schedule['Extra Rest $i/4'] =
            '${formatter.format(currentTime)} - ${formatter.format(currentTime.add(const Duration(minutes: 90)))}';
        currentTime = currentTime.add(const Duration(minutes: 90));
      }
      final duration = isWorkPeriod
          ? const Duration(minutes: 90)
          : const Duration(minutes: 20);
      final periodLabel = isWorkPeriod ? 'Work' : 'Rest';

      final String formattedStart = formatter.format(currentTime);
      final String formattedEnd = formatter.format(currentTime.add(duration));

      currentTime = currentTime.add(duration);
      schedule['$periodLabel $i'] = '$formattedStart - $formattedEnd';
    }

    return schedule;
  }