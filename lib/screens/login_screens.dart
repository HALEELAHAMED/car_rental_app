import 'package:car_rental_application/core/constants/app_colors.dart';
import 'package:car_rental_application/core/constants/app_svgs.dart';
import 'package:car_rental_application/screens/car_list_screen.dart';
import 'package:car_rental_application/widgets/custom_button.dart';
import 'package:car_rental_application/widgets/custom_text.dart';
import 'package:car_rental_application/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int selectedTab = 0;

  final _fullNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: CustomButton(
            text: selectedTab == 0 ? 'Login' : 'Sign Up',
            onPressed: () {
              if (selectedTab == 0) {
                // LOGIN
                if (_loginFormKey.currentState!.validate()) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => CarListScreen()),
                  );
                }
              } else {
                // SIGN UP
                if (_signupFormKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: AppColors.gold,
                      content: Text('Sign up successful. Please login'),
                    ),
                  );

                  setState(() {
                    selectedTab = 0;
                  });

                  _fullNameCtrl.clear();
                  _emailCtrl.clear();
                  _mobileCtrl.clear();
                  _passwordCtrl.clear();
                  _confirmPasswordCtrl.clear();
                }
              }
            },
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),

              SvgPicture.asset(AppSvgs.login, width: 200, height: 200),

              // Title
              CustomText(
                text: "Start Your Journey",
                fontFamily: 'Gentium',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryBlue,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              CustomText(
                text: "Join now or log in to start exploring",
                fontFamily: 'SFPRODisplay',
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20.h),

              // Login / Signup Toggle
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    _buildTabButton("Login", 0),
                    _buildTabButton("Sign Up", 1),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              selectedTab == 0
                  ? Form(key: _loginFormKey, child: _buildLoginForm())
                  : Form(key: _signupFormKey, child: _buildSignUpForm()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    final isSelected = selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? AppColors.primaryBlue
                    : Colors.grey.shade600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextfield(
          labelText: "Email",
          keyboardType: TextInputType.emailAddress,
          controller: _emailCtrl,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email is required';
            }
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(value)) {
              return 'Enter a valid email';
            }
            return null;
          },
        ),

        SizedBox(height: 15.h),

        CustomTextfield(
          labelText: "Password",
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          controller: _passwordCtrl,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),

        SizedBox(height: 10.h),

        Align(
          alignment: Alignment.centerRight,
          child: CustomText(
            text: "Forgot password?",
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryBlue,
          ),
        ),

        SizedBox(height: 80.h),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // FULL NAME
        CustomTextfield(
          labelText: "Full Name",
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          controller: _fullNameCtrl,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Full name';
            }
            if (value.length < 3) {
              return 'Full name must be at least 3 characters';
            }
            return null;
          },
        ),

        SizedBox(height: 10.h),

        // EMAIL
        CustomTextfield(
          labelText: "Email Address",
          keyboardType: TextInputType.emailAddress,
          controller: _emailCtrl,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Email';
            }
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(value)) {
              return 'Enter a valid email address';
            }
            return null;
          },
        ),

        SizedBox(height: 10.h),

        // MOBILE
        CustomTextfield(
          labelText: "Mobile Number",
          keyboardType: TextInputType.phone,
          controller: _mobileCtrl,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter a Mobile Number';
            }
            if (value.length != 10) {
              return 'Enter a valid 10-digit mobile number';
            }
            return null;
          },
        ),

        SizedBox(height: 10.h),

        // PASSWORD
        CustomTextfield(
          labelText: "Password",
          obscureText: true,
          controller: _passwordCtrl,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),

        SizedBox(height: 10.h),

        // CONFIRM PASSWORD
        CustomTextfield(
          labelText: "Confirm Password",
          obscureText: true,
          controller: _confirmPasswordCtrl,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Confirm password is required';
            }
            if (value != _passwordCtrl.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),

        SizedBox(height: 20.h),
      ],
    );
  }
}
