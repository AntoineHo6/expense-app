import 'package:Expenseye/Components/Global/my_table_calendar.dart';
import 'package:Expenseye/Components/RecurringItems/add_rec_item_steps_header.dart';
import 'package:Expenseye/Components/RecurringItems/bottom_nav_button.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Enums/periodicity.dart';
import 'package:Expenseye/Providers/RecurringItems/add_recurring_item_model.dart';
import 'package:Expenseye/Resources/Themes/MyColors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

enum Error { above28th, above62DaysInPast }

class DateAddRecItemPage extends StatefulWidget {
  final Periodicity periodicity;

  DateAddRecItemPage(this.periodicity);

  @override
  _DateAddRecItemPageState createState() => _DateAddRecItemPageState();
}

class _DateAddRecItemPageState extends State<DateAddRecItemPage>
    with TickerProviderStateMixin {
  CalendarController _calendarController;
  bool monthlyPeriodicityError = false;
  AnimationController _animationController;
  Animation _animation;
  Error error;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AddRecurringItemModel>(context, listen: false);
    _animationController.forward();

    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: BottomNavButton(
            color: _model.type == ItemType.expense
                ? MyColors.expenseColor
                : MyColors.incomeColor,
            text: AppLocalizations.of(context).translate('nextCaps'),
            onPressed: () {
              selectedDate = _calendarController.focusedDay;
              if ((_model.periodicity == Periodicity.monthly ||
                      _model.periodicity == Periodicity.yearly) &&
                  _calendarController.focusedDay.day > 28) {
                error = Error.above28th;
                setState(() {
                  monthlyPeriodicityError = true;
                });
              } else if (DateTime.now()
                      .difference(_calendarController.focusedDay)
                      .inDays >
                  62) {
                error = Error.above62DaysInPast;
                setState(() {
                  monthlyPeriodicityError = true;
                });
              } else {
                _model.goNextFromDatePage(selectedDate);
              }
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AddRecItemStepsHeader(
                title:
                    '3. ${AppLocalizations.of(context).translate('selectAStartingDate')}',
                percent: 0.6,
              ),
              monthlyPeriodicityError
                  ? _monthlyPeriodicityErrorPage(context)
                  : _noMonthlyPeriodicityErrorPage()
            ],
          ),
        ),
      ),
    );
  }

  MyTableCalendar _noMonthlyPeriodicityErrorPage() {
    return MyTableCalendar(
      initialDate: selectedDate,
      calendarController: _calendarController,
    );
  }

  Column _monthlyPeriodicityErrorPage(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          error == Error.above28th
              ? AppLocalizations.of(context)
                  .translate('errorSelectDayBetween1-28')
              : AppLocalizations.of(context)
                  .translate('errorSelectDayWithin62DaysInThePast'),
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
        MyTableCalendar(
          initialDate: selectedDate,
          calendarController: _calendarController,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  @override
  void initState() {
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
