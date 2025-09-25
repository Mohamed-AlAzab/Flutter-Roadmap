import 'package:flutter/material.dart';
import 'package:flutter_roadmap/core/utils/helper.dart';
import 'package:flutter_roadmap/features/courses/domain/entity/course.dart';
import 'package:flutter_svg/svg.dart';

class CoursesCard extends StatelessWidget {
  const CoursesCard({
    super.key,
    required this.course,
    required this.onTap,
    this.onLongPress,
  });

  final Course course;
  final VoidCallback onTap;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: context.width - 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xff345eca),
                borderRadius: BorderRadius.circular(12),
              ),
              width: context.width - 32,
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (course.icon != 'null')
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/svg/${course.icon}_icon.svg',
                          colorFilter: null,
                          width: 74,
                        ),
                        SizedBox(width: 16),
                      ],
                    ),
                  Text(
                    course.name,
                    style: TextStyle(fontSize: 74, color: Color(0xff142c5e)),
                  ),
                ],
              ),
              /*
                Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: 200,
                  width: context.width - 32,
                ),
              */
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course.description,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(
                        height: 6,
                        child: Stack(
                          children: [
                            Container(
                              width: context.width - 106,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color(0xffE8EDF2),
                              ),
                            ),
                            Container(
                              width: course.progress > 1
                                  ? context.width - 106
                                  : course.progress < 0
                                  ? 0
                                  : (context.width - 106) * course.progress,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '${(course.progress > 1
                            ? 100
                            : course.progress < 0
                            ? 0
                            : course.progress * 100).ceil()}%',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
