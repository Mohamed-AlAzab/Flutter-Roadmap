import 'package:flutter/material.dart';
import 'package:flutter_roadmap/core/constant/routs_string.dart';
import 'package:flutter_roadmap/core/utils/helper.dart';
import 'package:flutter_roadmap/core/widget/custom_app_bar.dart';
import 'package:flutter_roadmap/core/widget/custom_bottom_navigation_bar.dart';
import 'package:flutter_roadmap/features/topic/presentation/coustom_topics_card.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(title: 'Topic'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                width: context.width,
                child: Text(
                  'Programming Language Basics',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                width: context.width,
                child: Text(
                  'Master the foundational elements of programming, including variables, control structures, and data manipulation.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: CoustomTopicsCard(
                      onTap: () {
                        Navigator.pushNamed(context, topicScreen);
                      },
                      title: 'Variables',
                      text: 'Learn to declare and use variables to store data.',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CoustomBottomNavigationBar(),
    );
  }
}
