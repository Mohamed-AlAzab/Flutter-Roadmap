import 'package:flutter/material.dart';
import 'package:flutter_roadmap/core/utils/helper.dart';
import 'package:flutter_roadmap/presentation/widget/coustom_app_bar.dart';
import 'package:flutter_roadmap/presentation/widget/coustom_bottom_navigation_bar.dart';
import 'package:flutter_roadmap/presentation/widget/coustom_button.dart';
import 'package:flutter_svg/svg.dart';

class TopicScreen extends StatelessWidget {
  const TopicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CoustomAppBar(title: 'Topics'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                width: context.width,
                child: Text(
                  'Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                width: context.width,
                child: Text(
                  'Flutter is an open-source UI software development kit created by Google. It is used to develop applications for Android, iOS, Linux, macOS, Windows, Google Fuchsia, and the web from a single codebase. The first version of Flutter was known as \'Sky\' and ran on the Android operating system. It was unveiled at the 2015 Dart developer summit, with the stated intent to be able to render consistently at 120 frames per second.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: context.width,
                child: Text(
                  'Tasks',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                width: context.width,
                child: CheckboxListTile(
                  title: Text('Read the official Flutter documentation'),
                  contentPadding: EdgeInsets.zero,
                  value: true,
                  onChanged: (_) {},
                  activeColor: Theme.of(context).colorScheme.onSurface,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(
                width: context.width,
                child: CheckboxListTile(
                  title: Text('Complete the Flutter codelab'),
                  contentPadding: EdgeInsets.zero,
                  value: false,
                  onChanged: (_) {},
                  activeColor: Theme.of(context).colorScheme.onSurface,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(
                width: context.width,
                child: CheckboxListTile(
                  title: Text('Watch a Flutter tutorial video'),
                  contentPadding: EdgeInsets.zero,
                  value: false,
                  onChanged: (_) {},
                  activeColor: Theme.of(context).colorScheme.onSurface,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: context.width,
                child: Text(
                  'Practice',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Coding Challenge',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(
                width: context.width,
                child: Text(
                  'Attachments',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              SizedBox(height: 8),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      'assets/images/svg/topic_icon.svg',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                title: Text('Attach Code'),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CoustomButton(
                    onTap: () {},
                    text: 'Mark as Done',
                    color: Theme.of(context).colorScheme.onSurface,
                    textColor: Theme.of(context).colorScheme.surface,
                    width: context.width * 0.4,
                    height: 50,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CoustomBottomNavigationBar(),
    );
  }
}
