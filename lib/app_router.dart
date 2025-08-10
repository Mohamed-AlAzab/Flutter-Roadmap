import 'package:flutter/material.dart';
import 'package:flutter_roadmap/core/constant/string.dart';
import 'package:flutter_roadmap/presentation/screen/content_screen.dart';
import 'package:flutter_roadmap/presentation/screen/forgot_password_screen.dart';
import 'package:flutter_roadmap/presentation/screen/login_screen.dart';
import 'package:flutter_roadmap/presentation/screen/main_screen.dart';
import 'package:flutter_roadmap/presentation/screen/signin_screen.dart';
import 'package:flutter_roadmap/presentation/screen/topic_screen.dart';
import 'package:flutter_roadmap/presentation/screen/topics_screen.dart';

class AppRouter {
  Route? generateRouter(RouteSettings setting) {
    switch (setting.name) {
      case mainScreen:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case signinScreen:
        return MaterialPageRoute(builder: (_) => SigninScreen());
      case forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
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
