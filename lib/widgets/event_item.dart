import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/event.dart';

class EventItem extends StatelessWidget {
  final Event event;
  //final Function() onDelete;
  final Function()? onTap;
  const EventItem({
    Key? key,
    required this.event,
    //required this.onDelete,
    this.onTap, //required Text title, required Text subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        event.Name,
      ),
      subtitle: Text(
        event.Date.toString(),
      ),
      // onTap: onTap,
      // trailing: IconButton(
      //   icon: const Icon(Icons.delete),
      //   onPressed: onDelete,
      // ),
    );
  }
}
