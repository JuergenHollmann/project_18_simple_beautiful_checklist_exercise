import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/features/task_list/widgets/empty_content.dart';
import 'package:simple_beautiful_checklist_exercise/features/task_list/widgets/item_list.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({
    super.key,
    required this.repository,
  });

  final DatabaseRepository repository;

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final List<String> _items = [];
  bool isLoading = true;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateList();
    //_saveItem();
  }

  void _updateList() async {
    _items.clear();
    _items.addAll(await widget.repository.getItems());
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meine Checkliste'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: _items.isEmpty
                      ? const EmptyContent()
                      : ItemList(
                          repository: widget.repository,
                          items: _items,
                          updateOnChange: _updateList,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Task hinzufügen',
                      suffixIcon: IconButton(
                        // damit wird der Inhalt vom TextField der Liste hinzugefügt:
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          log("0068_list_screen - hier sollte gespeichert werden");
                          if (_controller.text.isNotEmpty) {
                            widget.repository.addItem(_controller.text);

                            /*----------------------------------------------------------*/
                            log("0071_list_screen - hier wird leider NICHTS gespeichert");

                            widget.repository.saveItem(_controller.text);
                            //widget.repository.saveItem(_controller.text);
                            /*----------------------------------------------------------*/

                            // _saveItem();
                            _controller.clear();
                            _updateList();
                          }
                        },
                      ),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        // _saveItem(value);
                        widget.repository.addItem(value);
                        _controller.clear();
                        _updateList();
                      }
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
