import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roadmap/core/constant/string.dart';
import 'package:flutter_roadmap/core/theme/bloc/theme_bloc.dart';
import 'package:flutter_roadmap/core/theme/domain/entity/theme_entity.dart';
import 'package:flutter_roadmap/presentation/widget/coustom_app_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CoustomAppBar(title: 'Settings'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              color: Theme.of(context).colorScheme.surface,
              shadowColor: const Color.fromARGB(0, 255, 255, 255),
              child: ListTile(
                title: Title(color: Colors.white, child: Text('Dark Mode')),
                trailing: CupertinoSwitch(
                  value:
                      context.watch<ThemeBloc>().state.themeEntity?.themeType ==
                          ThemeType.dark
                      ? true
                      : false,
                  onChanged: (value) {
                    setState(() {});
                    context.read<ThemeBloc>().add(ToggleThemeEvent());
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                loginScreen,
                (Route<dynamic> route) => false,
              ),
              child: Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
