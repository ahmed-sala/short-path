import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/src/domain/entities/user_info/work_experience_entity.dart';
import 'package:short_path/src/presentation/mangers/user_info/work_experience/work_experience_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/work_experience/work_experience_viewmodel.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';

class WorkExperienceScreen extends StatelessWidget {
  const WorkExperienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkExperienceViewModel(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Work Experience')),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
            child: BlocConsumer<WorkExperienceViewModel, WorkExperienceState>(
              listener: (context, state) {
                if (state is WorkExperienceError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red),
                  );
                }
              },
              builder: (context, state) {
                final viewModel = context.read<WorkExperienceViewModel>();
                final dateError = viewModel.validateDates();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: viewModel.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            controller: viewModel.jobTitleController,
                            labelText: 'Job Title',
                            hintText: 'Enter Job Title',
                            validator: viewModel.validateJobTitle,
                            keyboardType: TextInputType.text,
                          ),
                          verticalSpace(20),

                          CustomTextFormField(
                            controller: viewModel.companyNameController,
                            labelText: 'Company Name',
                            hintText: 'Enter Company Name',
                            validator: viewModel.validateCompanyName,
                            keyboardType: TextInputType.text,
                          ),
                          verticalSpace(20),

                          CustomTextFormField(
                            controller: viewModel.companyFieldController,
                            labelText: 'Company Field',
                            hintText: 'Enter Company Field',
                            validator: viewModel.validateCompanyField,
                            keyboardType: TextInputType.text,
                          ),
                          verticalSpace(20),

                          CustomTextFormField(
                            controller: viewModel.jobTypeController,
                            labelText: 'Job Type',
                            hintText: 'Enter Job Type',
                            validator: viewModel.validateJobType,
                            keyboardType: TextInputType.text,
                          ),
                          verticalSpace(20),

                          CustomTextFormField(
                            controller: viewModel.jobLocationController,
                            labelText: 'Job Location',
                            hintText: 'Enter Job Location',
                            validator: viewModel.validateJobLocation,
                            keyboardType: TextInputType.text,
                          ),
                          verticalSpace(20),

                          // Start Date Picker
                          GestureDetector(
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2030),
                              );
                              if (pickedDate != null)
                                viewModel.selectStartDate(pickedDate);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 70.h,
                              padding: EdgeInsets.only(top: 20.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F4F4),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Start Date',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  viewModel.startDate != null
                                      ? DateFormat('M/d/yyyy')
                                          .format(viewModel.startDate!)
                                      : 'Select Date',
                                  style: TextStyle(
                                    color: viewModel.startDate == null
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (dateError != null && viewModel.startDate == null)
                            Padding(
                              padding: EdgeInsets.only(left: 12.w, top: 4.h),
                              child: Text(
                                dateError,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12.sp),
                              ),
                            ),
                          verticalSpace(20),

                          // End Date Picker
                          GestureDetector(
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2030),
                              );
                              if (pickedDate != null)
                                viewModel.selectEndDate(pickedDate);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 70.h,
                              padding: EdgeInsets.only(top: 20.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F4F4),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'End Date',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  viewModel.endDate != null
                                      ? DateFormat('M/d/yyyy')
                                          .format(viewModel.endDate!)
                                      : 'Select Date',
                                  style: TextStyle(
                                    color: viewModel.endDate == null
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (dateError != null && viewModel.endDate == null)
                            Padding(
                              padding: EdgeInsets.only(left: 12.w, top: 4.h),
                              child: Text(
                                dateError,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12.sp),
                              ),
                            ),
                          verticalSpace(20),

                          CustomTextFormField(
                            controller: viewModel.summaryController,
                            labelText: 'Job Summary',
                            hintText: 'Enter Job Summary',
                            validator: viewModel.validateSummary,
                            keyboardType: TextInputType.text,
                          ),
                          verticalSpace(20),

                          // Tool/Technology
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  controller: viewModel.toolController,
                                  labelText: 'Tool/Technology',
                                  hintText: 'Enter Tool/Technology',
                                  validator: (value) =>
                                      viewModel.toolsTechnologiesUsed.isEmpty
                                          ? 'Add at least one tool'
                                          : null,
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add,
                                    color: AppColors.primaryColor),
                                onPressed: viewModel.addTool,
                              ),
                            ],
                          ),
                          Wrap(
                            spacing: 8,
                            children: viewModel.toolsTechnologiesUsed
                                .map((tool) => Chip(
                                      label: Text(tool),
                                      deleteIcon: Icon(Icons.close, size: 16),
                                      onDeleted: () =>
                                          viewModel.removeTool(tool),
                                    ))
                                .toList(),
                          ),
                          verticalSpace(20),

                          CustomAuthButton(
                            text: 'Add Work Experience',
                            onPressed: viewModel.addWorkExperience,
                            color: AppColors.primaryColor,
                          ),
                          verticalSpace(30),
                        ],
                      ),
                    ),

                    // Added Experiences List
                    if (viewModel.workExperiences.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Added Work Experiences:',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          verticalSpace(10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: viewModel.workExperiences.length,
                            itemBuilder: (context, index) {
                              final exp = viewModel.workExperiences[index];
                              return Card(
                                margin: EdgeInsets.only(bottom: 10.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: AppColors.primaryColor, width: 1),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        exp.jobTitle,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      verticalSpace(5),
                                      Text('Company: ${exp.companyName}'),
                                      verticalSpace(5),
                                      Text('Field: ${exp.companyField}'),
                                      verticalSpace(5),
                                      Text('Type: ${exp.jobType}'),
                                      verticalSpace(5),
                                      Text('Location: ${exp.jobLocation}'),
                                      verticalSpace(5),
                                      Text(
                                          'Dates: ${exp.startDate} - ${exp.endDate}'),
                                      verticalSpace(5),
                                      Text('Summary: ${exp.summary}'),
                                      verticalSpace(5),
                                      if (exp.toolsTechnologiesUsed.isNotEmpty)
                                        Wrap(
                                          spacing: 8,
                                          children: exp.toolsTechnologiesUsed
                                              .map((tool) =>
                                                  Chip(label: Text(tool)))
                                              .toList(),
                                        ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () {
                                            final scaffoldMessenger =
                                                ScaffoldMessenger.of(context);
                                            scaffoldMessenger
                                                .hideCurrentSnackBar();
                                            viewModel.removeWorkExperience(exp);

                                            scaffoldMessenger.showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    '${exp.jobTitle} removed!'),
                                                backgroundColor: Colors.red,
                                                action: SnackBarAction(
                                                  label: 'Undo',
                                                  onPressed: () {
                                                    scaffoldMessenger
                                                        .hideCurrentSnackBar();
                                                    viewModel
                                                        .addWorkExperienceBack(
                                                            exp);
                                                    scaffoldMessenger
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            '${exp.jobTitle} restored!'),
                                                        backgroundColor:
                                                            Colors.green,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
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
                      onPressed:
                          viewModel.workExperiences.isNotEmpty ? () {} : null,
                      color: viewModel.workExperiences.isNotEmpty
                          ? AppColors.primaryColor
                          : Color(0xFF5C6673),
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
