// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'dart:collection';
import 'package:flutter_application_1/screens/add_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/services/event.dart';
import 'package:flutter_application_1/widgets/event_item.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_application_1/screens/edit_event.dart';

// ignore: unused_import
//import 'package:xml/xml_events.dart';

class Home extends StatefulWidget {
  // ignore: unused_field
  final AuthService _auth = AuthService();
  Home({super.key});

  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  late Map<DateTime, List<Event>> _events;
  late CalendarFormat _calendarFormat;

  final AuthService _auth = AuthService();

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
    _events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _loadFirestoreEvents();
  }

  _loadFirestoreEvents() async {
    final firstDay = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final lastDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    _events = {};

    final snap = await FirebaseFirestore.instance
        .collection('events')
        .where('Date', isGreaterThanOrEqualTo: firstDay)
        .where('Date', isLessThanOrEqualTo: lastDay)
        .withConverter(
            fromFirestore: Event.fromFirestore,
            toFirestore: (event, options) => event.toFirestore())
        .get();
    for (var doc in snap.docs) {
      final event = doc.data();
      final day =
          DateTime.utc(event.Date.year, event.Date.month, event.Date.day);
      if (_events[day] == null) {
        _events[day] = [];
      }
      _events[day]!.add(event);
    }
    //print(_events);
    setState(() {});
  }

  List<Event> _getEventsForTheDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Dots'),
        backgroundColor: Colors.black,
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person),
            onPressed: () async {
              await _auth.signOut();
            },
            label: const Text('logout'),
          )
        ],
      ),
      body: ListView(
        children: [
          // const Text('Calendar'),
          TableCalendar(
            eventLoader: _getEventsForTheDay,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            // calendarFormat: CalendarFormat.week,
            focusedDay: _focusedDay,
            firstDay: _firstDay,
            lastDay: _lastDay,
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
              _loadFirestoreEvents();
            },
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: const CalendarStyle(
              weekendTextStyle: TextStyle(
                color: Colors.red,
              ),
              selectedDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),
            //BELOW CODE IS FOR TITLE BAR OF THE CALENDAR ITSELF
            // calendarBuilders: CalendarBuilders(
            //   headerTitleBuilder: (context, day) {
            //     return Container(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Text(day.toString()),
            //     );
            //   },
            // ),
          ),

          ..._getEventsForTheDay(_selectedDay).map(
            (event) => EventItem(
              event: event,
              onTap: () async {
                final res = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                        builder: (_) => EditEvent(
                              firstDate: _firstDay,
                              lastDate: _lastDay,
                              event: event,
                            )));
                if (res ?? false) {
                  _loadFirestoreEvents();
                }
              },
            ),
          ), //geteventsfortheday
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (_) => AddEvent(
                firstDate: _firstDay,
                lastDate: _lastDay,
                selectedDate: _selectedDay,
              ),
            ),
          );
          if (result ?? false) {
            _loadFirestoreEvents();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
















//    @override
//    Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//         title: const Text('Campus Dots'),
//         backgroundColor: Colors.black87,
//         elevation: 0.0,
//         actions: <Widget>[
//           TextButton.icon(
//             icon: const Icon(Icons.person),
//             onPressed: () async {
//               await _auth.signOut();
//             },
//             label: const Text('logout'),
//           )
//         ],
//       ),
//     );
//   }
// }
