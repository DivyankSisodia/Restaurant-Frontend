import 'package:flutter/material.dart';
import 'package:food_delivery/src/utils/styles/text_style.dart';
import 'package:food_delivery/src/views/login.screen.dart';
import 'package:gap/gap.dart';
import '../../../services/changePassword.service.dart';
import '../../common/customTextField.dart';

class AddressPasswordDialog extends StatefulWidget {
  const AddressPasswordDialog({super.key});

  @override
  _AddressPasswordDialogState createState() => _AddressPasswordDialogState();
}

class _AddressPasswordDialogState extends State<AddressPasswordDialog> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _existingPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        'Address & Password',
        style: AppStyle.cartScreenTitle,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'type your current password',
                  style: AppStyle.cartScreenSmallText,
                ),
                const Gap(10),
                CustomTextField(
                  controller: _existingPasswordController,
                  hintText: 'existing password',
                  icon: Icons.lock,
                  textAlign: TextAlign.start,
                ),
                const Gap(10),
                Text(
                  'type new password',
                  style: AppStyle.cartScreenSmallText,
                ),
                const Gap(10),
                CustomTextField(
                  controller: _newPasswordController,
                  hintText: 'new password',
                  icon: Icons.lock,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            const Gap(30),
            Row(
              children: [
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    print(
                        'Existing Password: ${_existingPasswordController.text}');
                    print('New Password: ${_newPasswordController.text}');
                    await updatePassword(
                      context,
                      _existingPasswordController.text,
                      _newPasswordController.text,
                    );
                    Navigator.of(context).pop();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
