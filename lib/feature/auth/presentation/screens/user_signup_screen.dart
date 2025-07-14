import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rideztohealth/core/widgets/wide_custom_button.dart';
import '../../../../core/validation/validators.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/utils/constants/app_colors.dart';
import 'user_login_screen.dart';

class UserSignupScreen extends StatefulWidget {
  const UserSignupScreen({super.key});

  @override
  State<UserSignupScreen> createState() => UserSignupScreenState();
}

class UserSignupScreenState extends State<UserSignupScreen> {
  bool value = false;
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool value = false;

    return AppScaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: size.height),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 32),

                          Center(
                            child: Text(
                              'Create Your Account',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: AppColors.context(context).textColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          _buildCustomTextField(
                            title: 'Name',
                            context: context,
                            label: 'Enter your Full Name',
                            controller: _nameController,
                            icon: Icons.person_outline,
                            focusNode: _nameFocus,
                            validator: Validators.name,
                          ),

                          _buildCustomTextField(
                            title: 'Email',
                            context: context,
                            label: 'Enter your Email',
                            controller: _emailController,
                            icon: Icons.email_outlined,
                            focusNode: _emailFocus,
                            validator: Validators.email,
                          ),

                          _buildCustomTextField(
                            title: 'Phone Number',
                            context: context,
                            label: 'Enter your Phone Number',
                            controller: _phoneController,
                            icon: Icons.phone_outlined,
                            focusNode: _phoneFocus,
                            validator: Validators.phone,
                          ),

                          _buildCustomTextField(
                            title: 'Password',
                            context: context,
                            label: 'Create a Password',
                            controller: _passwordController,
                            icon: Icons.lock_outline,
                            focusNode: _passwordFocus,
                            validator: Validators.password,
                          ),

                          _buildCustomTextField(
                            title: 'Confirm Password',
                            context: context,
                            label: 'Confirm your Password',
                            controller: _confirmPasswordController,
                            icon: Icons.lock_outline,
                            focusNode: _confirmPasswordFocus,
                            validator: Validators.password,
                          ),

                          /// Email
                          Row(
                            children: [
                              Checkbox(
                                value: value,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    value = newValue ?? false;
                                  });
                                },
                              ),
                              Expanded(
                                child: RichText(
                                  maxLines: 3,
                                  text: TextSpan(
                                    text: 'By Registration, You agree to the',

                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: const [
                                      TextSpan(
                                        text: ' term of services ',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' and ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),

                                      TextSpan(
                                        text: ' privacy policy. ',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          WideCustomButton(text: 'Sign Up', onPressed: () {}),

                          /// Sign Up button
                          // context.primaryButton(
                          //   onPressed: () {
                          //     String email = _emailController.text;
                          //     String password = _passwordController.text;
                          //     String confirmPassword =
                          //         _confirmPasswordController.text;

                          //     if (email.isEmpty) {
                          //       showCustomSnackBar('email is required'.tr);
                          //     } else if (password.isEmpty &&
                          //         confirmPassword.isEmpty) {
                          //       showCustomSnackBar(
                          //         'Password  and confirm password is required'
                          //             .tr,
                          //       );
                          //     } else if (password.length < 5) {
                          //       showCustomSnackBar(
                          //         'minimum password length is 8',
                          //       );
                          //     } else if (password != confirmPassword) {
                          //       showCustomSnackBar('Passwords do not match');
                          //     } else {
                          //       // authController.register(
                          //       //   email,
                          //       //   password,
                          //       //   confirmPassword,
                          //       // );
                          //     }
                          //   },
                          //   text: "Sign up",
                          //   backgroundColor: AppColors.context(
                          //     context,
                          //   ).primaryColor,
                          // ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                    color: AppColors.context(
                                      context,
                                    ).popupBackgroundColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(UserLoginScreen());
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //   ),
                                    // );
                                  },
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                      color: AppColors.context(
                                        context,
                                      ).primaryColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Your Profile helps us customize your experience",
                                  style: TextStyle(
                                    color: AppColors.context(context).textColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/lockk.png',
                                      height: 16,
                                    ),
                                    Text(
                                      "Your data is secure and private",
                                      style: TextStyle(
                                        color: AppColors.context(
                                          context,
                                        ).textColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 50),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCustomTextField({
  required String title,
  required BuildContext context,
  required String label,
  required TextEditingController controller,
  required IconData icon,
  required FocusNode focusNode,
  TextInputType keyboardType = TextInputType.text,
  required String? Function(String?) validator,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RichText(
        text: TextSpan(
          text: title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          children: const [
            TextSpan(
              text: ' *',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        validator: validator,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(icon, color: Colors.grey, size: 24),

            // Image.asset(
            //   iconPath,
            //   fit: BoxFit.contain,
            //   width: 24,
            //   height: 24,
            //   color: Colors.grey,
            // ),
          ),
          hintText: label,
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(
          color: AppColors.context(context).textColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      const SizedBox(height: 24),
    ],
  );
}
