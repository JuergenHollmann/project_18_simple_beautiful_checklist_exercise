import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
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
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _updateList();
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
                const Divider(thickness: 1, color: Colors.white30),
                Expanded(
                  child: _items.isEmpty
                      ? const EmptyContent()
                      : ItemList(
                          repository: widget.repository,
                          items: _items,
                          updateOnChange: _updateList,
                        ),
                ),
                const Divider(thickness: 1, color: Colors.white30),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    controller: _controller,
                    /*--------------------------- ermöglicht ENTER-Eingaben mit Zeilenvorschub ---*/
                    textAlignVertical: TextAlignVertical.top,
                    maxLines:
                        null, // ermöglicht ENTER-Eingaben mit Zeilenvorschub
                    /*--------------------------- *** ---*/
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(84, 0, 112, 58),
                      labelStyle: const TextStyle(
                        fontSize: 20,
                      ),
                      labelText: 'Aufgabe hinzufügen',
                      hintStyle: const TextStyle(
                        fontSize: 20,
                      ),
                      suffixIcon: IconButton(
                        // damit wird der Inhalt vom TextField der Liste hinzugefügt:
                        icon: const Icon(
                          Icons.add_circle_outline,
                          size: 40,
                        ),
                        onPressed: () {
                          player.play(AssetSource("sound/sound02click.wav"));
                          if (_controller.text.isNotEmpty) {
                            widget.repository.addItem(_controller.text);
                            log("0071_list_screen - addItem ==> OK");
                            /*----------------------------------------------------------*/
                            // speichert trotzdem es hier auskommentiert ist:
                            // widget.repository.saveItem(_controller.text);
                            log("0075_list_screen - saveItem");
                            /*----------------------------------------------------------*/
                            _controller.clear();
                            _updateList();
                          }
                        },
                      ),
                    ),

                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        widget.repository.addItem(value);
                        _controller.clear();
                        _updateList();
                      }
                    },
                  ),
                ),
                const Divider(thickness: 1, color: Colors.white30),
              ],
            ),
    );
  }
}
