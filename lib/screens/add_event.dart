// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/services/database.dart';

class AddEvent extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? selectedDate;
  const AddEvent(
      {Key? key,
      required this.firstDate,
      required this.lastDate,
      this.selectedDate})
      : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  late DateTime _selectedDate;
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _eligibilityController = TextEditingController();
  final _coordinatorController = TextEditingController();
  final _venueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Event")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          InputDatePickerFormField(
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            initialDate: _selectedDate,
            onDateSubmitted: (Date) {
              print(Date);
              setState(() {
                _selectedDate = Date;
              });
            },
          ),
          TextFormField(
            controller: _nameController,
            maxLines: 1,
            decoration: const InputDecoration(labelText: 'Name of the event'),

            //validator: (val) => val!.isEmpty ? 'Enter your email' : null,
            // onChanged: (val) {
            //   setState(() => email = val);
            // }
          ),
          TextFormField(
            controller: _categoryController,
            maxLines: 1,
            decoration: const InputDecoration(labelText: 'Category'),
          ),
          TextFormField(
            controller: _eligibilityController,
            maxLines: 2,
            decoration: const InputDecoration(labelText: 'Eligibility'),
          ),
          TextFormField(
            controller: _coordinatorController,
            maxLines: 2,
            decoration: const InputDecoration(labelText: 'Coordinator'),
          ),
          TextFormField(
            controller: _venueController,
            maxLines: 2,
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
    // save event to Firestore

    final Name = _nameController.text;
    final Category = _categoryController.text;
    final Eligibility = _eligibilityController.text;
    final Coordinator = _coordinatorController.text;
    final Venue = _venueController.text;

    if (Name.isEmpty) {
      //print('Name of the event cannot be empty');
      // you can use snackbar to display error to the user
      //return;
    }
    await FirebaseFirestore.instance.collection('events').add({
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
