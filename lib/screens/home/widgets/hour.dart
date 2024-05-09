import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors/app_colors.dart';
import '../../../utils/styles/app_text_style.dart';
class TimeWidget extends StatelessWidget {
  const TimeWidget({super.key,required this.time,required this.type});
  final String time;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.symmetric(
          horizontal: 13.w, vertical: 6.h),
      decoration:
      BoxDecoration(color: AppColors.c_EFF2F4),
      child: Column(
        children: [
          Text(
            time,
            style: AppTextStyle.interSemiBold.copyWith(
                color: AppColors.c_8B96A5,
                fontSize: 16.sp),
          ),
          Text(
           type,
            style: AppTextStyle.interSemiBold.copyWith(
                color: AppColors.c_8B96A5,
                fontSize: 11.sp),
          ),
        ],
      ),
    );
  }
}
