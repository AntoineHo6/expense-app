import 'package:expense_app/Components/EditAdd/add_expense_dialog.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Pages/EditAdd/edit_expense_page.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Utils/database_helper.dart';
import 'package:expense_app/google_firebase_helper.dart';
import 'package:flutter/material.dart';

class ExpenseModel extends ChangeNotifier {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  final GoogleFirebaseHelper googleFirebaseHelper = GoogleFirebaseHelper();

  void loginWithGoogle() async {
    List<Expense> localExpenses = await dbHelper.queryAllExpenses();

    await googleFirebaseHelper.loginWithGoogle().then((isLoggedIn) {
      if (isLoggedIn) {
        for (Expense expense in localExpenses) {
          dbHelper.insert(expense);
        }
        googleFirebaseHelper.uploadDbFile();

        notifyListeners();
      }
    });
  }

  void logOutFromGoogle() async {
    await dbHelper.deleteAll();
    await googleFirebaseHelper.logOut();
    notifyListeners();
  }

  void addExpense(Expense newExpense) async {
    await dbHelper.insert(newExpense);
    await googleFirebaseHelper.uploadDbFile();
    notifyListeners();
  }

  void editExpense(Expense newExpense) async {
    await dbHelper.update(newExpense);
    await googleFirebaseHelper.uploadDbFile();
    notifyListeners();
  }

  void deleteExpense(int id) async {
    await dbHelper.delete(id);
    await googleFirebaseHelper.uploadDbFile();
    notifyListeners();
  }

  void showAddExpense(BuildContext context, DateTime initialDate) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => AddExpenseDialog(initialDate),
    );

    if (confirmed != null && confirmed) {
      final snackBar = SnackBar(
        content: Text(Strings.succAdded),
        backgroundColor: Colors.grey.withOpacity(0.5),
      );

      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void openEditExpense(BuildContext context, Expense expense) async {
    int action = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditExpensePage(expense)),
    );

    if (action != null) {
      final snackBar = SnackBar(
        content:
            action == 1 ? Text(Strings.succEdited) : Text(Strings.succDeleted),
        backgroundColor: Colors.grey.withOpacity(0.5),
      );

      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  double calcTotal(List<Expense> expenses) {
    double total = 0;
    for (Expense expense in expenses) {
      total += expense.price;
    }
    return total;
  }

  // * may move out of this provider
  String totalString(List<Expense> expenses) {
    return '${calcTotal(expenses).toString()} \$';
  }
}

// TODO: refactor this bs. Rename the model and split the functions to other models
