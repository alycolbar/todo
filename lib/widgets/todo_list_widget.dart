import 'package:flutter/material.dart';

class TodoListWidget extends StatefulWidget {
  @override
  _TodoListWidgetState createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {

  Widget _buildTask (int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: ListTile(
      title: Text('Task Title'), 
      subtitle: Text('Mar 1, 2021 · High'),
      trailing: Checkbox(
        onChanged: (value) {
        print(value);
      },
      activeColor: Theme.of(context).primaryColor,
      value: true,
      ), //Checkbox
    ), // ListTile
  ); // Padding
  
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () => print("Navigate to add task screen"),
      ), //floatingActionButton
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 80.0),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'My Tasks',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ), //TextStyle
                  ), // Text
                  SizedBox(height: 10.0),
                  Text(
                    '1 of 10',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ), //TextStyle
                  ), //Text
                ], // <Widget>[]
              ), // Column
            ); // Padding
          }
          return _buildTask(index);
        },
      ), // ListView.builder
    ); // Scaffold
  }
}
