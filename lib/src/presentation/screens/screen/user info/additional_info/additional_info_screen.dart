import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/dialogs/awesome_dialoge.dart';
import 'package:short_path/core/dialogs/show_hide_loading.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/domain/entities/user_info/additional_info_entity.dart';
import 'package:short_path/src/presentation/mangers/user_info/additional_info/additional_info_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/additional_info/additional_info_viewmodel.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/additional_info/awards_list.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/additional_info/hobbies_list.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/additional_info/publication_list.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/additional_info/volanteer_list.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';
import 'package:short_path/src/short_path.dart';

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
          child: ConstrainedBox(
            constraints: BoxConstraints(
              // Ensures that the child takes at least the full height of the viewport.
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
              child: BlocConsumer<AdditionalInfoViewmodel, AdditionalInfoState>(
                listener: (context, state) {
                  if (state is AddAdditionalInfoLoading) {
                    showLoading(context, 'Adding additional info');
                  } else if (state is AdditionalInfoSuccess) {
                    navKey.currentState!.pushNamedAndRemoveUntil(
                        RoutesName.home, (route) => false);
                  } else if (state is AdditionalInfoError) {
                    showAwesomeDialog(context,
                        title: 'Error',
                        desc: state.message,
                        onOk: () {},
                        dialogType: DialogType.error);
                  } else if (state is ExpiredToken) {
                    showAwesomeDialog(context,
                        title: 'Error', desc: 'Session expired', onOk: () {
                      navKey.currentState!.pushNamedAndRemoveUntil(
                          RoutesName.login, (route) => false);
                    }, dialogType: DialogType.error);
                  }
                },
                listenWhen: (previous, current) {
                  if (previous is AddAdditionalInfoLoading ||
                      current is AdditionalInfoError) {
                    hideLoading();
                  }
                  return current is! AdditionalInfoInitialState;
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
                      // ... your Form and other widgets ...
                      Form(
                        key: viewModel.formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        onChanged: viewModel.validateColorButton,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Hobbies input row
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: CustomTextFormField(
                                    hintText: 'Enter Hobbies and Interests',
                                    keyboardType: TextInputType.text,
                                    controller:
                                        viewModel.hobbiesAndInterestsController,
                                    labelText: 'Hobbies and Interests',
                                    validator: (value) => null,
                                  ),
                                ),
                                SizedBox(
                                  width: 50, // Adjust width as needed
                                  child: Center(
                                    child: IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        viewModel.addHobbiesAndInterests(
                                          viewModel
                                              .hobbiesAndInterestsController
                                              .text,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (viewModel.hobbiesList.isNotEmpty) ...[
                              verticalSpace(20),
                              HobbiesList(),
                            ],
                            verticalSpace(20),
                            // Publications input row
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: CustomTextFormField(
                                    hintText: 'Enter Publications',
                                    keyboardType: TextInputType.text,
                                    controller:
                                        viewModel.publicationsController,
                                    labelText: 'Publications',
                                    validator: (value) => null,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                  child: Center(
                                    child: IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        viewModel.addPublications(
                                          viewModel.publicationsController.text,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (viewModel.publicationsList.isNotEmpty) ...[
                              verticalSpace(20),
                              PublicationList(),
                            ],
                            verticalSpace(20),
                            // Awards input row
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: CustomTextFormField(
                                    hintText: 'Enter Awards and Honors',
                                    keyboardType: TextInputType.text,
                                    controller:
                                        viewModel.awardsAndHonorsController,
                                    labelText: 'Awards and Honors',
                                    validator: (value) => null,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                  child: Center(
                                    child: IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        viewModel.addAwardsAndHonors(
                                          viewModel
                                              .awardsAndHonorsController.text,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (viewModel.awardsList.isNotEmpty) ...[
                              verticalSpace(20),
                              AwardsList(),
                            ],
                            verticalSpace(20),
                            // Volunteer work description input
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    hintText:
                                        'Enter Volunteer Work Description',
                                    keyboardType: TextInputType.text,
                                    controller: viewModel
                                        .volunteerWorkDescriptionController,
                                    labelText: 'Volunteer Work Description',
                                    validator: (value) => null,
                                  ),
                                ),
                              ],
                            ),
                            verticalSpace(20),
                            // Month and Year selection
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    labelText: 'No. years',
                                    hintText: '',
                                    keyboardType: TextInputType.number,
                                    controller: viewModel.noOfYearsController,
                                    validator: (value) => null,
                                  ),
                                ),
                                horizontalSpace(20),
                                Expanded(
                                  child: CustomTextFormField(
                                    labelText: 'No. months',
                                    hintText: '',
                                    keyboardType: TextInputType.number,
                                    controller: viewModel.noOfMonthsController,
                                    validator: (value) => null,
                                  ),
                                ),
                              ],
                            ),
                            verticalSpace(20),
                            // Button for adding volunteer work
                            CustomAuthButton(
                              text: 'Add volunteer work',
                              onPressed: () {
                                viewModel.addVolunteerWork(
                                  VolunteerWorkEntity(
                                    description: viewModel
                                        .volunteerWorkDescriptionController
                                        .text,
                                    month: int.parse(
                                        viewModel.noOfMonthsController.text),
                                    year: int.parse(
                                        viewModel.noOfYearsController.text),
                                  ),
                                );
                              },
                              color: AppColors.primaryColor,
                            ),
                            verticalSpace(20),
                            if (viewModel.volunteerWorkList.isNotEmpty) ...[
                              verticalSpace(20),
                              VolanteerList(),
                            ],
                          ],
                        ),
                      ),
                      // NEXT button
                      CustomAuthButton(
                        text: 'NEXT',
                        onPressed: () {
                          viewModel.submitAdditionalInfo();
                        },
                        color: AppColors.primaryColor,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
