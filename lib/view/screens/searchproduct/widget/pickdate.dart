import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../provider/search_product_provider.dart'; //this is an external package for formatting date and time

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (context, order, child) {
      return Row(
        children: <Widget>[
          IconButton(
              onPressed: () {
                setState(() {
                  order.pickDateDialog(context);
                });
              },
              icon: Icon(Icons.date_range)),
          MaterialButton(
              child: Text(
                  'اختر تاريخ انتهاء العرض : ${order.selectedDate == null ? '' : DateFormat.yMMMd().format(order.selectedDate!)}'),
              onPressed: () {
                setState(() {
                  order.pickDateDialog(context);
                });
              }),
        ],
      );
    });
  }
}
