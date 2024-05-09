import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors/app_colors.dart';
import '../../../utils/styles/app_text_style.dart';
class ProductsGridViewWidget extends StatelessWidget {
  const ProductsGridViewWidget({super.key, required this.onTap, required this.image, required this.name, required this.price});
  final VoidCallback onTap;
  final String image;
  final String name;
  final num price;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 12.h, horizontal: 11.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius:
          BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColors.c_DEE2E7,
            width: 1.w,
          ),
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Image.network(
              image,
              width: 143.w,
              height: 143.h,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 14.h),
            Text("\$${price}",
                style: AppTextStyle.interMedium
                    .copyWith(
                    color: AppColors.c_1C1C1C,
                    fontSize: 16.sp)),
            SizedBox(height: 14.h),
            Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.interRegular
                  .copyWith(
                color: AppColors.c_8B96A5,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
