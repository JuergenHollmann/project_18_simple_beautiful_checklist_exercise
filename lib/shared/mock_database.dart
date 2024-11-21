// import 'dart:developer';

// import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

// class MockDatabase implements DatabaseRepository {
//   final List<String> _items = [];

//   @override
//   Future<int> get itemCount async {
//     await Future.delayed(const Duration(milliseconds: 100));
//     // Gibt die Anzahl der Items zurück.
//     log("0012_mock_database - itemCount: $_items");
//     return _items.length;
//   }

//   @override
//   Future<List<String>> getItems() async {
//     // Gibt die Items zurück.
//     await Future.delayed(const Duration(milliseconds: 100));
//     log("0020_mock_database - getItems: $_items");
//     return _items;
//   }

//   @override
//   Future<void> addItem(String item) async {
//     // Fügt ein neues Item hinzu.
//     // make sure item doesn't exist yet and is not empty
//     if (item.isNotEmpty && !_items.contains(item)) _items.add(item);
//     log("0027_mock_database - addItem(String item): $item");
//   }

//   @override
//   Future<void> deleteItem(int index) async {
//     // Löscht ein Item an einem bestimmten Index nach Klick auf die Mülltonne.
//     _items.removeAt(index);
//     log("0033_mock_database - _items.removeAt(index): $index");
//   }

//   @override
//   Future<void> editItem(int index, String newItem) async {
//     // Aktualisiert ein Item an einem bestimmten Index nach Klick auf den Stift und dann auf "Speichern".
//     // make sure not empty and not same as other
//     if (newItem.isNotEmpty && !_items.contains(newItem)) {
//       _items[index] = newItem;
//       log("0041_mock_database - _items[index] = newItem = $newItem");
//     }
//   }
// }
