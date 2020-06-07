import 'package:Expenseye/Resources/Themes/MyColors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class AddExpenseFab extends StatelessWidget {
  final Function onExpensePressed;
  final Function onIncomePressed;

  AddExpenseFab({this.onExpensePressed, this.onIncomePressed});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      child: const Icon(Icons.add),
      children: [
        SpeedDialChild(
          backgroundColor: Colors.red,
          child: const Icon(Icons.attach_money),
          label: AppLocalizations.of(context).translate('expense'),
          labelBackgroundColor: MyColors.black24dp,
          labelStyle: TextStyle(fontSize: 14.0, color: Colors.white),
          onTap: onExpensePressed,
        ),
        SpeedDialChild(
          backgroundColor: Colors.green,
          child: const Icon(Icons.account_balance_wallet),
          label: AppLocalizations.of(context).translate('income'),
          labelBackgroundColor: MyColors.black24dp,
          labelStyle: TextStyle(fontSize: 14.0, color: Colors.white),
          onTap: onIncomePressed,
        ),
      ],
    );
  }
}
