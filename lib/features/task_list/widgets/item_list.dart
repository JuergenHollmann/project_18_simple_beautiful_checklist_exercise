import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    required this.repository,
    required this.items,
    required this.updateOnChange,
  });

  final DatabaseRepository repository;
  final List<String> items;
  final void Function() updateOnChange;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            items[index],
            style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              /*--------------------------- IconButton Bleistift ---*/
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  AudioPlayer player = AudioPlayer();
                  player.play(AssetSource("sound/sound02click.wav"));
                  TextEditingController editController =
                      TextEditingController(text: items[index]);
                  /*--------------------------- showDialog ---*/
                  showDialog(
                    context: context,
                    builder: (context) {
                      /*--------------------------- AlertDialog ---*/
                      return AlertDialog(
                        backgroundColor: const Color.fromARGB(255, 6, 0, 193),
                        title: const Text('Aufgabe bearbeiten'),
                        content: TextField(
                          autofocus: true,
                          controller: editController,
                          /*--------------------------- ermöglicht ENTER-Eingaben mit Zeilenvorschub ---*/
                          textAlignVertical: TextAlignVertical.top,
                          maxLines:
                              null, // ermöglicht ENTER-Eingaben mit Zeilenvorschub
                          /*--------------------------- *** ---*/
                          decoration: const InputDecoration(
                              hintText: "Aufgabe bearbeiten"),
                        ),
                        actions: [
                          /*--------------------------- abbrechen ---*/
                          TextButton(
                            child: const Text('Abbrechen'),
                            onPressed: () {
                              AudioPlayer player = AudioPlayer();
                              player
                                  .play(AssetSource("sound/sound07woosh.wav"));
                              Navigator.of(context).pop();
                            },
                          ),
                          /*--------------------------- speichern ---*/
                          TextButton(
                            child: const Text('Speichern'),
                            onPressed: () {
                              AudioPlayer player = AudioPlayer();
                              player
                                  .play(AssetSource("sound/sound06pling.wav"));
                              repository.editItem(index, editController.text);
                              updateOnChange();
                              Navigator.of(context).pop();
                            },
                          )
                          /*--------------------------- *** ---*/
                        ],
                      );
                    },
                  );
                },
              ),
              /*--------------------------- löschen ---*/
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  AudioPlayer player = AudioPlayer();
                  player.play(AssetSource("sound/sound03enterprise.wav"));
                  /*--------------------------- showDialog ---*/
                  showDialog(
                    context: context,
                    builder: (context) {
                      /*--------------------------- AlertDialog ---*/
                      return AlertDialog(
                        backgroundColor: const Color.fromARGB(
                            255, 164, 11, 0), // dunkles Rot
                        title: const Text('Aufgabe löschen?'),
                        actions: [
                          /*--------------------------- abbrechen ---*/
                          TextButton(
                            child: const Text('Abbrechen'),
                            onPressed: () {
                              AudioPlayer player = AudioPlayer();
                              player
                                  .play(AssetSource("sound/sound07woosh.wav"));
                              Navigator.of(context).pop();
                            },
                          ),
                          /*--------------------------- löschen ---*/
                          TextButton(
                            child: const Text('Löschen'),
                            onPressed: () {
                              AudioPlayer player = AudioPlayer();
                              player.play(
                                  AssetSource("sound/sound05xylophon.wav"));
                              log("0073 - item_list - LÖSCHEN");
                              repository.deleteItem(index);
                              updateOnChange();
                              Navigator.of(context).pop();
                              /*--------------------------------- Snackbar ---*/
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: const Color.fromARGB(
                                    255, 164, 11, 0), // dunkles Rot
                                duration: const Duration(milliseconds: 3000),
                                content: Text(
                                  "Hinweis:\nDie Aufgabe an Position - ${index + 1} - wurde erfolgreich gelöscht! 😉",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ));
                              /*--------------------------------- *** ---*/
                            },
                          )
                          /*--------------------------- *** ---*/
                        ],
                      );
                    },
                  );
                },
              ),
              /*--------------------------- *** ---*/
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        thickness: 1,
        color: Colors.white30,
      ),
    );
  }
}
