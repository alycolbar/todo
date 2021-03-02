import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskWidget extends StatefulWidget {
  @override
  _AddTaskWidgetState createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _priority;
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();

  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  final List<String> _priorities = [
    'Low',
    'Medium',
    'High'
  ];

  _handleDatePicker() async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              size: 30.0,
              color: Theme.of(context).primaryColor,
            ), // Icon
          ), // GestureDetector
          SizedBox(height: 20.0),
          Text(
            'Add Task',
            style: TextStyle(
              color: Colors.black,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ), // TextStyle
          ), // Text
          SizedBox(height: 10.0),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: TextFormField(
                    style: TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ), // OutlineInputBorder
                    ), // InputDecoration
                    validator: (input) => input.trim().isEmpty ? 'Please enter a task title' : null,
                    onSaved: (input) => _title = input,
                    initialValue: _title,
                  ), // TextFormField
                ), // Padding
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: TextFormField(
                    controller: _dateController,
                    style: TextStyle(fontSize: 18.0),
                    onTap: _handleDatePicker,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      labelStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ), // OutlineInputBorder
                    ), // InputDecoration
                  ), // TextFormField
                ), // Padding
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: DropdownButtonFormField(
                    icon: Icon(Icons.arrow_drop_down_circle),
                    iconSize: 22.0,
                    iconEnabledColor: Theme.of(context).primaryColor,
                    items: _priorities.map((String priority) {
                      return DropdownMenuItem(
                        value: priority,
                        child: Text(
                          priority,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ), // TextStyle
                        ), // Text
                      ); //DropdownMenuItem
                    }).toList(),
                    style: TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      labelText: 'Priority',
                      labelStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ), // OutlineInputBorder
                    ), // InputDecoration
                    validator: (input) => input.trim().isEmpty ? 'Please select a priority level' : null,
                    onSaved: (input) => _priority = input,
                  ), // DropdownButtonFormField
                ), // Padding
              ], // <Widget> []
            ), // Column
          ), // Form
        ], // <Widget>[]
      ), // Column
    ); // Scaffold
  }
}
