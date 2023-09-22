import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_first_demo/Models/event.dart';
import 'package:new_first_demo/Providers/event_add_new_provider.dart';
import 'package:new_first_demo/Providers/event_details_bloc.dart';
import 'package:new_first_demo/Providers/event_details_state.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'Providers/event_details_event.dart';

class AddEvent extends StatefulWidget {
  static const routeName = '/add_event';

  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>();

  var isAddedItem = false;
  final timeInputController = TextEditingController();
  final nameInputController = TextEditingController();
  final locationInputController = TextEditingController();
  final priceInputController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeRange result = TimeRange(
      startTime:
          TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
      endTime: TimeOfDay(
          hour: DateTime.now().hour + 1, minute: DateTime.now().minute));

  showDateTimePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      var startTime = result.startTime;
      var endTime = result.endTime;
      result = await showTimeRangePicker(
        context: context,
        strokeWidth: 4,
        ticks: 12,
        ticksOffset: 2,
        ticksLength: 8,
        handlerRadius: 8,
        ticksColor: Colors.grey,
        rotateLabels: false,
        labels: ["24 h", "3 h", "6 h", "9 h", "12 h", "15 h", "18 h", "21 h"]
            .asMap()
            .entries
            .map((e) {
          return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
        }).toList(),
        labelOffset: 30,
        padding: 55,
        labelStyle: const TextStyle(fontSize: 18, color: Colors.black),
        start: startTime,
        end: endTime,
        clockRotation: 180.0,
      );
      if (result != null) {
        setState(() {
          selectedDate = DateTime(picked.year, picked.month, picked.day, result.startTime.hour, result.startTime.minute, picked.second, picked.millisecond, picked.microsecond);
        });
        String formattedDate = DateFormat('EEE, MMM dd ').format(picked);
        timeInputController.text =
            '$formattedDate · ${result.startTime.format(context)} - ${result.endTime.format(context)}';
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    timeInputController.dispose();
    nameInputController.dispose();
    locationInputController.dispose();
    priceInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle submitButtonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 16),
      backgroundColor: const Color(0xFF0DCDAA),
      shape: const StadiumBorder(),
      minimumSize: const Size.fromHeight(50),
    );

    void onCreateNewEvent(BuildContext context) {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      if (_formKey.currentState!.validate()) {
        Event newEvent = Event(0, nameInputController.text, selectedDate.toString(), locationInputController.text,
            int.parse(priceInputController.text), 'https://picsum.photos/200', true);
        context.read<EventDetailBloc>().add(LoadAddNewEvent(newEvent));
      }
    }

    void onBack(BuildContext ctx) {
      setState(() {
        isAddedItem = true;
      });
      Navigator.of(ctx).pop();
      Navigator.of(context).pop();
    }

    return EventAddNewProvider(
        child: BlocBuilder<EventDetailBloc, EventDetailsState>(
          builder: (context, state) {
            if (state.isAdded && !isAddedItem) {
              Future.delayed(const Duration(seconds: 0), () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: const Text('Add new event successfully'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => onBack(ctx),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    });
              });
            }
            return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'New Event',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    icon: const Icon(Icons.close),
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                body: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name cannot be blank';
                            }
                            if (value.length > 20) {
                              return 'Name cannot be longer than 25 characters';
                            }
                            return null;
                          },
                          controller: nameInputController,
                          decoration: const InputDecoration(
                            fillColor: Color(0xFFF6F6F6),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xFFE8E8E8)),
                            ),
                            hintText: 'Name',
                            hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Time cannot be blank';
                            }
                            return null;
                          },
                          readOnly: true,
                          controller: timeInputController,
                          onTap: () => showDateTimePicker(context),
                          decoration: const InputDecoration(
                            fillColor: Color(0xFFF6F6F6),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xFFE8E8E8)),
                            ),
                            hintText: 'Time',
                            hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: locationInputController,
                          decoration: const InputDecoration(
                            fillColor: Color(0xFFF6F6F6),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xFFE8E8E8)),
                            ),
                            hintText: 'Location',
                            hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: priceInputController,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Please enter valid price';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            fillColor: Color(0xFFF6F6F6),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xFFE8E8E8)),
                            ),
                            hintText: 'Price',
                            hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: state.isLoadingAdded ? null : () => onCreateNewEvent(context),
                          style: submitButtonStyle,
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
    );
  }
}
