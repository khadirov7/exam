import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors/app_colors.dart';

class DiscountWidget extends StatelessWidget {
  const DiscountWidget({super.key,required this.onTap, required this.image, required this.name});
  final VoidCallback onTap;
  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180.h,
        width: 140.w,
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(4),
            border: Border.all(
              color: AppColors.c_DEE2E7,
              width: 1,
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
          CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
              EdgeInsets.only(top: 8.0.h),
              child: Image.network(
                image,
                width: 76.w,
                height: 83.h,
              ),
            ),
            Text(name),
            TextButton(
                style: const ButtonStyle(
                    backgroundColor:
                    MaterialStatePropertyAll(
                        Color(0xFFFFE3E3))),
                onPressed: () {},
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(
                      horizontal: 8.0),
                  child: Text(
                    "-25%",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.sp,
                        fontWeight:
                        FontWeight.w500),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
