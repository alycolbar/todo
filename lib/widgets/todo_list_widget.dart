import 'package:flutter/material.dart';
import 'helpers/database_helper.dart';
import 'models/task_model.dart';
import 'add_task_widget.dart';

class TodoListWidget extends StatefulWidget {
  @override
  _TodoListWidgetState createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  Future<List<Task>> _taskList;
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  @override
  void initState() {
    super.initState();
    _updateTaskList();
  }

  _updateTaskList() {
    setState(() {
      _taskList = DatabaseHelper.instance.getTaskList();
    });
  }

  Widget _buildTask(Task task) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              task.title,
              style: TextStyle(
                fontSize: 18.0,
                decoration: task.status == 0 ? TextDecoration.none : TextDecoration.lineThrough,
              ), // TextStyle
            ), // Text
            subtitle: Text('${_dateFormatter.format(task.date)} • ${task.priority}'),
            trailing: Checkbox(
              onChanged: (value) {
                print(value);
              },
              activeColor: Theme.of(context).primaryColor,
              value: true,
            ), //Checkbox
          ), // ListTile
          Divider(
            color: Colors.black,
            thickness: 1,
          ), // Divider
        ], // <Widget>[]
      ), // Column
    ); // Padding
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddTaskWidget(),
            ), // MaterialPageRoute
          ),
        ), //floatingActionButton
        body: FutureBuilder(
          future: _taskList,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              ); // Center
            }

            final int completedTaskCount = snapshot.data.where((Task task) => task.status == 1).toList().length;

            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 80.0),
              itemCount: 1 + snapshot.data.length,
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
                          '$completedTaskCount of ${snapshot.data.length}',
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
                return _buildTask(snapshot.data[index - 1]);
              },
            ); // ListView.builder
          },
        )); // Scaffold
  }
}
