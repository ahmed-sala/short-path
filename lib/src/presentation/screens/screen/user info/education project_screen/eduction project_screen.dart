// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:short_path/config/routes/routes_name.dart';
// import 'package:short_path/core/styles/colors/app_colore.dart';
// import 'package:short_path/core/styles/spacing.dart';
// import 'package:short_path/dependency_injection/di.dart';
// import '../../../../../short_path.dart';
// import '../../../../mangers/infromation_gathering/EducationProject/EducationProjectState.dart';
// import '../../../../mangers/infromation_gathering/EducationProject/EducationProjectViewmodel.dart';
// import '../../../../shared_widgets/custom_auth_button.dart';
// import '../../../../shared_widgets/custom_auth_text_feild.dart';
//
// class EducationProjectScreen extends StatelessWidget {
//   const EducationProjectScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     EducationProjectViewmodel viewModel = getIt.get<EducationProjectViewmodel>();
//     return BlocProvider(
//       create: (context) => viewModel,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Education Projects'),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
//             child: BlocConsumer<EducationProjectViewmodel, EducationProjectState>(
//               listener: (context, state) {
//                 if (state is EducationProjectUpdated) {
//                 }
//               },
//               buildWhen: (previous, current) =>
//               current is EducationProjectInitialState ||
//                   current is ValidateColorButtonState ||
//                   current is EducationProjectUpdated,
//               builder: (context, state) {
//                 final viewModel = context.read<EducationProjectViewmodel>();
//
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Form for Adding Project
//                     Form(
//                       key: viewModel.formKey,
//                       onChanged: viewModel.validateColorButton,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CustomTextFormField(
//                             hintText: 'Enter Project Name',
//                             keyboardType: TextInputType.text,
//                             controller: viewModel.projectNameController,
//                             labelText: 'Project Name',
//                             validator: viewModel.validateProjectName,
//                           ),
//                           verticalSpace(20),
//                           CustomTextFormField(
//                             hintText: 'Enter Project Description',
//                             keyboardType: TextInputType.multiline,
//                             controller: viewModel.projectDescriptionController,
//                             labelText: 'Project Description',
//                             validator: viewModel.validateProjectDescription,
//                           ),
//                           verticalSpace(20),
//                           CustomTextFormField(
//                             hintText: 'Enter Project Link',
//                             keyboardType: TextInputType.url,
//                             controller: viewModel.projectLinkController,
//                             labelText: 'Project Link',
//                             validator: viewModel.validateProjectLink,
//                           ),
//                           verticalSpace(20),
//                           CustomTextFormField(
//                             hintText: 'Enter Tools/Technologies Used',
//                             keyboardType: TextInputType.text,
//                             controller: viewModel.toolsTechnologiesController,
//                             labelText: 'Tools/Technologies Used',
//                             validator: viewModel.validateToolsTechnologies,
//                           ),
//                           verticalSpace(20),
//                           CustomAuthButton(
//                             text: 'Add Project',
//                             onPressed: viewModel.addProject,
//                             color: AppColors.primaryColor,
//                           ),
//                           verticalSpace(30),
//                         ],
//                       ),
//                     ),
//
//                     // Display the List of Projects
//                     if (viewModel.projects.isNotEmpty)
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Added Projects:',
//                             style: TextStyle(
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           verticalSpace(10),
//                           ListView.builder(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: viewModel.projects.length,
//                             itemBuilder: (context, index) {
//                               final project = viewModel.projects[index];
//
//                               return Card(
//                                 margin: EdgeInsets.only(bottom: 10.h),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   side: BorderSide(color: AppColors.primaryColor, width: 1),
//                                 ),
//                                 child: Padding(
//                                   padding: EdgeInsets.all(12.w),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         project.projectName,
//                                         style: TextStyle(
//                                           fontSize: 16.sp,
//                                           fontWeight: FontWeight.bold,
//                                           color: AppColors.primaryColor,
//                                         ),
//                                       ),
//                                       verticalSpace(5),
//                                       Text(
//                                         project.projectDescription,
//                                         style: TextStyle(fontSize: 14.sp),
//                                       ),
//                                       verticalSpace(5),
//                                       Text(
//                                         'Link: ${project.projectLink}',
//                                         style: TextStyle(
//                                           fontSize: 14.sp,
//                                           color: Colors.blue,
//                                           decoration: TextDecoration.underline,
//                                         ),
//                                       ),
//                                       verticalSpace(5),
//                                       Text(
//                                         'Tools: ${project.toolsTechnologies}',
//                                         style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
//                                       ),
//                                       verticalSpace(10),
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.end,
//                                         children: [
//                                           IconButton(
//                                             icon: const Icon(Icons.delete, color: Colors.red),
//                                             onPressed: () {
//                                               final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
//                                               if (scaffoldMessenger == null) {
//                                                 debugPrint('ScaffoldMessenger not found.');
//                                                 return;
//                                               }
//
//                                               scaffoldMessenger.hideCurrentSnackBar();
//                                               viewModel.removeProject(project);
//
//                                               scaffoldMessenger.showSnackBar(
//                                                 SnackBar(
//                                                   content: Text('${project.projectName} removed!'),
//                                                   backgroundColor: Colors.red,
//                                                   action: SnackBarAction(
//                                                     label: 'Undo',
//                                                     onPressed: () {
//                                                       scaffoldMessenger.hideCurrentSnackBar();
//                                                       viewModel.addProjectBack(project);
//                                                       scaffoldMessenger.showSnackBar(
//                                                         SnackBar(
//                                                           content: Text('${project.projectName} restored!'),
//                                                           backgroundColor: Colors.green,
//                                                         ),
//                                                       );
//                                                     },
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//
//                     // NEXT Button
//                     CustomAuthButton(
//                       text: 'NEXT',
//                       onPressed: viewModel.projects.isNotEmpty
//                           ? () {
//                         navKey.currentState!.pushReplacementNamed(RoutesName.project);
//                       }
//                           : null,
//                       color: viewModel.projects.isNotEmpty
//                           ? AppColors.primaryColor
//                           : const Color(0xFF5C6673),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
