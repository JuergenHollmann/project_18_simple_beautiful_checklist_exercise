import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  List<String> _items = [];

  // @override
  // void initState() {
  //   super.initState();
  //   loadSavedData();
  // }

  @override
  Future<void> saveItem(String item) async {
    // Speichert die Items.
    await prefs.setStringList("tasks", _items);
    log("0020_shared_preferences_repository - _saveItem = $item");
  }

  @override
  Future<int> get itemCount async {
    await Future.delayed(const Duration(milliseconds: 100));
    // Gibt die Anzahl der Items zurück.
    log("0027_shared_preferences_repository - itemCount: $_items");
    return _items.length;
  }

  @override
  Future<List<String>> getItems() async {
    // Gibt die Items zurück.
    await Future.delayed(const Duration(milliseconds: 100));
    log("0035_shared_preferences_repository - getItems: $_items");

    // Kurz-Version aus der Vorlesung:
    // return await prefs.getStringList("tasks") ?? [];

    // das ist die längere Version (anstatt der Kurz-Version oben):
    _items = await prefs.getStringList("tasks") ?? [];
    return _items;
  }

  @override
  Future<void> addItem(String item) async {
    // Fügt ein neues Item hinzu.
    // make sure item doesn't exist yet and is not empty
    if (item.isNotEmpty && !_items.contains(item)) _items.add(item);
    log("0050_shared_preferences_repository - addItem(String item): $item");
    await saveItem(item);
  }

  @override
  Future<void> deleteItem(int index) async {
    /* TODO: AlertDialog einfügen */

    /* Löscht ein Item an einem bestimmten Index nach Klick auf die Mülltonne. */
    _items.removeAt(index);
    log("0060_shared_preferences_repository - $_items gelöscht am Index $index");

    /* den neuen Zustand speichern */
    prefs.setStringList("tasks", _items);
    log("0065_shared_preferences_repository - $_items LÖSCHUNG gespeichert");
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    // Aktualisiert ein Item an einem bestimmten Index nach Klick auf den Stift und dann auf "Speichern".
    // make sure not empty and not same as other
    if (newItem.isNotEmpty && !_items.contains(newItem)) {
      _items[index] = newItem;
      log("0073_shared_preferences_repository - _items[index] = newItem = $newItem");
      await saveItem(newItem);
    }
  }
}
