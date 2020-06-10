import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'calendar_model_event.dart';
import 'calendar_firestore.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {

  final EventModel note;

  const AddEvent({Key key, this.note}) : super(key: key);


  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  
  TextStyle style = TextStyle(fontSize: 20.0);
  TextEditingController _title;
  TextEditingController _description;
  DateTime _eventDate;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool processing;
  
  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.note != null ? widget.note.title : "");
    _description = TextEditingController(text: widget.note != null ? widget.note.description : "");
    _eventDate = DateTime.now();
    processing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text(widget.note != null ? "일정 수정" : "일정 추가"),
      ),
      key: _key,
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _title,
                  validator: (value) => (value.isEmpty) ? "제목을 입력해주세요." : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "제목",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _description,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) => (value.isEmpty) ? "설명을 입력해주세요" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "설명",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(height: 10.0),
              ListTile(
                title: Text("날짜 (YYYY-MM-DD)"),
                subtitle: Text("${_eventDate.year} - ${_eventDate.month} - ${_eventDate.day}"),
                onTap: () async{
                  DateTime picked = await showDatePicker(context: context, initialDate: _eventDate, firstDate: DateTime(_eventDate.year-5), lastDate: DateTime(_eventDate.year+5));
                  if(picked != null) {
                    setState(() {
                      _eventDate = picked;
                    });
                  }
                },
              ),

              SizedBox(height: 10.0),
              processing
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Theme.of(context).primaryColor,
                        child: MaterialButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                processing = true;
                              });
                              if(widget.note != null) {                           
                                await eventDBS.updateData(widget.note.id,{
                                  "title": _title.text,
                                  "description": _description.text,
                                  "event_date": widget.note.eventDate
                                });
                              }else{                              
                                await eventDBS.createItem(EventModel(
                                  title: _title.text,
                                  description: _description.text,
                                  eventDate: _eventDate
                                ));
                              }
                              Navigator.pop(context);
                              setState(() {
                                processing = false;
                              });                             
                            }
                            _description.clear();
                            _title.clear();                            
                          },
                          child: Text(
                            "저장",
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }
}