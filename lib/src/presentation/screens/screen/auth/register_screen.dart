import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:short_path/core/dialogs/awesome_dialoge.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/images/app_images.dart';

import '../../../../../../config/helpers/validations.dart';
import '../../../../../../config/routes/routes_name.dart';
import '../../../../../../core/dialogs/show_hide_loading.dart';
import '../../../../../../dependency_injection/di.dart';
import '../../../../../core/styles/spacing.dart';
import '../../../../short_path.dart';
import '../../../mangers/auth/register/register_actions.dart';
import '../../../mangers/auth/register/register_states.dart';
import '../../../mangers/auth/register/register_viewmodel.dart';
import '../../../shared_widgets/custom_auth_button.dart';
import '../../../shared_widgets/custom_auth_text_feild.dart';
import '../../widgets/auth/no_account_row.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState(

  );
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  late AnimationController _stepController;
  late Animation<double> _stepFadeAnimation;
  late Animation<Offset> _stepSlideAnimation;

  final RegisterViewModel registerViewModel = getIt<RegisterViewModel>();
  bool passwordVisible = true;
  int currentStep = 0;
  String selectedGender = '';

  late AnimationController _logoController;
  late AnimationController _formController;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoRotationAnimation;
  late Animation<Offset> _formSlideAnimation;
  late Animation<double> _formFadeAnimation;

  @override
  void initState() {


    super.initState();
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _formController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeIn,
      ),
    );

    _logoRotationAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.elasticOut,
      ),
    );

    _formSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _formController,
        curve: Curves.decelerate,
      ),
    );

    _formFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _formController,
        curve: Curves.easeIn,
      ),
    );

    _logoController.forward().whenComplete(() => _formController.forward());
  }

  @override
  void dispose() {
    _logoController.dispose();
    _formController.dispose();
    super.dispose();
  }

  void nextStep() {
    if (currentStep < 1) {
      setState(() => currentStep++);
    } else {
      registerViewModel.doAction(RegisterAction());
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);
    }
  }

  Widget buildProgressBar() {
    double progressValue = (currentStep + 1) / 2;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white.withOpacity(0.4), Colors.white.withOpacity(0.1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: progressValue),
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOutBack,
                builder: (context, value, _) => Stack(
                  children: [
                    FractionallySizedBox(
                      widthFactor: value,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF00C6FF), Color(0xFF0072FF), Color(0xFF5B247A)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00C6FF).withOpacity(0.6),
                              blurRadius: 20,
                              spreadRadius: 1,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.5),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.star,
                          color: Color(0xFF1976D2),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: progressValue * 100),
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) => Text(
              '${value.toStringAsFixed(0)}%',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 16,
                letterSpacing: 1.2,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.black38,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget buildStepOne() {
    return Column(
      children: [
    Row(
    children: [
    Expanded(
    child: CustomTextFormField(
      hintText: 'First name',
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
    hintText: 'Last name',
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
    hintText: 'Email',
    keyboardType: TextInputType.emailAddress,
    controller:
    registerViewModel.emailController,
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
    hintText: 'Password',
    keyboardType:
    TextInputType.visiblePassword,
    controller:
    registerViewModel.passwordController,
    labelText: 'Password',
    validator: (val) =>
    Validations.validatePassword(val),
    ),
    verticalSpace(20),
    CustomTextFormField(
    hintText: 'Confirm Password',
    isPasswordVisible: registerViewModel
        .isRePasswordVisible,
    showPassword: () {
    setState(() {
    registerViewModel.isRePasswordVisible =
    !registerViewModel
        .isRePasswordVisible;
    });
    },
    keyboardType:
    TextInputType.visiblePassword,
    controller: registerViewModel
        .rePasswordController,
    labelText: 'Confirm Password',
    validator: (val) =>
    Validations.validateConfirmPassword(
    val,
    registerViewModel
        .passwordController.text),
    ),
        verticalSpace(20),
        CustomAuthButton(
          text: 'NEXT',
          onPressed: nextStep,
          color: const Color(0xFF102027),
        ),
      ],
    );
  }

  Widget buildStepTwo() {
    return Column(
      children: [
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
        verticalSpace(5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      title: const Text('Female',style: TextStyle(fontSize: 13),),
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
        verticalSpace(20),
        Row(
          children: [
            Expanded(
              child: CustomAuthButton(
                text: 'BACK',
                onPressed: previousStep,
                color:const Color(0xFF102027),
              ),
            ),
            horizontalSpace(20),
            Expanded(
              child: CustomAuthButton(
                text: 'REGISTER',
                onPressed: registerViewModel.validate ? nextStep : null,
                color: registerViewModel.validate
                    ? const Color(0xFF102027)
                    : const Color(0xFFB0BC5),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1A237E),
                  Color(0xFF283593),
                  Color(0xFF1976D2),
                  Color(0xFF64B5F6),
                ],
                stops: [0.1, 0.4, 0.7, 1.0],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Hero(
                tag: 'logo',
                child: FadeTransition(
                  opacity: _logoFadeAnimation,
                  child: RotationTransition(
                    turns: _logoRotationAnimation,
                    child: Image.asset(
                      AppImages.logo,
                      width: 280.w,
                      height: 280.h,
                    ),
                  ),
                ),
              ),
            ),
          ),
          FadeTransition(
            opacity: _formFadeAnimation,
            child: SlideTransition(
              position: _formSlideAnimation,
              child: BlocProvider(
                create: (context) => registerViewModel,
                child: BlocConsumer<RegisterViewModel, RegisterScreenState>(
                  buildWhen: (previous, current) =>
                  current is InitialState ||
                      current is ValidateColorButtonState,
                  listenWhen: (previous, current) => current is! InitialState,
                  listener: (context, state) {
                    switch (state) {
                      case LoadingState():
                        showLoading(context, 'Registering...');
                      case ErrorState():
                        hideLoading();
                        showAwesomeDialog(
                          context,
                          title: 'Error',
                          desc: state.exception!,
                          onOk: () {},
                          dialogType: DialogType.error,
                        );
                      case SuccessState():
                        hideLoading();
                        navKey.currentState!
                            .pushReplacementNamed(RoutesName.login);
                      default:
                    }
                  },
                  builder: (context, state) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height *0.35),
                        child: Form(
                          key: registerViewModel.formKey,
                          child: Card(
                            elevation: 30,
                            shadowColor: Colors.black45,
                            color: const Color(0xFFFFFFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.w, vertical: 20.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Create an Account',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF102027),
                                    ),
                                  ),
                                  verticalSpace(10),
                                  buildProgressBar(),
                                  verticalSpace(15),
                                  currentStep == 0
                                      ? buildStepOne()
                                      : buildStepTwo(),
                                  verticalSpace(20),
                                  NoAccountRow(
                                    content: 'Already have an account?',
                                    actionText: 'Login here',
                                    onPressed: () {
                                      navKey.currentState!
                                          .pushReplacementNamed(
                                          RoutesName.login);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
