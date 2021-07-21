import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory/Controller/UserController.dart';
import 'package:inventory/widget/button_widget.dart';

class DatePickerWidget extends StatefulWidget {
  final DateTime date;

  DatePickerWidget({Key key, @required this.date}) : super(key: key);
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  getDateTime(date) {
    this.date = date;
  }

  DateTime date;
  UserController uc = new UserController();
  String getText() {
    if (date == null) {
      return 'Select Date';
    } else {
      return DateFormat('MM/dd/yyyy').format(date);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) => ButtonHeaderWidget(
        title: 'Date',
        text: getText(),
        onClicked: () => pickDate(context),
      );

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;

    setState(() => date = newDate);
  }
}
