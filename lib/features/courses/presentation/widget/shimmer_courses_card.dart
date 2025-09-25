import 'package:flutter/material.dart';
import 'package:flutter_roadmap/core/utils/helper.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerCoursesCard extends StatelessWidget {
  const ShimmerCoursesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(seconds: 3),
      interval: const Duration(seconds: 0),
      color: Colors.white,
      colorOpacity: 0,
      enabled: true,
      direction: const ShimmerDirection.fromLTRB(),
      child: Container(
        width: context.width - 32,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 200,
                width: context.width - 32,
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: context.width * 0.5,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 16,
                    width: context.width * 0.3,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 6,
                    width: context.width - 106,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
