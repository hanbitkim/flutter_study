import 'package:artitecture/src/domain/entity/response/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TabView extends StatelessWidget {
  final Category _category;

  const TabView(this._category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(child: Text(_category.name, style: const TextStyle(color: Colors.black)));
  }
}
