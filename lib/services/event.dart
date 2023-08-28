// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

// class DatabaseService{

//   //reference collection

// }
class Event {
  final String Name;
  final String? Category;
  final DateTime Date;
  final String? Eligibility;
  // final Reference
  final String? Coordinator;
  final String? Venue;
  final String id;

  Event({
    required this.Name,
    required this.Category,
    required this.Date,
    required this.Eligibility,
    required this.Coordinator,
    required this.Venue,
    required this.id,
  });

  factory Event.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Event(
      Date: data['Date'].toDate(),
      Name: data['Name'],
      Category: data['Category'],
      Eligibility: data['Eligibility'],
      Coordinator: data['Coordinator'],
      Venue: data['Venue'],
      id: snapshot.id,
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      "Date": Timestamp.fromDate(Date),
      "Name": Name,
      "Category": Category,
      "Eligibility": Eligibility,
      "Coordinator": Coordinator,
      "Venue:": Venue
    };
  }
}




















// import 'package:cloud_firestore/cloud_firestore.dart';

// class DatabaseService {
//   final String uid;
//   DatabaseService({required this.uid});

//   //collection reference
//   final CollectionReference eventCollection =
//       FirebaseFirestore.instance.collection('events');

//   Future updateEventData(
//       String category,
//       String coordiantor,
//       String date,
//       String eligibility,
//       String media,
//       String name,
//       String venue) async {
//     return await eventCollection.doc(uid).set({
//       'category': category,
//       'coordiantor': coordiantor,
//       'date': date,
//       'eligibility': eligibility,
//       'media': media,
//       'name': name,
//       'venue': venue,
//     });
//   }
// }
