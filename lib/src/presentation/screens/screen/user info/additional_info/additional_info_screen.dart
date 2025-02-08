import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/dependency_injection/di.dart';
import '../../../../mangers/infromation_gathering/additional_info/additional_info_state.dart';
import '../../../../mangers/infromation_gathering/additional_info/additional_info_viewmodel.dart';
import '../../../../shared_widgets/custom_auth_button.dart';
import '../../../../shared_widgets/custom_auth_text_feild.dart';

class AdditionalInfoScreen extends StatelessWidget {
  const AdditionalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AdditionalInfoViewmodel viewModel = getIt.get<AdditionalInfoViewmodel>();
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Additional Information'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
            child: BlocConsumer<AdditionalInfoViewmodel, AdditionalInfoState>(
              listener: (context, state) {
                if (state is AdditionalInfoUpdated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Item deleted!')),
                  );
                }
              },
              buildWhen: (previous, current) =>
              current is AdditionalInfoInitialState ||
                  current is ValidateColorButtonState ||
                  current is AdditionalInfoUpdated,
              builder: (context, state) {
                final viewModel = context.read<AdditionalInfoViewmodel>();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Form for Adding Additional Info
                    Form(
                      key: viewModel.formKey,
                      onChanged: viewModel.validateColorButton,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            hintText: 'Enter Hobbies and Interests',
                            keyboardType: TextInputType.text,
                            controller: viewModel.hobbiesAndInterestsController,
                            labelText: 'Hobbies and Interests',
                            validator: (value) =>
                                viewModel.validateField(value, 'Hobbies and Interests'),
                          ),
                          verticalSpace(20),
                          CustomTextFormField(
                            hintText: 'Enter Publications',
                            keyboardType: TextInputType.text,
                            controller: viewModel.publicationsController,
                            labelText: 'Publications',
                            validator: (value) =>
                                viewModel.validateField(value, 'Publications'),
                          ),
                          verticalSpace(20),
                          CustomTextFormField(
                            hintText: 'Enter Awards and Honors',
                            keyboardType: TextInputType.text,
                            controller: viewModel.awardsAndHonorsController,
                            labelText: 'Awards and Honors',
                            validator: (value) =>
                                viewModel.validateField(value, 'Awards and Honors'),
                          ),
                          verticalSpace(20),
                          CustomTextFormField(
                            hintText: 'Enter Volunteer Work Description',
                            keyboardType: TextInputType.text,
                            controller: viewModel.volunteerWorkDescriptionController,
                            labelText: 'Volunteer Work Description',
                            validator: (value) =>
                                viewModel.validateField(value, 'Volunteer Work Description'),
                          ),
                          verticalSpace(20),
                          // Month and Year Selection
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: viewModel.selectedMonth,
                                  items: [
                                    'January', 'February', 'March', 'April', 'May', 'June',
                                    'July', 'August', 'September', 'October', 'November', 'December'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      viewModel.setMonth(newValue);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Month',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              horizontalSpace(10),
                              Expanded(
                                child: DropdownButtonFormField<int>(
                                  value: viewModel.selectedYear,
                                  items: List.generate(50, (index) {
                                    return DropdownMenuItem<int>(
                                      value: DateTime.now().year - index,
                                      child: Text('${DateTime.now().year - index}'),
                                    );
                                  }),
                                  onChanged: (int? newValue) {
                                    if (newValue != null) {
                                      viewModel.setYear(newValue);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Year',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(20),
                          CustomAuthButton(
                            text: 'Add Additional Info',
                            onPressed: viewModel.addAdditionalInfo,
                            color: AppColors.primaryColor,
                          ),
                          verticalSpace(30),
                        ],
                      ),
                    ),

                    // Display the List of Additional Info
                    if (viewModel.additionalInfoList.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Added Additional Info:',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          verticalSpace(10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: viewModel.additionalInfoList.length,
                            itemBuilder: (context, index) {
                              final additionalInfo = viewModel.additionalInfoList[index];

                              return Card(
                                margin: EdgeInsets.only(bottom: 10.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: AppColors.primaryColor, width: 1),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hobbies and Interests: ${additionalInfo.hobbiesAndInterests}',
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                      verticalSpace(5),
                                      Text(
                                        'Publications: ${additionalInfo.publications}',
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                      verticalSpace(5),
                                      Text(
                                        'Awards and Honors: ${additionalInfo.awardsAndHonors}',
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                      verticalSpace(5),
                                      Text(
                                        'Volunteer Work: ${additionalInfo.volunteerWork?.description} (${additionalInfo.volunteerWork?.month} ${additionalInfo.volunteerWork?.year})',
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                      verticalSpace(10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.red),
                                            onPressed: () {
                                              final scaffoldMessenger = ScaffoldMessenger
                                                  .maybeOf(context);
                                              if (scaffoldMessenger == null) {
                                                debugPrint(
                                                    'ScaffoldMessenger not found.');
                                                return;
                                              }
                                            }
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                    // NEXT Button
                    CustomAuthButton(
                      text: 'NEXT',
                      onPressed: viewModel.additionalInfoList.isNotEmpty
                          ? () {
                        // Navigate to the next screen
                      }
                          : null,
                      color: viewModel.additionalInfoList.isNotEmpty
                          ? AppColors.primaryColor
                          : const Color(0xFF5C6673),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}