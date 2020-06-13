import 'package:flutter/material.dart';
import 'calendar_firestore.dart';
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
                title: Text('제목'),
              ),
            Card(
              child: ListTile(
                title: Text(event.title, style: TextStyle(fontSize: 25)),
              ),
            ),
            SizedBox(height: 10.0),
            ListTile(
                title: Text('내용'),
              ),   
            Container(
              height: 150,
              child: Card(
                child: ListTile(
                  title: Text(event.description, style: TextStyle(fontSize: 25)),
                ),
              ),
            ),
            SizedBox(height: 20.0), 
            FlatButton(
              onPressed: () async {
                try {
                  await eventDBS.removeItem(event.id);
                } catch(e) {
                  print(e);
                }
                Navigator.pop(context);
              },
              child: Text('삭제', style: TextStyle(fontSize: 24)),
              color: Colors.yellow,
              textColor: Colors.black,
              disabledColor: Colors.white,
              disabledTextColor: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}



/*
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
            Container(
              child: Text(event.title, style: Theme.of(context).textTheme.display1,)
            ),
            SizedBox(height: 20.0),
            Container(
              child: Text(event.description),
            ),
            SizedBox(height: 20.0),   
            MaterialButton(
              onPressed: () {
                try {
                  eventDBS.removeItem(event.id);
                } catch(e) {
                  print(e);
                }
                Navigator.pop(context);
              },
              child: Text('삭제'),
            )
          ],
        ),
      ),
    );
  }
}


          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(event.title, style: Theme.of(context).textTheme.display1,),
            SizedBox(height: 20.0),
            Text(event.description)
            SizedBox(height: 20.0),

*/