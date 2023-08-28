// ignore_for_file: non_constant_identifier_names

import 'package:flutter_application_1/services/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditEvent extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final Event event;
  const EditEvent(
      {Key? key,
      required this.firstDate,
      required this.lastDate,
      required this.event})
      : super(key: key);

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  late DateTime _selectedDate;
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _eligibilityController;
  late TextEditingController _coordinatorController;
  late TextEditingController _venueController;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.event.Date;
    _nameController = TextEditingController(text: widget.event.Name);
    _categoryController = TextEditingController(text: widget.event.Category);
    _eligibilityController =
        TextEditingController(text: widget.event.Eligibility);
    _coordinatorController =
        TextEditingController(text: widget.event.Coordinator);
    _venueController = TextEditingController(text: widget.event.Venue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Event")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          InputDatePickerFormField(
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            initialDate: _selectedDate,
            onDateSubmitted: (Date) {
              // ignore: avoid_print
              print(Date);
              setState(() {
                _selectedDate = Date;
              });
            },
          ),
          TextField(
            controller: _nameController,
            maxLines: 1,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _categoryController,
            maxLines: 1,
            decoration: const InputDecoration(labelText: 'Category'),
          ),
          TextField(
            controller: _eligibilityController,
            maxLines: 1,
            decoration: const InputDecoration(labelText: 'Eligibility'),
          ),
          TextField(
            controller: _coordinatorController,
            maxLines: 1,
            decoration: const InputDecoration(labelText: 'Coordinator'),
          ),
          TextField(
            controller: _venueController,
            maxLines: 1,
            decoration: const InputDecoration(labelText: 'Venue'),
          ),
          ElevatedButton(
            onPressed: () {
              _addEvent();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _addEvent() async {
    final Name = _nameController.text;
    final Category = _categoryController.text;
    final Eligibility = _eligibilityController.text;
    final Coordinator = _coordinatorController.text;
    final Venue = _venueController.text;
    if (Name.isEmpty) {
      // ignore: avoid_print
      print('title cannot be empty');
      return;
    }
    await FirebaseFirestore.instance
        .collection('events')
        .doc(widget.event.id)
        .update({
      "Name": Name,
      "Category": Category,
      "Eligibility": Eligibility,
      "Coordinator": Coordinator,
      "Venue": Venue,
      "Date": Timestamp.fromDate(_selectedDate),
    });
    if (mounted) {
      Navigator.pop<bool>(context, true);
    }
  }
}
