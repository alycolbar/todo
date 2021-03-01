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
      _dateController.text = _date.toString();
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
              ], // <Widget> []
            ), // Column
          ), // Form
        ], // <Widget>[]
      ), // Column
    ); // Scaffold
  }
}