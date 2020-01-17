import 'package:charts_flutter/flutter.dart' as charts;
import 'package:Expenseye/Utils/chart_util.dart';
import 'package:Expenseye/Utils/item_category.dart';
import 'package:flutter/material.dart';

class SimplePieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimplePieChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory SimplePieChart.withSampleData() {
    return new SimplePieChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList, animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<ExpenseGroup, ItemCategory>>
      _createSampleData() {
    List<ExpenseGroup> aggregatedExpenses = [
      new ExpenseGroup(ItemCategory.food, 5),
      new ExpenseGroup(ItemCategory.transportation, 0),
      new ExpenseGroup(ItemCategory.shopping, 8),
      new ExpenseGroup(ItemCategory.entertainment, 0),
      new ExpenseGroup(ItemCategory.activity, 0),
      new ExpenseGroup(ItemCategory.medical, 1),
      new ExpenseGroup(ItemCategory.home, 3),
      new ExpenseGroup(ItemCategory.travel, 7),
      new ExpenseGroup(ItemCategory.people, 1),
      new ExpenseGroup(ItemCategory.others, 2),
    ];
    return [
      new charts.Series(
          id: 'Expenses',
          domainFn: (ExpenseGroup group, _) => group.category,
          measureFn: (ExpenseGroup group, _) => group.total,
          colorFn: (ExpenseGroup group, _) => charts.ColorUtil.fromDartColor(
              ItemCatProperties.properties[group.category]['color']),
          data: aggregatedExpenses)
    ];
  }
}
