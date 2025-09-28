import 'package:flutter/material.dart';
import 'package:flutter_roadmap/core/utils/helper.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerSectionCard extends StatelessWidget {
  const ShimmerSectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Neutral gray for light mode, bluish gray for dark mode
    final blockColor = isDark
        ? const Color(0xFF3A4554) // dark cool gray (with slight blue)
        : Colors.grey[300]!; // normal light gray
    final cardColor = isDark
        ? const Color(0xFF2E3642) // darker cool gray for card
        : Colors.grey[100]!; // neutral background in light

    return Shimmer(
      duration: const Duration(seconds: 3),
      interval: const Duration(seconds: 0),
      color: blockColor,
      colorOpacity: 0.25,
      enabled: true,
      direction: const ShimmerDirection.fromLTRB(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          width: context.width - 32,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Container(
                          height: 20,
                          width: context.width * 0.5,
                          color: blockColor,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 16,
                          width: context.width * 0.3,
                          color: blockColor,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: CircularProgressIndicator(
                        value: 1,
                        color: blockColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
