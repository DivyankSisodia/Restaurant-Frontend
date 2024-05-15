import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/src/controller/login.controller.dart';
import 'package:food_delivery/src/views/sign.screen.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';

import '../widgets/common/customTextField.dart';
import '../widgets/common/socialMedia.icons.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginController = ref.watch(loginProvider);

    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: w,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Log In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: GoogleFonts.dmSans().fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(20),
                  Text(
                    'Please sign in to your existing account',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.dmSans().fontFamily,
                      fontSize: 19,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Gap(20),
                    CustomTextField(
                      controller: loginController.emailController,
                      icon: Icons.mail_outline_rounded,
                      hintText: 'Email',
                      textAlign: TextAlign.start,
                    ),
                    const Gap(20),
                    CustomTextField(
                      controller: loginController.passwordController,
                      icon: Iconsax.password_check,
                      hintText: 'Password',
                      textAlign: TextAlign.start,
                      suffixIcon: Iconsax.eye,
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (value) {
                            debugPrint('$value');
                          },
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            debugPrint('Forgot password');
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontFamily: GoogleFonts.dmSans().fontFamily,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(15),
                    Consumer(
                      builder: (context, ref, _) {
                        final loginController = ref.watch(loginProvider);
                        return InkWell(
                          onTap: loginController.isLoading
                              ? null
                              : () {
                                  loginController.loginUser(context);
                                  debugPrint('press kia toh h');
                                },
                          child: Container(
                            height: 50,
                            width: w,
                            decoration: BoxDecoration(
                              color: loginController.isLoading
                                  ? Colors.grey
                                  : Colors.orange.shade500,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: loginController.isLoading
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      'Log In',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontFamily:
                                            GoogleFonts.dmSans().fontFamily,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade800,
                            fontFamily: GoogleFonts.dmSans().fontFamily,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                duration: const Duration(
                                  milliseconds: 1000,
                                ),
                                reverseDuration: const Duration(
                                  milliseconds: 900,
                                ),
                                type: PageTransitionType.topToBottomJoined,
                                childCurrent: const LoginScreen(),
                                child: const SignUpScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'sign up',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.purpleAccent.shade700,
                              fontFamily: GoogleFonts.dmSans().fontFamily,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SocialMediaIcons(
                          bgColor: Colors.blue.shade800,
                          iconColor: Colors.white,
                          icon: FontAwesomeIcons.facebookF,
                        ),
                        SocialMediaIcons(
                          bgColor: Colors.lightBlueAccent.shade200,
                          iconColor: Colors.white,
                          icon: FontAwesomeIcons.twitter,
                        ),
                        const SocialMediaIcons(
                          bgColor: Colors.black87,
                          iconColor: Colors.white,
                          icon: FontAwesomeIcons.google,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
