import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Pages/RecurrentItems/name_amount_add_rec_item_page.dart';
import 'package:Expenseye/Providers/RecurrentItems/add_recurrent_item_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRecurrentItemHomePage extends StatelessWidget {
  final ItemType type;

  AddRecurrentItemHomePage(this.type);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddRecurrentItemModel(type),
      child: Consumer<AddRecurrentItemModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Add new recurrent Item'), // TODO: use localization
          ),
          body: NameAmountAddRecItemPage(),
        ),
      ),
    );
  }
}
