import 'package:flutter/material.dart';
import 'package:viapulsa_mobile_test/app/constants/app_colors.dart';

class MyLabelForm extends StatelessWidget {
  final String? text;
  const MyLabelForm({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Text(
        '$text',
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: AppColor.primary),
      ),
    );
  }
}
