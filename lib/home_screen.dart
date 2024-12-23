import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/features/statistics/screens/statistics_screen.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

import 'features/task_list/screens/list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.repository,
    // required this.onDarkModeTapped, //todo: Bugfix Darkmode
  });

  final DatabaseRepository repository;
  // final VoidCallback onDarkModeTapped; //todo: Bugfix Darkmode

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavBarIndex = 0;
  List<Widget> _navBarWidgets = [];
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    /*--------------------------------- Audio ---*/
    player.play(AssetSource("sound/sound06pling.wav"));
    /*--------------------------------- *** ---*/
    _navBarWidgets = [
      ListScreen(repository: widget.repository),
      StatisticsScreen(repository: widget.repository),
      // onDarkModeTapped: widget.onDarkModeTapped, //todo: Bugfix Darkmode
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navBarWidgets[_selectedNavBarIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Aufgaben',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Statistik',
          ),
        ],
        currentIndex: _selectedNavBarIndex,
        selectedItemColor: Colors.deepPurple[200],
        onTap: (int index) {
          player.play(AssetSource("sound/sound02click.wav"));
          setState(() {
            _selectedNavBarIndex = index;
          });
        },
      ),
    );
  }
}
