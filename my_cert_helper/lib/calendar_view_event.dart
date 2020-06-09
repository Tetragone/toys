import 'package:flutter/material.dart';
import 'calendar_model_event.dart';

class EventDetails extends StatelessWidget {
  final EventModel event;

  const EventDetails({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('일정 상세'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(event.title, style: Theme.of(context).textTheme.display1,),
            SizedBox(height: 20.0),
            Text(event.description)
          ],
        ),
      ),
    );
  }
}