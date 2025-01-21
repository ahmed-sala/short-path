import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:short_path/core/dialogs/awesome_dialoge.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/images/app_images.dart';
import 'package:short_path/src/presentation/mangers/auth/register/register_states.dart';

import '../../../../../../config/helpers/validations.dart';
import '../../../../../../config/routes/routes_name.dart';
import '../../../../../../core/dialogs/show_hide_loading.dart';
import '../../../../../../dependency_injection/di.dart';
import '../../../../../core/styles/spacing.dart';
import '../../../../short_path.dart';
import '../../../mangers/auth/register/register_actions.dart';
import '../../../mangers/auth/register/register_viewmodel.dart';
import '../../../shared_widgets/custom_auth_button.dart';
import '../../../shared_widgets/custom_auth_text_feild.dart';
import '../../widgets/auth/no_account_row.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterViewModel registerViewModel = getIt<RegisterViewModel>();
  bool passwordVisible = true;
  String selectedGender = "Male";
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
            ),
          ),
          // Positioned logo
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Hero(
                tag: 'logo',
                child: Image.asset(
                  AppImages.logo,
                  width: 250.w,
                  height: 250.h,
                ),
              ),
            ),
          ),

          // Register Form
          BlocProvider(
            create: (context) => registerViewModel,
            child: BlocConsumer<RegisterViewModel, RegisterScreenState>(
              buildWhen: (previous, current) {
                return current is InitialState ||
                    current is ValidateColorButtonState;
              },
              listenWhen: (previous, current) {
                if (previous is LoadingState || current is ErrorState) {
                  hideLoading();
                }
                return current is! InitialState;
              },
              listener: (context, state) {
                switch (state) {
                  case LoadingState():
                    showLoading(context, 'Registering...');
                  case ErrorState():
                    showAwesomeDialog(context,
                        title: 'error',
                        desc: state.exception!,
                        onOk: () {},
                        dialogType: DialogType.error);
                  case SuccessState():
                    navKey.currentState!.pushReplacementNamed(RoutesName.home);
                  default:
                }
              },
              builder: (context, state) {
                if (state is InitialState ||
                    state is ValidateColorButtonState) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.3),
                      child: Form(
                        key: registerViewModel.formKey,
                        onChanged: () => registerViewModel
                            .doAction(ValidateColorButtonAction()),
                        child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.w, vertical: 40.h),
                            child: Column(
                              children: [
                                Text(
                                  'Create an Account',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                verticalSpace(10),
                                Text(
                                  'Fill the form to register',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                ),
                                verticalSpace(30),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextFormField(
                                        hintText: 'Enter your first name',
                                        controller: registerViewModel
                                            .firstNameController,
                                        labelText: 'First Name',
                                        validator: (val) =>
                                            Validations.validateName(val),
                                        keyboardType: TextInputType.name,
                                      ),
                                    ),
                                    horizontalSpace(20),
                                    Expanded(
                                      child: CustomTextFormField(
                                        hintText: 'Enter your last name',
                                        controller: registerViewModel
                                            .lastNameController,
                                        labelText: 'Last Name',
                                        validator: (val) =>
                                            Validations.validateName(val),
                                        keyboardType: TextInputType.name,
                                      ),
                                    ),
                                  ],
                                ),
                                verticalSpace(20),
                                CustomTextFormField(
                                  hintText: 'Enter your email',
                                  keyboardType: TextInputType.emailAddress,
                                  controller: registerViewModel.emailController,
                                  labelText: 'Email Address',
                                  validator: (val) =>
                                      Validations.validateEmail(val),
                                ),
                                verticalSpace(20),
                                CustomTextFormField(
                                  isPasswordVisible: passwordVisible,
                                  showPassword: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                  hintText: 'Enter your password',
                                  keyboardType: TextInputType.visiblePassword,
                                  controller:
                                      registerViewModel.passwordController,
                                  labelText: 'Password',
                                  validator: (val) =>
                                      Validations.validatePassword(val),
                                ),
                                verticalSpace(20),
                                CustomTextFormField(
                                  hintText: 'Re-enter your password',
                                  isPasswordVisible:
                                      registerViewModel.isRePasswordVisible,
                                  showPassword: () {
                                    setState(() {
                                      registerViewModel.isRePasswordVisible =
                                          !registerViewModel
                                              .isRePasswordVisible;
                                    });
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  controller:
                                      registerViewModel.rePasswordController,
                                  labelText: 'Confirm Password',
                                  validator: (val) =>
                                      Validations.validateConfirmPassword(
                                          val,
                                          registerViewModel
                                              .passwordController.text),
                                ),
                                verticalSpace(20),
                                CustomTextFormField(
                                  hintText: 'Enter your phone number',
                                  keyboardType: TextInputType.phone,
                                  controller: registerViewModel.phoneController,
                                  labelText: 'Phone Number',
                                  validator: (val) =>
                                      Validations.validatePhoneNumber(val),
                                ),
                                verticalSpace(20),
                                CustomTextFormField(
                                  hintText: 'Enter your Address',
                                  keyboardType: TextInputType.text,
                                  controller:
                                      registerViewModel.addressController,
                                  labelText: 'Address',
                                  validator: (val) =>
                                      Validations.validateAddress(val),
                                ),
                                verticalSpace(20),
                                GestureDetector(
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                    );
                                    if (pickedDate != null) {
                                      // Ensure this method is called
                                      registerViewModel
                                          .updateSelectedDate(pickedDate);
                                    }
                                  },
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'Birthdate',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      registerViewModel.selectedDate != null
                                          ? DateFormat('M/d/yyyy').format(
                                              registerViewModel.selectedDate!)
                                          : 'Select Date',
                                      style: TextStyle(
                                          color:
                                              registerViewModel.selectedDate ==
                                                      null
                                                  ? Colors.grey
                                                  : Colors.black),
                                    ),
                                  ),
                                ),
                                verticalSpace(20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Gender'),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedGender = 'Male';
                                              });
                                            },
                                            child: ListTile(
                                              title: const Text('Male'),
                                              leading: Radio<String>(
                                                value: 'Male',
                                                groupValue: selectedGender,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedGender = value!;
                                                  });
                                                },
                                                activeColor: AppColors
                                                    .primaryColor, // Set the color here
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedGender = 'Female';
                                              });
                                            },
                                            child: ListTile(
                                              title: const Text('Female'),
                                              leading: Radio<String>(
                                                value: 'Female',
                                                groupValue: selectedGender,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedGender = value!;
                                                  });
                                                },
                                                activeColor: AppColors
                                                    .primaryColor, // Set the color here
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                CustomAuthButton(
                                  text: 'REGISTER',
                                  onPressed: registerViewModel.validate
                                      ? () => registerViewModel
                                          .doAction(RegisterAction())
                                      : null,
                                  color: registerViewModel.validate
                                      ? AppColors.primaryColor
                                      : const Color(0xFF5C6673),
                                ),
                                const SizedBox(height: 20),
                                NoAccountRow(
                                  content: 'Already have an account?',
                                  actionText: 'Login here',
                                  onPressed: () {
                                    navKey.currentState!
                                        .pushReplacementNamed(RoutesName.login);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
