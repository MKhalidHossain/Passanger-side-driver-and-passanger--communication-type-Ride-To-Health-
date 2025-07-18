import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rideztohealth/app.dart';
import 'package:rideztohealth/core/extensions/text_extensions.dart';
import 'package:rideztohealth/core/widgets/wide_custom_button.dart';
import '../../../../core/validation/validators.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/utils/constants/app_colors.dart';
import 'forgot_password_screen.dart';
import 'user_signup_screen.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => UserLoginScreenState();
}

class UserLoginScreenState extends State<UserLoginScreen> {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AppScaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: size.height),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // 🔥 Center vertically
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        AppLogo(),
                        const SizedBox(height: 32),
                        Center(
                          child: Text(
                            'Log In Your Account',
                            style: TextStyle(
                              color: AppColors.context(context).textColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        // Center(
                        //   child: Text(
                        //     'sign in to access your account',
                        //     style: TextStyle(
                        //       color: Colors.grey.shade600,
                        //       fontWeight: FontWeight.w400,
                        //       fontSize: 14,
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 12),

                        const SizedBox(height: 12),

                        /// Email
                        TextFormField(
                          controller: _emailController,
                          focusNode: _emailFocus,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Image.asset(
                                'assets/images/email.png',
                                width: 24,
                                height: 24,
                                fit: BoxFit.contain,
                              ),
                            ),
                            hint: Text(
                              'Email',
                              style: TextStyle(
                                color: AppColors.context(context).textColor,
                              ),
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                          onFieldSubmitted: (_) => FocusScope.of(
                            context,
                          ).requestFocus(_passwordFocus),
                          textInputAction: TextInputAction.done,
                          validator: Validators.email,
                          style: TextStyle(
                            color: AppColors.context(context).textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          autofillHints: const [AutofillHints.email],
                        ),

                        const SizedBox(height: 12),

                        /// Password
                        TextFormField(
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          keyboardType: TextInputType.emailAddress,

                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                'assets/images/password.png',
                                width: 24,
                                height: 24,
                                fit: BoxFit.contain,
                              ),
                            ),
                            hint: Text(
                              'Password',
                              style: TextStyle(
                                color: AppColors.context(context).textColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                          obscureText: true,
                          onFieldSubmitted: (_) => FocusScope.of(
                            context,
                          ).requestFocus(_passwordFocus),
                          textInputAction: TextInputAction.done,
                          //validator: Validators.email,
                          style: TextStyle(
                            color: AppColors.context(context).textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          autofillHints: const [AutofillHints.email],
                        ),
                        const SizedBox(height: 12),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Get.to(ForgotPasswordScreen());
                            },
                            child: 'Forgot Password ?'.text14Blue(),
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// Login button
                        WideCustomButton(
                          text: 'Sign in',
                          onPressed: () {
                            //Get.to(() => BottomNavBar());

                            Get.to(() => AppMain());
                          },
                        ),
                        // context.primaryButton(
                        //   onPressed: () {
                        //     String email = _emailController.text;
                        //     String password = _passwordController.text;
                        //     if (email.isEmpty) {
                        //       showCustomSnackBar('email is required'.tr);
                        //     } else if (password.isEmpty) {
                        //       showCustomSnackBar('password_is_required'.tr);
                        //     } else if (password.length < 5) {
                        //       showCustomSnackBar(
                        //         'minimum password length is 8',
                        //       );
                        //     } else {
                        //       // authController.login(email, password);
                        //     }

                        //     // Navigator.push(
                        //     //   context,
                        //     //   MaterialPageRoute(
                        //     //     builder: (context) => BottomNavigationBar(),
                        //     //   ),
                        //     // );
                        //   },
                        //   text: "Login",
                        // ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            'New To our Platform?'.text12White(),
                            TextButton(
                              child: Text(
                                "Sign Up Here",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserSignupScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        /// Google
                        // SizedBox(
                        //   width: double.infinity,
                        //   child: ElevatedButton.icon(
                        //     onPressed: () {},
                        //     icon: Image.asset(
                        //       'assets/images/google.png',
                        //       height: 24,
                        //       width: 24,
                        //     ),
                        //     label: Text(
                        //       "Continue With Google",
                        //       style: TextStyle(
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: AppColors.context(
                        //         context,
                        //       ).backgroundColor,
                        //       foregroundColor: AppColors.context(
                        //         context,
                        //       ).popupBackgroundColor,
                        //       elevation: 1,
                        //       padding: EdgeInsets.symmetric(vertical: 16),
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(12),
                        //         side: BorderSide(color: Colors.grey, width: 1),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(height: 12),

                        // /// Apple
                        // SizedBox(
                        //   width: double.infinity,
                        //   child: ElevatedButton.icon(
                        //     onPressed: () {},
                        //     icon: Image.asset(
                        //       'assets/images/apple.png',
                        //       height: 24,
                        //       width: 24,
                        //     ),
                        //     label: Text(
                        //       "Continue With Apple",
                        //       style: TextStyle(
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: AppColors.context(
                        //         context,
                        //       ).backgroundColor,
                        //       foregroundColor: AppColors.context(
                        //         context,
                        //       ).textColor,
                        //       elevation: 1,
                        //       padding: EdgeInsets.symmetric(vertical: 16),
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(12),
                        //         side: BorderSide(color: Colors.grey, width: 1),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

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
                    Image.asset('assets/images/lockk.png', height: 16),
                    Text(
                      "Your data is secure and private",
                      style: TextStyle(
                        color: AppColors.context(context).textColor,
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
        ],
      ),
    );
  }
}
