import 'package:flutter/material.dart';
import 'package:test_task_app/constants/app_colors.dart';
import 'package:test_task_app/constants/app_string.dart';

class PointsContainer extends StatelessWidget {
  final int total;
  final int success;
  final int failed;
  const PointsContainer({
    super.key,
    required this.total,
    required this.success,
    required this.failed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,

      children: [
        _buildNumberCell(total, AppString.total),
        _buildNumberCell(success, AppString.success),
        _buildNumberCell(failed, AppString.failed),
      ],
    );
  }

  _buildNumberCell(int number, String text) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.dark01,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Text(
                number.toString(),
                style: const TextStyle(fontSize: 24),
              ),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
