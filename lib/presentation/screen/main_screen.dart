import 'package:flutter/material.dart';
import 'package:flutter_roadmap/presentation/screen/roadmap_screen.dart';
import 'package:flutter_roadmap/presentation/screen/progress_screen.dart';
import 'package:flutter_roadmap/presentation/screen/settings_screen.dart';
import 'package:flutter_svg/svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> pages = [
    RoadmapScreen(),
    ProgressScreen(),
    SettingsScreen(),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (index) => setState(() {
          this.index = index;
        }),
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.surface,
        iconSize: 24,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: index == 0
                ? Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.map,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.map_outlined,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
            label: 'Roadmap',
          ),
          BottomNavigationBarItem(
            icon: index == 1
                ? SvgPicture.asset(
                    'assets/images/svg/selected_progress.svg',
                    color: Theme.of(context).colorScheme.primary,
                  )
                : SvgPicture.asset(
                    'assets/images/svg/unselected_progress.svg',
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: index == 2
                ? SvgPicture.asset(
                    'assets/images/svg/selected_settings.svg',
                    color: Theme.of(context).colorScheme.primary,
                  )
                : SvgPicture.asset(
                    'assets/images/svg/unselected_settings.svg',
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
