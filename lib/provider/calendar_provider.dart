import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../common/utils.dart';
import '../model/event.dart';

final calendarProvider = ChangeNotifierProvider((ref) => CalendarProvider());

class CalendarProvider extends ChangeNotifier {
  late List<Event> selectedEvents = [];
  late DateTime selectedDay = DateTime.now();

  LinkedHashMap<DateTime, List<Event>> events =
      LinkedHashMap<DateTime, List<Event>>(
          equals: isSameDay, hashCode: getHashCode)
        ..addAll({
          kToday: [const Event('football', 'Playing football')],
          DateTime.now().add(const Duration(days: 5)): [
            const Event('Exercise', 'Going to the gym')
          ],
        });

  void loadEvents() {
    selectedEvents = events[selectedDay] ?? [];
  }

  void addEvents(Map<DateTime, List<Event>> event) {
    events.addAll(event);
    notifyListeners();
  }
}
