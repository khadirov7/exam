import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors/app_colors.dart';
import '../../../utils/images/app_images.dart';
class ProductItemListWidget extends StatelessWidget {
  const ProductItemListWidget({super.key, required this.onTap, required this.name, required this.image, required this.order, required this.price});
  final VoidCallback onTap;
  final String name;
  final String image;
  final num order;
  final num price;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.w),
          color: Colors.white,
          border: Border.all(
              width: 1.h, color: AppColors.c_DEE2E7),
        ),
        padding: EdgeInsets.symmetric(
            vertical: 12.h, horizontal: 14.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              image,
              fit: BoxFit.cover,
              height: 84.h,
              width: 84.w,
            ),
            SizedBox(width: 15.w),
            Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16.w,
                    color: AppColors.c_505050,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  "\$${price}",
                  style: TextStyle(
                    fontSize: 16.w,
                    color: Color(0xFF333333),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3.h),
                Row(children: [
                  ...List.generate(
                    5,
                        (index) => SvgPicture.asset(
                        AppImages.star,
                        color: Colors.amber),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "7.5",
                    style: TextStyle(
                      fontSize: 13.w,
                      color: Colors.amber,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  SvgPicture.asset(AppImages.circle),
                  SizedBox(width: 8.w),
                  Text(
                    "${order} orders",
                    style: TextStyle(
                      fontSize: 13.w,
                      color: AppColors.c_8B96A5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ]),
                SizedBox(height: 3.h),
                Text(
                  "Free Shipping",
                  style: TextStyle(
                    fontSize: 13.w,
                    color: AppColors.c_00B517,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
