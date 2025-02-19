import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/core/dialogs/awesome_dialoge.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/images/app_images.dart';

import '../../../../../../config/helpers/validations.dart';
import '../../../../../../config/routes/routes_name.dart';
import '../../../../../../core/dialogs/show_hide_loading.dart';
import '../../../../../../dependency_injection/di.dart';
import '../../../../../core/styles/spacing.dart';
import '../../../../short_path.dart';
import '../../../mangers/auth/login/login_actions.dart';
import '../../../mangers/auth/login/login_states.dart';
import '../../../mangers/auth/login/login_viewmodel.dart';
import '../../../shared_widgets/custom_auth_button.dart';
import '../../../shared_widgets/custom_auth_text_feild.dart';
import '../../widgets/auth/no_account_row.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final LoginViewModel loginViewModel = getIt<LoginViewModel>();
  bool passwordVisible = true;
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
                  Color(0xFF1A237E), // Deep Indigo Blue
                  Color(0xFF283593), // Dark Baby Blue
                  Color(0xFF1976D2), // Royal Blue Accent
                  Color(0xFF64B5F6), // Soft Sky Blue
                ],
                stops: [0.1, 0.4, 0.7, 1.0], // Smooth transition between colors
              ),
            ),
          ),


          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 70),
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
                create: (context) => loginViewModel,
                child: BlocConsumer<LoginViewModel, LoginScreenState>(
                  buildWhen: (previous, current) =>
                  current is InitialState || current is ValidateColorButtonState,
                  listenWhen: (previous, current) => current is! InitialState,
                  listener: (context, state) {
                    switch (state) {
                      case LoadingState():
                        showLoading(context, 'Logging in...');
                      case ErrorState():
                        hideLoading();
                        showAwesomeDialog(
                          context,
                          title: 'Error',
                          desc: state.exception,
                          onOk: () {},
                          dialogType: DialogType.error,
                        );
                      case SuccessState():
                        hideLoading();
                        navKey.currentState!
                            .pushReplacementNamed(RoutesName.project);
                      default:
                    }
                  },
                  builder: (context, state) {
                    if (state is InitialState || state is ValidateColorButtonState) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.42),
                          child: Form(
                            key: loginViewModel.formKey,
                            onChanged: () => loginViewModel
                                .doAction(ValidateColorButtonAction()),
                            child: Card(
                              elevation: 30,
                              shadowColor: Colors.black45,
                              color: const Color(0xFFFFFFFF),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28)),
                              margin: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30.w, vertical: 36.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Welcome Back!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF102027),
                                      ),
                                    ),
                                    verticalSpace(10),
                                    Text(
                                      'Log in to continue',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                        color: const Color(0xFF546E7A),
                                      ),
                                    ),
                                    verticalSpace(30),
                                    CustomTextFormField(
                                      hintText: 'Enter your email',
                                      keyboardType: TextInputType.emailAddress,
                                      controller: loginViewModel.emailController,
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
                                      keyboardType:
                                      TextInputType.visiblePassword,
                                      controller:
                                      loginViewModel.passwordController,
                                      labelText: 'Password',
                                      validator: (val) =>
                                          Validations.validatePassword(val),
                                    ),
                                    verticalSpace(5),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Forgot Password?',
                                          style: TextStyle(
                                            color: Color(0xFF546E7A),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    verticalSpace(5),
                                    AnimatedOpacity(
                                      duration:
                                      const Duration(milliseconds: 300),
                                      opacity:
                                      loginViewModel.validate ? 1.0 : 0.5,
                                      child: CustomAuthButton(
                                        text: 'SIGN IN',
                                        onPressed: loginViewModel.validate
                                            ? () => loginViewModel
                                            .doAction(LoginAction())
                                            : null,
                                        color: loginViewModel.validate
                                            ? const Color(0xFF102027)
                                            : const Color(0xFFB0BC5),
                                      ),
                                    ),
                                    verticalSpace(20),
                                    NoAccountRow(
                                      content: 'Don’t have an account?',
                                      actionText: 'Register here',
                                      onPressed: () {
                                        navKey.currentState!
                                            .pushReplacementNamed(
                                            RoutesName.register);
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
                    return const Center(child: CircularProgressIndicator());
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
