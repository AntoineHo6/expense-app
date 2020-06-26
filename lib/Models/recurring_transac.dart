import 'package:Expenseye/Enums/periodicity.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Utils/date_time_util.dart';

class RecurringTransac {
  int id;
  String name;
  double amount;
  DateTime dueDate; // corresponds to the next dueDate the transaction is due for
  Periodicity periodicity; // daily, weekly, bi-weekly, monthly, yearly
  String category;

  RecurringTransac(
    this.name,
    this.amount,
    this.dueDate,
    this.category,
    this.periodicity,
  );

  RecurringTransac.withId(
    this.id,
    this.name,
    this.amount,
    this.dueDate,
    this.category,
    this.periodicity,
  );

  void updateDueDate() {
    switch (periodicity) {
      case Periodicity.daily:
        dueDate = DateTimeUtil.timeToZeroInDate(dueDate.add(Duration(days: 1)));
        break;
      case Periodicity.weekly:
        dueDate = DateTimeUtil.timeToZeroInDate(dueDate.add(Duration(days: 7)));
        break;
      case Periodicity.biweekly:
        dueDate = DateTimeUtil.timeToZeroInDate(dueDate.add(Duration(days: 14)));
        break;
      case Periodicity.monthly:
        int newMonth;
        int newYear = dueDate.year;
        if (dueDate.month == 12) {
          newMonth = 1;
          newYear = dueDate.year + 1;
        } else {
          newMonth = dueDate.month + 1;
        }
        dueDate = DateTimeUtil.timeToZeroInDate(DateTime(newYear, newMonth, dueDate.day));
        break;
      case Periodicity.yearly:
        dueDate = DateTimeUtil.timeToZeroInDate(DateTime(dueDate.year + 1, dueDate.month, dueDate.day));
        break;
    }
  }

  RecurringTransac.fromMap(Map<String, dynamic> map) {
    id = map[Strings.recurringTransacColumnId];
    name = map[Strings.recurringTransacColumnName];
    amount = map[Strings.recurringTransacColumnAmount];
    dueDate = DateTime.parse(map[Strings.recurringTransacColumnDueDate]);
    periodicity =
        Periodicity.values[map[Strings.recurringTransacColumnPeriodicity]];
    category = map[Strings.recurringTransacColumnCategory];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.recurringTransacColumnName: name,
      Strings.recurringTransacColumnAmount: amount,
      Strings.recurringTransacColumnDueDate: dueDate.toIso8601String(),
      Strings.recurringTransacColumnPeriodicity: periodicity.index,
      Strings.recurringTransacColumnCategory: category
    };
    if (id != null) {
      map[Strings.recurringTransacColumnId] = id;
    }
    return map;
  }
}
