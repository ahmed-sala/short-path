import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/src/domain/entities/home/jobs_entity.dart';
import 'package:short_path/src/presentation/shared_widgets/image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/styles/colors/app_colore.dart';
import '../../../shared_widgets/custom_auth_button.dart';

class JobDetail extends StatefulWidget {
  const JobDetail({super.key});

  @override
  State<JobDetail> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
  bool _isExpanded = false;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobDetail =
        ModalRoute.of(context)?.settings.arguments as ContentEntity?;

    final jobTitle = jobDetail?.title ?? '';
    final company = jobDetail?.company ?? '';
    final location = jobDetail?.location ?? '';
    final postedAgo = jobDetail?.datePosted ?? '';
    final description = jobDetail?.description ?? '...';
    final url = jobDetail?.url ?? '';
    final salaryRangeValue = jobDetail?.salaryRange;
    final employmentTypeValue = jobDetail?.employmentType;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // "APPLY NOW" button remains at the bottom of the screen
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 24.0.h, left: 16.0.w, right: 16.0.w),
        child: ElevatedButton(
          onPressed: () async {
            if (url.isNotEmpty) {
              await _launchUrl(url);
            } else {
              debugPrint('No URL available');
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 12.0.h),
            elevation: 4,
          ),
          child: Text(
            context.localization.applyNow,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Logo and Title
            Center(
              child: Column(
                children: [
                  ImageWidget(
                    imageUrl: jobDetail?.image,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    jobTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            // Company, Location, Posted Info
            Center(
              child: Wrap(
                spacing: 6.0.w,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    company,
                    style: TextStyle(fontSize: 14.0.sp, color: Colors.black54),
                  ),
                  const Icon(Icons.circle, size: 5, color: Colors.black54),
                  Text(
                    location,
                    style: TextStyle(fontSize: 14.0.sp, color: Colors.black54),
                  ),
                  const Icon(Icons.circle, size: 5, color: Colors.black54),
                  Text(
                    postedAgo,
                    style: TextStyle(fontSize: 14.0.sp, color: Colors.black54),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            // Row with "CREATE COVER SHEET" and "CREATE CV" buttons
            Row(
              children: [
                Expanded(
                  child: CustomAuthButton(
                    text: context.localization.coverSheet,
                    onPressed: () {
                      // Handle create cover sheet action
                    },
                    color: AppColors.whiteColor,
                    textColor: AppColors.primaryColor,
                    borderColor: AppColors.primaryColor,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0.sp,
                      color: AppColors.primaryColor,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: CustomAuthButton(
                    text: context.localization.createCv,
                    onPressed: () {
                      // Handle create CV action
                    },
                    color: AppColors.primaryColor,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0.sp,
                      color: AppColors.whiteColor,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            // Job Description Card with Read More functionality
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(16.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.localization.jobDescription,
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      AnimatedCrossFade(
                        firstChild: Text(
                          description,
                          style: TextStyle(
                            fontSize: 14.0.sp,
                            color: Colors.black54,
                          ),
                          maxLines: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                        secondChild: Text(
                          description,
                          style: TextStyle(
                            fontSize: 14.0.sp,
                            color: Colors.black54,
                          ),
                        ),
                        crossFadeState: _isExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 300),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          child: Text(
                            _isExpanded
                                ? context.localization.readLess
                                : context.localization.readMore,
                            style: TextStyle(
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Optional Salary Range section
            if (salaryRangeValue != null && salaryRangeValue.isNotEmpty)
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(16.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.localization.salaryRange,
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        salaryRangeValue,
                        style: TextStyle(
                          fontSize: 14.0.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (salaryRangeValue != null && salaryRangeValue.isNotEmpty)
              SizedBox(height: 16.h),
            // Optional Employment Type section
            if (employmentTypeValue != null && employmentTypeValue.isNotEmpty)
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(16.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.localization.employmentType,
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        employmentTypeValue,
                        style: TextStyle(
                          fontSize: 14.0.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
