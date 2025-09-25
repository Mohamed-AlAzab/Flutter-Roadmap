import 'package:flutter/material.dart';
import 'package:flutter_roadmap/core/constant/routs_string.dart';
import 'package:flutter_roadmap/core/widget/coustom_app_bar.dart';
import 'package:flutter_roadmap/core/widget/coustom_bottom_navigation_bar.dart';
import 'package:flutter_roadmap/features/sections/presentation/coustom_content_card.dart';

class ContentScreen extends StatelessWidget {
  ContentScreen({super.key});

  final List<Map<String, String>> content = [
    {
      'title': 'UI',
      'text':
          'Learn how to build beautiful user interfaces with Flutter\'s rich set of widgets.',
    },
    {
      'title': 'Firebase',
      'text':
          'Integrate Firebase services like authentication, database, and storage into your Flutter app.',
    },
    {
      'title': 'API',
      'text':
          'Fetch data from APIs and handle network requests in your Flutter application.',
    },
    {
      'title': 'State Management',
      'text':
          'Manage app state efficiently using providers, Riverpod, or other state management solutions.',
    },
    {
      'title': 'Local Database',
      'text':
          'Implement local data persistence using SQLite, Hive, or other database solutions.',
    },
    {
      'title': 'Navigation',
      'text': 'Navigate between screens and manage routes in your Flutter app.',
    },
    {
      'title': 'Forms',
      'text': 'Handle user input, validate forms, and manage form state.',
    },
    {
      'title': 'Animations',
      'text':
          'Implement animations and transitions to enhance the user experience.',
    },
    {
      'title': 'Testing',
      'text': 'Test your Flutter app with unit, widget, and integration tests.',
    },
    {
      'title': 'Error Handling',
      'text':
          'Handle errors and exceptions gracefully in your Flutter application.',
    },
    {
      'title': 'Localization',
      'text':
          'Internationalize and localize your Flutter app for different languages and regions.',
    },
    {
      'title': 'Push Notifications',
      'text':
          'Implement push notifications to engage users and provide timely updates.',
    },
    {
      'title': 'In-App Purchases',
      'text':
          'Integrate in-app purchases and subscriptions into your Flutter app.',
    },
    {
      'title': 'Authentication',
      'text':
          'Implement user authentication and authorization using various methods.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CoustomAppBar(title: 'Content'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 4),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: content.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CoustomContentCard(
                  onTap: () {
                    Navigator.pushNamed(context, topicsScreen);
                  },
                  title: content[index]['title']!,
                  text: content[index]['text']!,
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: CoustomBottomNavigationBar(),
    );
  }
}
