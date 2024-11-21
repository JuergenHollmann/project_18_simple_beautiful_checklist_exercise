import 'dart:developer';

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

       //AudioPlayer player = AudioPlayer();

    return ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index]),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              /*--------------------------- IconButton Bleistift ---*/
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  //player.play(AssetSource("sound/sound06pling.wav"));
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
                          decoration: const InputDecoration(
                              hintText: "Aufgabe bearbeiten"),
                        ),
                        actions: [
                          /*--------------------------- abbrechen ---*/
                          TextButton(
                            child: const Text('Abbrechen'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          /*--------------------------- speichern ---*/
                          TextButton(
                            child: const Text('Speichern'),
                            onPressed: () {
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
                  /*--------------------------- showDialog ---*/
                  showDialog(
                    context: context,
                    builder: (context) {
                      /*--------------------------- AlertDialog ---*/
                      return AlertDialog(
                        backgroundColor: const Color.fromARGB(255, 164, 11, 0),
                        title: const Text('Aufgabe löschen?'),
                        // content: const TextField(
                        //   autofocus: true,
                        //   //controller: editController,
                        //   decoration:
                        //       InputDecoration(hintText: "Aufgabe löschen"),
                        // ),
                        actions: [
                          /*--------------------------- abbrechen ---*/
                          TextButton(
                            child: const Text('Abbrechen'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          /*--------------------------- löschen ---*/
                          TextButton(
                            child: const Text('Löschen'),
                            onPressed: () {
                              log("0073 - item_list - LÖSCHEN");
                              repository.deleteItem(index);
                              updateOnChange();

                              // repository.editItem(index, editController.text);
                              // updateOnChange();
                              Navigator.of(context).pop();
                            },
                          )
                          /*--------------------------- *** ---*/
                        ],
                      );
                    },
                  );

                  // log("0073 - item_list - LÖSCHEN");
                  // repository.deleteItem(index);
                  // updateOnChange();
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
