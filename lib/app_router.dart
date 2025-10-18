import 'package:flutter/material.dart';
import 'package:flutter_roadmap/core/constant/routs_string.dart';
import 'package:flutter_roadmap/features/courses/domain/entity/course.dart';
import 'package:flutter_roadmap/features/courses/presentation/screen/add_course_screen.dart';
import 'package:flutter_roadmap/features/courses/presentation/screen/edit_course_screen.dart';
import 'package:flutter_roadmap/features/sections/domain/entity/section.dart';
import 'package:flutter_roadmap/features/sections/presentation/screen/add_section_screen.dart';
import 'package:flutter_roadmap/features/sections/presentation/screen/edit_section_screen.dart';
import 'package:flutter_roadmap/features/sections/presentation/screen/sections_screen.dart';
import 'package:flutter_roadmap/features/auth/presentation/screen/forgot_password_screen.dart';
import 'package:flutter_roadmap/features/auth/presentation/screen/login_screen.dart';
import 'package:flutter_roadmap/features/progress/presentation/screen/progress_screen.dart';
import 'package:flutter_roadmap/features/courses/presentation/screen/roadmap_screen.dart';
import 'package:flutter_roadmap/features/setting/presentation/settings_screen.dart';
import 'package:flutter_roadmap/features/auth/presentation/screen/signup_screen.dart';
import 'package:flutter_roadmap/features/topic/presentation/screen/topic_screen.dart';
import 'package:flutter_roadmap/features/topic/presentation/screen/topics_screen.dart';

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
      case addCourseScreen:
        final courses = setting.arguments as List<Course>;
        return MaterialPageRoute(
          builder: (_) => AddCourseScreen(courses: courses),
        );
      case editCourseScreen:
        final args = setting.arguments as Map<String, dynamic>;
        final courses = args['courses'] as List<Course>;
        final course = args['course'] as Course;
        return MaterialPageRoute(
          builder: (_) => EditCourseScreen(courses: courses, course: course),
        );
      case progressScreen:
        return MaterialPageRoute(builder: (_) => ProgressScreen());
      case settingScreen:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case sectionsScreen:
        final Course course = setting.arguments as Course;
        return MaterialPageRoute(
          builder: (_) => SectionsScreen(course: course),
        );
      case addSectionScreen:
        final args = setting.arguments as Map<String, dynamic>;
        final Course course = args['course'] as Course;
        final sections = args['sections'] as List<Section>;
        return MaterialPageRoute(
          builder: (_) => AddSectionScreen(course: course, section: sections),
        );
      case editSectionScreen:
        final args = setting.arguments as Map<String, dynamic>;
        final Course course = args['course'] as Course;
        final sections = args['sections'] as List<Section>;
        final section = args['section'] as Section;
        return MaterialPageRoute(
          builder: (_) => EditSectionScreen(
            section: section,
            sections: sections,
            course: course,
          ),
        );
      case topicsScreen:
        final args = setting.arguments as Map<String, dynamic>;
        final course = args['course'] as Course;
        final section = args['section'] as Section;
        return MaterialPageRoute(
          builder: (_) => TopicsScreen(section: section, course: course),
        );
      case topicScreen:
        return MaterialPageRoute(builder: (_) => TopicScreen());
    }
    return null;
  }
}
