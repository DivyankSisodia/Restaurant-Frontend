// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/utils/styles/text_style.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart'; // Import the provider
import '../../../controller/fetchUserDetail.controller.dart';
import '../../../services/changeUserDetails.service.dart';
import '../../common/customTextField.dart';

class EditUserDetailDialog extends ConsumerStatefulWidget {
  const EditUserDetailDialog({super.key});

  @override
  _EditUserDetailDialogState createState() => _EditUserDetailDialogState();
}

class _EditUserDetailDialogState extends ConsumerState<EditUserDetailDialog> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  List<dynamic> address = [];

  @override
  void initState() {
    super.initState();
    // Fetch user details and populate the fields
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getUserProvider.future).then((userDetails) {
        _userNameController.text = userDetails.userName;
        _phoneController.text = userDetails.phone;
        _emailController.text = userDetails.email;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _userNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userDetailsAsyncValue = ref.watch(getUserProvider);

    return AlertDialog(
      backgroundColor: Colors.grey.shade200,
      title: Text(
        'Edit your Details',
        style: AppStyle.mediumPriceText,
      ),
      content: userDetailsAsyncValue.when(
        data: (userDetails) {
          address = userDetails.address;
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Gap(50),
                CustomTextField(
                  controller: _userNameController,
                  hintText: 'User Name',
                  icon: Iconsax.personalcard5,
                  textAlign: TextAlign.start,
                ),
                const Gap(10),
                CustomTextField(
                  controller: _phoneController,
                  hintText: 'Phone Number',
                  icon: Iconsax.call5,
                  textAlign: TextAlign.start,
                ),
                const Gap(10),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Email Address',
                  icon: Icons.mail,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Text('Error: $err'),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            // Save functionality
            await updateUserDetail(
                context,
                _phoneController.text,
                _userNameController.text,
                _emailController.text,
                address.isNotEmpty ? address.join(', ') : null);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
