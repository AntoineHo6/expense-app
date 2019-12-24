import 'package:expense_app_beginner/Resources/Strings.dart';
import 'package:expense_app_beginner/Blocs/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpense extends StatefulWidget {
  @override
  _AddExpense createState() => _AddExpense();
}

class _AddExpense extends State<AddExpense> {
  // Name TextField
  final _nameController = TextEditingController();
  bool _isNameInvalid = false;

  // Price TextField
  final _priceController = TextEditingController();
  bool _isPriceInvalid = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(Strings.newExpense),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: Strings.name,
            errorText: _isNameInvalid
                ? Strings.name + ' ' + Strings.cantBeEmpty
                : null,
          ),
        ),
        TextField(
          controller: _priceController,
          maxLength: 10,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: Strings.price,
            errorText: _isPriceInvalid
                ? Strings.price + ' ' + Strings.cantBeEmpty
                : null,
          ),
          keyboardType: TextInputType.number,
        ),
      ]),
      actions: <Widget>[
        new FlatButton(
          child: new Text(Strings.cancelCaps),
          onPressed: () {
            quit();
          },
        ),
        new FlatButton(
          child: new Text(Strings.submitCaps),
          onPressed: () {
            _addNewExpense();
          },
        ),
      ],
    );
  }

  void _addNewExpense() {
    setState(() {
      _nameController.text.isEmpty
          ? _isNameInvalid = true
          : _isNameInvalid = false;
      _priceController.text.isEmpty
          ? _isPriceInvalid = true
          : _isPriceInvalid = false;
    });

    // if both fields have valid values
    if (!_isNameInvalid && !_isPriceInvalid) {
      Provider.of<ExpenseBloc>(context).addExpense(
          _nameController.text, double.parse(_priceController.text));

      quit();
    }
  }

  void quit() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}

/**
 * TODO: Make textFields custom widgets for reusability and reduce code lines
 * TODO: add date and time for expense
 * TODO: Check if price is also invalid
 * TODO: Change price error text to invalid instead
 */