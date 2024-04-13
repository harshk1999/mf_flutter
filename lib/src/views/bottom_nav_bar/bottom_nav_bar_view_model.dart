import 'package:flutter/foundation.dart';

class BottomNavBarViewModel {
  final ValueNotifier<int> _indexNotifer = ValueNotifier<int>(0);
  ValueListenable<int> get indexNotifier => _indexNotifer;

  void navigate(int index) {
    if (index < 0 || index > 2) return;
    _indexNotifer.value = index;
  }

  Future<void> getSearchResultForFunds() async {}
}
