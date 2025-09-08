import 'package:flutter/material.dart';
import 'package:flutter_roadmap/core/utils/helper.dart';

class CoursesCard extends StatelessWidget {
  const CoursesCard({
    super.key,
    required this.imageUrl,
    required this.barPercentage,
    required this.title,
    required this.text,
    required this.onTap,
  });

  final String imageUrl;
  final double barPercentage;
  final String title;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(12),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                height: 200,
                width: context.width - 32,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    text,
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
                              width: barPercentage > 1
                                  ? context.width - 106
                                  : barPercentage < 0
                                  ? 0
                                  : (context.width - 106) * barPercentage,
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
                        '${(barPercentage > 1
                            ? 100
                            : barPercentage < 0
                            ? 0
                            : barPercentage * 100).ceil()}%',
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
