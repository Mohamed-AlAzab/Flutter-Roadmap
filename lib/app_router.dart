import 'package:flutter/material.dart';
import 'package:flutter_roadmap/core/constant/routs_string.dart';
import 'package:flutter_roadmap/features/content/presentation/content_screen.dart';
import 'package:flutter_roadmap/features/auth/presentation/screen/forgot_password_screen.dart';
import 'package:flutter_roadmap/features/auth/presentation/screen/login_screen.dart';
import 'package:flutter_roadmap/features/progress/presentation/screen/progress_screen.dart';
import 'package:flutter_roadmap/features/courses/presentation/screen/roadmap_screen.dart';
import 'package:flutter_roadmap/features/setting/presentation/settings_screen.dart';
import 'package:flutter_roadmap/features/auth/presentation/screen/signup_screen.dart';
import 'package:flutter_roadmap/features/topic/presentation/topic_screen.dart';
import 'package:flutter_roadmap/features/topic/presentation/topics_screen.dart';

class AppRouter {
  Route? generateRouter(RouteSettings setting) {
    switch (setting.name) {
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case signupScreen:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case roadmapScreen:
        return MaterialPageRoute(builder: (_) => RoadmapScreen());
      case progressScreen:
        return MaterialPageRoute(builder: (_) => ProgressScreen());
      case settingScreen:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case contentScreen:
        return MaterialPageRoute(builder: (_) => ContentScreen());
      case topicsScreen:
        return MaterialPageRoute(builder: (_) => TopicsScreen());
      case topicScreen:
        return MaterialPageRoute(builder: (_) => TopicScreen());
    }
    return null;
  }
}
