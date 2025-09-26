import 'package:flutter/material.dart';
import 'package:flutter_roadmap/core/utils/helper.dart';
import 'package:flutter_roadmap/core/widget/custom_app_bar.dart';
import 'package:flutter_roadmap/core/widget/custom_bottom_navigation_bar.dart';
import 'package:flutter_roadmap/features/progress/presentation/widget/custom_progress_card.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(title: 'Progress'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/personal-photo.png',
                width: 128,
                height: 128,
              ),
              SizedBox(height: 16),
              Text(
                'Mohamed',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Level 3',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Joined 2 months ago',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 32),
              SizedBox(
                width: context.width,
                child: Text(
                  'Roadmap Progress',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              SizedBox(height: 16),
              CoustomProgressCard(
                title: 'Flutter Basics',
                text: '5/8 lessons completed',
              ),
              SizedBox(height: 16),
              CoustomProgressCard(
                title: 'Flutter Basics',
                text: '5/8 lessons completed',
              ),
              SizedBox(height: 16),
              CoustomProgressCard(
                title: 'Flutter Basics',
                text: '5/8 lessons completed',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CoustomBottomNavigationBar(index: 1),
    );
  }
}
