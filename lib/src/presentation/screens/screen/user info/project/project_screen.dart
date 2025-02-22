import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/dialogs/awesome_dialoge.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/project/project_list.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_drop_downButton_form_field.dart';

import '../../../../../../core/dialogs/show_hide_loading.dart';
import '../../../../../short_path.dart';
import '../../../../mangers/infromation_gathering/Project/Project_State.dart';
import '../../../../mangers/infromation_gathering/Project/Project_Viewmodel.dart';
import '../../../../shared_widgets/custom_auth_button.dart';
import '../../../../shared_widgets/custom_auth_text_feild.dart';
import '../../../widgets/user info/profile/suggestion_list.dart';
import '../../../widgets/user info/project/ToolList.dart';

class ProjectScreen extends StatelessWidget {
  ProjectScreen({super.key});
  ProjectViewmodel viewModel = getIt<ProjectViewmodel>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Projects'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
            child: BlocConsumer<ProjectViewmodel, ProjectState>(
              listener: (context, state) {
                if (state is AddProjectFailure) {
                  showAwesomeDialog(context,
                      title: 'Error',
                      desc: state.error,
                      onOk: () {},
                      dialogType: DialogType.error);
                } else if (state is AddProjectSuccess) {
                  navKey.currentState!.pushNamedAndRemoveUntil(
                      RoutesName.certification, (route) => false);
                } else if (state is AddProjectLoading) {
                  showLoading(context, 'Adding Projects');
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: viewModel.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            hintText: 'Enter Project Title',
                            keyboardType: TextInputType.text,
                            controller: viewModel.projectTitleController,
                            labelText: 'Project Title',
                            validator: viewModel.validateProjectTitle,
                          ),
                          verticalSpace(20),
                          CustomDropdownButtonFormField(
                            labelText: 'Role',
                            hintText: 'Select Role',
                            value: viewModel.roleController.text.isEmpty
                                ? null
                                : viewModel.roleController.text,
                            items: ['Full-time', 'Part-time', 'Freelance']
                                .map(
                                  (jobLocation) => DropdownMenuItem(
                                value: jobLocation,
                                child: Text(jobLocation),
                              ),
                            )
                                .toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                viewModel.roleController.text = newValue;
                              }
                            },
                            validator: viewModel.validateRole,
                          ),
                          verticalSpace(20),
                          CustomTextFormField(
                            hintText: 'Enter Project Link',
                            keyboardType: TextInputType.text,
                            controller: viewModel.projectLinkController,
                            labelText: 'Project Link',
                            validator: viewModel.validateProjectLink,
                          ),
                          verticalSpace(20),
                          CustomTextFormField(
                            hintText: 'Enter Description',
                            keyboardType: TextInputType.multiline,
                            controller: viewModel.descriptionController,
                            labelText: 'Description',
                            validator: viewModel.validateDescription,
                          ),
                          verticalSpace(20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 4,
                                child: CustomTextFormField(
                                  hintText: 'Enter Tools/Technologies Used',
                                  keyboardType: TextInputType.text,
                                  controller:
                                  viewModel.technologiesUsedController,
                                  labelText: 'Tools/Technologies Used',
                                  validator: (value) => null,
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      viewModel.addToolsTechnologies(
                                        viewModel
                                            .technologiesUsedController.text,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (viewModel.filteredToolSuggestions.isNotEmpty &&
                              viewModel.technologiesUsedController.text
                                  .isNotEmpty) // Ensure the text field is not empty
                            SuggestionList(
                              suggestions: viewModel.filteredToolSuggestions,
                              onTap: viewModel.selectTool,
                            ),
                          verticalSpace(20),
                          if (viewModel.toolsTechnologies.isNotEmpty) ...[
                            ToolList(),
                            verticalSpace(20),
                          ],
                          verticalSpace(20),
                          CustomAuthButton(
                            text: 'Add Project',
                            onPressed: viewModel.addProject,
                            color: AppColors.primaryColor,
                          ),
                          verticalSpace(30),
                        ],
                      ),
                    ),
                    if (viewModel.projects.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Added Projects:',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          verticalSpace(10),
                          ProjectList(
                            viewModel: viewModel,
                          ),
                        ],
                      ),
                    CustomAuthButton(
                      text: 'NEXT',
                      onPressed: viewModel.projects.isNotEmpty
                          ? () {
                        context.read<ProjectViewmodel>().next();
                      }
                          : null,
                      color: viewModel.projects.isNotEmpty
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