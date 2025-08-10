import 'package:flutter/material.dart';
import 'package:flutter_roadmap/core/constant/string.dart';
import 'package:flutter_roadmap/presentation/widget/coustom_app_bar.dart';
import 'package:flutter_roadmap/presentation/widget/coustom_bottom_navigation_bar.dart';
import 'package:flutter_roadmap/presentation/widget/coustom_home_card.dart';

class RoadmapScreen extends StatelessWidget {
  const RoadmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CoustomAppBar(title: 'Roadmaps'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CoustomHomeCard(
                  onTap: () {
                    Navigator.pushNamed(context, contentScreen);
                  },
                  imageUrl: 'assets/images/dart.jpg',
                  title: 'Dart Fundamentals',
                  text: 'Learn the basics of Dart programming language',
                  barPercentage: 0.79,
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: CoustomBottomNavigationBar(index: 0),
    );
  }
}
