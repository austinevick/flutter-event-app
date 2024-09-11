import 'package:events_app/model/event.dart';
import 'package:events_app/provider/calendar_provider.dart';
import 'package:events_app/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddEventDialog extends StatefulWidget {
  const AddEventDialog({super.key});

  @override
  State<AddEventDialog> createState() => _AddEventDialogState();
}

class _AddEventDialogState extends State<AddEventDialog> {
  final title = TextEditingController();
  final description = TextEditingController();
  final dateTime = TextEditingController();
  DateTime selectedDate = DateTime.now();
  List<Event> events = [];

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Consumer(builder: (context, ref, _) {
        final provider = ref.watch(calendarProvider);
        return SingleChildScrollView(
          child: SafeArea(
              minimum: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.clear,
                        size: 32,
                      )),
                  const SizedBox(height: 20),
                  CustomTextfield(
                    controller: title,
                    hintText: 'Title',
                  ),
                  const SizedBox(height: 16),
                  CustomTextfield(
                    controller: description,
                    hintText: 'description',
                    maxLines: 5,
                  ),
                  const SizedBox(height: 16),
                  CustomTextfield(
                    controller: dateTime,
                    hintText: 'Date',
                    readOnly: true,
                    suffixIcon: const Icon(
                      Icons.calendar_month_outlined,
                    ),
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030));
                      setState(() {
                        selectedDate = pickedDate!;
                        dateTime.text = DateFormat.yMMMEd().format(pickedDate);
                      });
                    },
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: OutlinedButton(
                        style: ButtonStyle(
                            fixedSize: WidgetStatePropertyAll(
                                Size(MediaQuery.sizeOf(context).width, 38))),
                        onPressed: () async {
                          setState(() =>
                              events.add(Event(title.text, description.text)));
                          final event = {selectedDate: events};
                          await Future.delayed(Durations.extralong4)
                              .whenComplete(() => provider.addEvents(event));
                        },
                        child: const Text('Add Event')),
                  )
                ],
              )),
        );
      }),
    );
  }
}
