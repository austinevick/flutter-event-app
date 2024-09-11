import 'package:events_app/add_event_dialog.dart';
import 'package:events_app/provider/calendar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'common/utils.dart';
import 'model/event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final provider = ref.watch(calendarProvider);
      provider.loadEvents();
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TableCalendar<Event>(
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) =>
                    isSameDay(provider.selectedDay, day),
                calendarFormat: _calendarFormat,
                eventLoader: (day) => provider.events[day] ?? [],
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    for (var e in events) {
                      if (provider.events[day]!.contains(e)) {
                        return const Icon(
                          Icons.circle,
                          size: 8,
                          color: Colors.green,
                        );
                      }
                    }
                    return null;
                  },
                  dowBuilder: (context, day) {
                    return Center(
                      child: Text(
                        DateFormat.E().format(day),
                        style: TextStyle(
                            color: day.weekday == DateTime.sunday
                                ? Colors.red
                                : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(provider.selectedDay, selectedDay)) {
                    setState(() {
                      provider.selectedDay = selectedDay;
                    });
                  }
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              const SizedBox(height: 12),
              Expanded(
                  child: ListView.builder(
                itemCount: provider.selectedEvents.length,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                    shape: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12)),
                    leading: const CircleAvatar(),
                    title: Text(provider.selectedEvents[i].title),
                    subtitle: Text(provider.selectedEvents[i].description),
                  ),
                ),
              ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
              context: context, builder: (ctx) => const AddEventDialog()),
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
