// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_delivery/src/views/login.screen.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

import '../widgets/common/customTextField.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery); // You can also use ImageSource.camera
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _registerUser() async {
    try {
      // Prepare data
      final Map<String, dynamic> userData = {
        'userName': _userNameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
        // Include additional fields as needed
      };

      // Create multipart request
      final Uri uri = Uri.parse(
          'http://10.0.2.2:3001/api/v1/auth/register'); // Replace with your backend URL
      final http.MultipartRequest request = http.MultipartRequest('POST', uri);

      // Add text fields
      userData.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      request.headers.addAll({
        'Content-Type': 'application/json', // Assuming JSON data is sent
      });

      // Add image file if selected
      if (_image != null) {
        final file = await http.MultipartFile.fromPath('profile', _image!.path);
        request.files.add(file);
      }

      // Send request
      final http.StreamedResponse response = await request.send();
      final String responseData = await response.stream.bytesToString();

      // Handle response
      final dynamic decodedResponse = json.decode(responseData);
      debugPrint(decodedResponse); // You can handle the response as needed
      Navigator.push(
        context,
        PageTransition(
          duration: const Duration(milliseconds: 1000),
          reverseDuration: const Duration(milliseconds: 900),
          type: PageTransitionType.topToBottom,
          child: const LoginScreen(),
        ),
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: GoogleFonts.dmSans().fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(20),
                  Text(
                    'Please sign up to get started',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.dmSans().fontFamily,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              height: height * 0.8,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Gap(10),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _userNameController,
                            icon: Iconsax.user,
                            hintText: 'Username',
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _image == null
                              ? CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.grey.shade300,
                                  child: IconButton(
                                    onPressed: _getImage,
                                    icon: const Icon(Iconsax.camera),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.transparent,
                                  child: Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    CustomTextField(
                      controller: _emailController,
                      icon: Icons.mail_outline_rounded,
                      hintText: 'Email',
                      textAlign: TextAlign.start,
                    ),
                    const Gap(20),
                    CustomTextField(
                      controller: _passwordController,
                      icon: Iconsax.password_check,
                      hintText: 'Password',
                      textAlign: TextAlign.start,
                      suffixIcon: Iconsax.eye,
                    ),
                    const Gap(20),
                    CustomTextField(
                      controller: _addressController,
                      icon: Iconsax.home,
                      hintText: 'Address',
                      textAlign: TextAlign.start,
                    ),
                    const Gap(20),
                    CustomTextField(
                      controller: _phoneController,
                      icon: Icons.phone_outlined,
                      hintText: 'Phone Number',
                      textAlign: TextAlign.start,
                    ),
                    const Gap(15),
                    InkWell(
                      onTap: () {
                        _registerUser();
                        debugPrint('press kia toh h');
                      },
                      child: Container(
                        height: 50,
                        width: w,
                        decoration: BoxDecoration(
                          color: Colors.orange.shade500,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontFamily: GoogleFonts.dmSans().fontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
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
                                type: PageTransitionType.bottomToTopJoined,
                                childCurrent: const SignUpScreen(),
                                child: const LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.purpleAccent.shade700,
                              fontFamily: GoogleFonts.dmSans().fontFamily,
                            ),
                          ),
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
