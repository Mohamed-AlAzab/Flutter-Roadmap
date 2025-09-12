import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roadmap/core/constant/routs_string.dart';
import 'package:flutter_roadmap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_roadmap/features/theme/bloc/theme_bloc.dart';
import 'package:flutter_roadmap/features/theme/domain/entity/theme_entity.dart';
import 'package:flutter_roadmap/core/widget/coustom_app_bar.dart';
import 'package:flutter_roadmap/core/widget/coustom_bottom_navigation_bar.dart';

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
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutEvent());
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      loginScreen,
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text('Log out'),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CoustomBottomNavigationBar(index: 2),
    );
  }
}
