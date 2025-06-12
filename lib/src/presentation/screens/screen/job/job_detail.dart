import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/functions/send_email.dart';
import 'package:short_path/src/domain/entities/home/jobs_entity.dart';
import 'package:short_path/src/presentation/mangers/job_detail/job_detail_cubit.dart';
import 'package:short_path/src/presentation/mangers/job_detail/job_detail_state.dart';
import 'package:short_path/src/presentation/screens/screen/job/widgets/company_logo_title_widget.dart';
import 'package:short_path/src/presentation/screens/screen/job/widgets/employment_type_widget.dart';
import 'package:short_path/src/presentation/screens/screen/job/widgets/job_describtion_detailed_widget.dart';
import 'package:short_path/src/presentation/screens/screen/job/widgets/job_info_widget.dart';
import 'package:short_path/src/presentation/screens/screen/job/widgets/salary_range_widget.dart';
import 'package:short_path/src/presentation/shared_widgets/buttons_section_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../config/helpers/shared_pref/shared_pre_keys.dart';
import '../../../../../config/routes/routes_name.dart';
import '../../../../../core/dialogs/awesome_dialoge.dart';
import '../../../../../core/styles/colors/app_colore.dart';
import '../../../../../dependency_injection/di.dart';
import '../../../../short_path.dart';
import '../../../shared_widgets/custom_auth_button.dart';
import '../career/cover_sheet_screen.dart';
import '../career/widgets/create_cv_handle.dart';
class JobDetail extends StatefulWidget {
  const JobDetail({super.key});

  @override
  State<JobDetail> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
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
      body: BlocProvider(
        create: (context) => getIt<JobDetailCubit>(),
        child: Builder(builder: (context) {
          var isHaveCv =
              getIt<SharedPreferences>().getBool(SharedPrefKeys.completeCv) ??
                  false;
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.h),
            child: BlocListener<JobDetailCubit, JobDetailState>(
              listener: (context, state) {
                final vm = context.read<JobDetailCubit>();
                if (state is GenerateCoverSheetLoading) {
                  EasyLoading.show(status: 'Generating cover sheet...');
                } else if (state is GenerateCoverSheetSuccess) {
                  EasyLoading.dismiss();
                  EasyLoading.showSuccess('Cover sheet ready!');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CoverSheetScreen(
                        response: vm.coverSheet,
                        sendEmail: () => EmailHandler.sendEmails(
                          vm.coverSheet,
                          vm.emailSubject,
                          vm.companyEmail,
                        ),
                      ),
                    ),
                  );
                } else if (state is GenerateCoverSheetError) {
                  EasyLoading.dismiss();
                  Fluttertoast.showToast(
                    msg: state.message,
                    backgroundColor: Colors.redAccent,
                    textColor: Colors.white,
                  );
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CompanyLogoTitleWidget(
                    jobTitle: jobDetail?.title ?? '',
                    imageUrl: jobDetail?.image,
                  ),
                  SizedBox(height: 16.h),
                  // Company, Location, Posted Info
                  JobInfoWidget(
                    company: jobDetail?.company ?? '',
                    location: jobDetail?.location ?? '',
                    postedAgo: jobDetail?.datePosted ?? '',
                  ),
                  SizedBox(height: 16.h),
                  // Row with "CREATE COVER SHEET" and "CREATE CV" buttons
                  ButtonsSectionWidget(
                    onGenerateCoverSheetTap: () {
                      int jobId = jobDetail?.id ?? 0;
                      if (isHaveCv) {
                        context
                            .read<JobDetailCubit>()
                            .generateCoverSheet(jobId);
                      } else {
                        showCustomDialog(context,
                            title: 'make cv',
                            message: 'Please make your cv', onConfirm: () {
                          getIt<SharedPreferences>()
                              .setBool(SharedPrefKeys.completeCv, true);
                          navKey.currentState?.pushNamedAndRemoveUntil(
                            RoutesName.profile,
                            (Route<dynamic> route) => false,
                          );
                        });
                      }
                    },
                    onGenerateCvTap: () async {
                      int jobId = jobDetail?.id ?? 0;
                      if (isHaveCv) {
                        await handleCreateCV(
                          context,
                          jobId: jobId,
                          jobDescription: jobDetail?.description ?? '',
                        );
                      } else {
                        showCustomDialog(context,
                            title: 'make cv',
                            message: 'Please make your cv', onConfirm: () {
                          getIt<SharedPreferences>()
                              .setBool(SharedPrefKeys.completeCv, true);
                          navKey.currentState?.pushNamedAndRemoveUntil(
                            RoutesName.profile,
                            (Route<dynamic> route) => false,
                          );
                        });
                      }
                    },
                  ),
                  SizedBox(height: 24.h),
                  // Job Description Card with Read More functionality
                  JobDescriptionDetailedWidget(
                      description: jobDetail?.description ?? '...'),
                  SizedBox(height: 16.h),
                  if (salaryRangeValue != null && salaryRangeValue.isNotEmpty)
                    SalaryRangeWidget(salaryRangeValue: salaryRangeValue),
                  if (salaryRangeValue != null && salaryRangeValue.isNotEmpty)
                    SizedBox(height: 16.h),
                  // Optional Employment Type section
                  if (employmentTypeValue != null &&
                      employmentTypeValue.isNotEmpty)
                    EmploymentTypeWidget(
                        employmentTypeValue: employmentTypeValue),
                  SizedBox(height: 24.h),
                  CustomAuthButton(
                    text: 'Generate Interview Preparation',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RoutesName.InterviewPreparation,
                        arguments: {
                          'jobId': jobDetail?.id ?? 0,
                          'jobTitle': jobDetail?.title,
                        },
                      );
                    },
                    color: AppColors.primaryColor,
                    textColor: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
