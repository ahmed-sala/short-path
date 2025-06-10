import 'package:flutter/material.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/images/app_images.dart';
import 'package:short_path/src/domain/entities/home/jobs_entity.dart';

import '../../../../../../../config/routes/routes_name.dart';
import '../../../../../../../core/styles/cached_network_image_widget.dart';
import '../../../../../short_path.dart';

class JobCard extends StatelessWidget {
  const JobCard({super.key, required this.job});

  final ContentEntity? job;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
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
                  Expanded(
                    child: Row(
                      children: [
                        // Company Logo (placeholder)
                        Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            // Wrap image in ClipOval for a perfect circle
                            child: ClipOval(
                              child: job?.image == '' || job?.image == null
                                  ? Container(
                                      width: 40,
                                      height: 40,
                                      color: AppColors.primaryColor,
                                      child: Image.asset(
                                        AppImages.appLogo,
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : CachedNetworkImageWidget(
                                      imageUrl: job!.image,
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Job Title
                        Expanded(
                          child: Text(
                            truncateTitle(job?.title ?? ""),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Bookmark icon
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark_border),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Company & Location
              Text(
                "${job?.company ?? ''} \u2022 ${job?.location ?? ''}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 8),

              // Salary
              if (job?.salaryRange != '') ...[
                Text(
                  "\$${job?.salaryRange ?? ''}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
              ],

              // Tags + Apply button
              Row(
                children: [
                  // "Senior designer" tag
                  if (job?.datePosted != '') ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F2F8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        job?.datePosted ?? "",
                        style: const TextStyle(
                          color: Color(0xFF514A6B),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  // "Full time" tag
                  if (job?.employmentType != '') ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F2F8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        job?.employmentType ?? "",
                        style: const TextStyle(
                          color: Color(0xFF514A6B),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                  const Spacer(),
                  // Apply button
                  InkWell(
                    onTap: () {
                      navKey.currentState!
                          .pushNamed(RoutesName.jobDetail, arguments: job);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B2C),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        context.localization.readMore,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String truncateTitle(String title) {
    final words = title.split(' ');
    if (words.length > 3) {
      return '${words.sublist(0, 3).join(' ')}...';
    }
    return title;
  }
}
