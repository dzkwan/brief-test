import 'package:flutter/material.dart';

class TabbarViewModel with ChangeNotifier {
  late TabController controllerTabbar;
  int index = 0;
  final List<Tab> myTabs = [
    Tab(
      child: Center(
        child: Text("REST API"),
      ),
    ),
    Tab(
      child: Center(
        child: Text("DETEKSI"),
      ),
    ),
  ];

  void indexTabbar() {
    index = controllerTabbar.index;
    notifyListeners();
  }
}
