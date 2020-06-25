import 'package:flutter/material.dart';

class ToDoListPage extends StatefulWidget{
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List todos = List();
  String input = "";

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("나의 Todo"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()  {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius:
                  BorderRadius.circular(8)),
                  title : Text("Todo 작성"),
                  content: TextField(
                    onChanged: (String value){
                      input = value;
                    },
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: (){
                          setState(() {
                            todos.add(input);
                          });

                          Navigator.of(context).pop();
                        }, child: Text("추가",style: TextStyle(color: Colors.black)))
                  ],

                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Container (
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('To Do'),
              pinned: false,
              floating: false,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Dismissible(key: Key(todos[index]), child: Card(
                      elevation: 4,
                      margin: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(borderRadius:
                      BorderRadius.circular(8)),
                      child: ListTile(
                        title: Text(todos[index]),
                        trailing: IconButton(icon: Icon(
                          Icons.delete,
                          color: Colors.grey,
                        ), onPressed: (){
                          setState(() {
                            todos.removeAt(index);
                          });
                        }),
                      ),
                    ));
                  },
                childCount: todos.length,
              ),

            ),
            SliverAppBar(
              title: Text('Doing'),
              pinned: false,
              floating: false,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return Dismissible(key: Key(todos[index]), child: Card(
                    elevation: 4,
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(borderRadius:
                    BorderRadius.circular(8)),
                    child: ListTile(
                      title: Text(todos[index]),
                      trailing: IconButton(icon: Icon(
                        Icons.delete,
                        color: Colors.grey,
                      ), onPressed: (){
                        setState(() {
                          todos.removeAt(index);
                        });
                      }),
                    ),
                  ));
                },
                childCount: todos.length,
              ),

            ),
            SliverAppBar(
              title: Text('Done'),
              pinned: false,
              floating: false,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return Dismissible(key: Key(todos[index]), child: Card(
                    elevation: 4,
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(borderRadius:
                    BorderRadius.circular(8)),
                    child: ListTile(
                      title: Text(todos[index]),
                      trailing: IconButton(icon: Icon(
                        Icons.delete,
                        color: Colors.grey,
                      ), onPressed: (){
                        setState(() {
                          todos.removeAt(index);
                        });
                      }),
                    ),
                  ));
                },
                childCount: todos.length,
              ),

            ),

          ],
        ),
      )

    );
  }
}
