import 'package:flutter_roadmap/core/theme/domain/entity/theme_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeLocalDatasource {
  final SharedPreferences sharedPreferences;

  ThemeLocalDatasource({required this.sharedPreferences});

  Future saveTheme(ThemeEntity themeEntity) async {
    var themeValue = themeEntity.themeType == ThemeType.dark ? 'dark' : 'light';
    await sharedPreferences.setString('theme_key', themeValue);
  }

  Future<ThemeEntity> getTheme() async {
    var themeValue = sharedPreferences.getString('theme_key');
    if (themeValue == 'dark') {
      return ThemeEntity(themeType: ThemeType.dark);
    }
    return ThemeEntity(themeType: ThemeType.light);
  }
}
