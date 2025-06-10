import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonJobCard extends StatelessWidget {
  const SkeletonJobCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Skeletonizer(
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: Logo + Title + Bookmark icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Skeleton for Company Logo
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Skeleton for Job Title
                        Container(
                          width: 120,
                          height: 16,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                    // Skeleton for Bookmark icon
                    Container(
                      width: 24,
                      height: 24,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Skeleton for Company & Location
                Container(
                  width: 200,
                  height: 14,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 8),
                // Skeleton for Salary
                Container(
                  width: 80,
                  height: 16,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 12),
                // Row for Tags + Apply button
                Row(
                  children: [
                    // Skeleton for Date Posted tag
                    Container(
                      width: 80,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Skeleton for Employment Type tag
                    Container(
                      width: 60,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const Spacer(),
                    // Skeleton for Apply button
                    Container(
                      width: 50,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
