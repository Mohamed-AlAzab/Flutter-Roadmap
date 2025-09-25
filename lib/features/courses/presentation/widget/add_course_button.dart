import 'package:flutter/material.dart';
import 'package:flutter_roadmap/core/utils/helper.dart';

class AddCourseButton extends StatelessWidget {
  const AddCourseButton({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface,
            width: 1.5,
          ),
        ),
        width: context.width / 2,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text('Add Course', style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
