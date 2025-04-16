import 'package:flutter/material.dart';
import 'package:short_path/core/extensions/extensions.dart';

import '../../../mangers/home/home_viewmodel.dart';

class JobStatsCard extends StatelessWidget {
  const JobStatsCard({Key? key, required this.viewModel}) : super(key: key);
  final HomeViewmodel viewModel;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left side: Remote Job
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFAFECFE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.insert_drive_file, size: 40),
                  SizedBox(height: 8),
                  Text(
                    viewModel.contractorJobs?.length.toString() ?? "0",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    context.localization.contractor,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20), // Reduced horizontal gap
          // Right side: Column of two stacked cards
          Flexible(
            fit: FlexFit.loose,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Full Time
                Container(
                  width: double.infinity, // Match the width if needed
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFBEAFFE),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        viewModel.fullTimeJobs?.length.toString() ?? "0",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        context.localization.fullTime,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                    height: 10), // Adjust vertical spacing if desired
                // Part Time
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD6AD),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        viewModel.partTimeJobs?.length.toString() ?? "0",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        context.localization.partTime,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
