import 'package:expense_app/Components/expense_list_tile.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:expense_app/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyModel extends ChangeNotifier {
  List<List<Expense>> splitExpensesByDay(List<Expense> expenses) {
    List<List<Expense>> expensesSplitByDay = new List();

    DateTime currentDate = expenses[0].date;
    int currentIndex = 0;
    expensesSplitByDay.add(List());

    for (Expense expense in expenses) {
      if (expense.date == currentDate) {
        expensesSplitByDay[currentIndex].add(expense);
      } else {
        currentIndex++;
        currentDate = expense.date;
        expensesSplitByDay.add(List());
        expensesSplitByDay[currentIndex].add(expense);
      }
    }

    return expensesSplitByDay;
  }

  List<Container> expensesSplitByDayToContainers(
      BuildContext context, List<List<Expense>> expensesSplitByDay) {
    final _expenseModel = Provider.of<ExpenseModel>(context, listen: false);

    return expensesSplitByDay
        .map(
          (expenseList) => Container(
            decoration: BoxDecoration(
              color: MyColors.black06dp,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(12),
            margin:
                const EdgeInsets.only(top: 4, left: 15, right: 15, bottom: 20),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: <Widget>[
                      Text(
                        DateTimeUtil.formattedDate(expenseList[0].date),
                        style: Theme.of(context).textTheme.title,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(_expenseModel.totalString(expenseList)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: _expensesToCardList(context, expenseList),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  List<Card> _expensesToCardList(BuildContext context, List<Expense> expenses) {
    final _expenseModel = Provider.of<ExpenseModel>(context, listen: false);

    return expenses
        .map(
          (expense) => Card(
            margin: const EdgeInsets.only(top: 4, bottom: 4),
            color: MyColors.black02dp,
            child: ExpenseListTile(
              onTap: () => _expenseModel.openEditExpense(context, expense),
              expense: expense,
            ),
          ),
        )
        .toList();
  }
}
