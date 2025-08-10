import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roadmap/app_router.dart';
import 'package:flutter_roadmap/core/get_it/get_it.dart';
import 'package:flutter_roadmap/core/theme/app_theme.dart';
import 'package:flutter_roadmap/core/theme/bloc/theme_bloc.dart';
import 'package:flutter_roadmap/core/theme/domain/entity/theme_entity.dart';
import 'package:flutter_roadmap/presentation/screen/roadmap_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ThemeBloc>()..add(GetThemeEvent()),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.getTheme(
              state.themeEntity?.themeType == ThemeType.dark,
            ),
            onGenerateRoute: appRouter.generateRouter,
            home: RoadmapScreen(),
          );
        },
      ),
    );
  }
}
