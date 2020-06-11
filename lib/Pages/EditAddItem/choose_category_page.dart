import 'package:Expenseye/Components/Categories/category_btn.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class ChooseCategoryPage extends StatelessWidget {
  final ItemType type;

  ChooseCategoryPage({@required this.type});

  @override
  Widget build(BuildContext context) {
    List<int> categorieKeys = new List();

    for (var key in DbModel.catMap.keys) {
      if (DbModel.catMap[key].type == type) {
        categorieKeys.add(key);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('icons')),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: List.generate(
          categorieKeys.length,
          (index) {
            int key = categorieKeys[index];
            return CategoryBtn(
              category: DbModel.catMap[key],
              onPressed: () => Navigator.pop(context, key),
            );
          },
        ),
      ),
    );
  }
}
