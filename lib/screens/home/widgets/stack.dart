import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors/app_colors.dart';

class StackWidget extends StatelessWidget {
  const StackWidget({super.key,required this.image, required this.title, required this.subtitle});
 final String image;
 final String title;
 final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(image),
        Positioned(
          top: 25.h,
          bottom: 0.h,
          left: 26.w,
          right: 0.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                subtitle,
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
              ),
              TextButton(
                  style: const ButtonStyle(
                      backgroundColor:
                      MaterialStatePropertyAll(
                          Colors.lightBlue)),
                  onPressed: () {},
                  child: Text(
                    "Learn more",
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
