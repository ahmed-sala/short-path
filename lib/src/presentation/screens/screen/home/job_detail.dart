import 'package:flutter/material.dart';
import 'package:short_path/src/domain/entities/home/job_entity.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/styles/cached_network_image_widget.dart';
import '../../../../../core/styles/colors/app_colore.dart';
import '../../../../../core/styles/images/app_images.dart';
import '../../../shared_widgets/custom_auth_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobDetail extends StatefulWidget {
  const JobDetail({Key? key}) : super(key: key);

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
    // Retrieve the JobEntity passed via Navigator
    final jobDetail = ModalRoute.of(context)?.settings.arguments as JobEntity?;

    // Fallback data for non-nullable fields
    final jobTitle = jobDetail?.title ?? '';
    final company = jobDetail?.company ?? '';
    final location = jobDetail?.location ?? '';
    final postedAgo = jobDetail?.datePosted ?? '';
    final description = jobDetail?.description ?? '...';
    final url = jobDetail?.url ?? '';

    // Get salaryRange and employmentType values without fallback
    final salaryRangeValue = jobDetail?.salaryRange;
    final employmentTypeValue = jobDetail?.employmentType;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        // APPLY NOW button as an ElevatedButton with border and shadow
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0.w),
            child: ElevatedButton(
              onPressed: () async {
                if (url.isNotEmpty) {
                  await _launchUrl(url);
                } else {
                  debugPrint('No URL available');
                }
              },
              style: ElevatedButton.styleFrom(
                side: BorderSide(color: AppColors.primaryColor, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                backgroundColor: Colors.white, // Button background
                padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.0.h),
              ),
              child: Text(
                'APPLY NOW',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16.0.sp,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Logo
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFFE0F2FF),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: jobDetail?.image == '' || jobDetail?.image == null
                      ? Container(
                    width: 35,
                    height: 35,
                    color: AppColors.primaryColor,
                    child: Image.asset(
                      AppImages.appLogo,
                      width: 35,
                      height: 35,
                    ),
                  )
                      : CachedNetworkImageWidget(
                    imageUrl: jobDetail!.image,
                    width: 35,
                    height: 35,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Job Title
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Text(
                  jobTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            // Company - Location - Posted Time with Flexible children to avoid overflow
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    company,
                    style: TextStyle(fontSize: 14.0.sp, color: Colors.black54),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 6.0.w),
                Text('•', style: TextStyle(fontSize: 14.0.sp, color: Colors.black54)),
                SizedBox(width: 6.0.w),
                Flexible(
                  child: Text(
                    location,
                    style: TextStyle(fontSize: 14.0.sp, color: Colors.black54),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 6.0.w),
                Text('•', style: TextStyle(fontSize: 14.0.sp, color: Colors.black54)),
                SizedBox(width: 6.0.w),
                Flexible(
                  child: Text(
                    postedAgo,
                    style: TextStyle(fontSize: 14.0.sp, color: Colors.black54),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            // Job Description title
            Text(
              'Job Description',
              style: TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 8.h),
            // Job Description text with expansion toggle
            Text(
              description,
              style: TextStyle(fontSize: 14.0.sp, color: Colors.black54),
              maxLines: _isExpanded ? null : 3,
              overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.h),
            // Conditionally display Salary Range section if exists
            if (salaryRangeValue != null && salaryRangeValue.isNotEmpty) ...[
              Text(
                'Salary Range',
                style: TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 8.h),
              Text(
                salaryRangeValue,
                style: TextStyle(fontSize: 14.0.sp, color: Colors.black54),
              ),
              SizedBox(height: 8.h),
            ],
            // Conditionally display Employment Type section if exists
            if (employmentTypeValue != null && employmentTypeValue.isNotEmpty) ...[
              Text(
                'Employment Type',
                style: TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 8.h),
              Text(
                employmentTypeValue,
                style: TextStyle(fontSize: 14.0.sp, color: Colors.black54),
              ),
              SizedBox(height: 8.h),
            ],
            // Read More / Read Less toggle button with rounded corners
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFE7E1FC),
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(
                  _isExpanded ? 'Read less' : 'Read more',
                  style: TextStyle(color: Colors.black, fontSize: 16.0.sp),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            // Column with CREATE COVER SHEET and CREATE CV buttons, one under the other
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Column(
                children: [
                  CustomAuthButton(
                    text: 'CREATE COVER SHEET',
                    onPressed: () {
                      // TODO: handle create cover sheet action
                    },
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(height: 16.h),
                  CustomAuthButton(
                    text: 'CREATE CV',
                    onPressed: () {
                      // TODO: handle create CV action
                    },
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
