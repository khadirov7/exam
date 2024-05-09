import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nt_exam_4/data/models/product_model.dart';
import 'package:nt_exam_4/screens/itemlist/item_list_screen.dart';
import 'package:nt_exam_4/screens/route.dart';
import 'package:nt_exam_4/utils/colors/app_colors.dart';
import 'package:nt_exam_4/utils/styles/app_text_style.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFFEFF2F4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.account_circle_rounded,size: 80.w,),
                SizedBox(height: 10.h),
                Text(
                  "Sign in | Register",
                  style: TextStyle(
                    color: AppColors.c_1C1C1C,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined,weight: 20.w,color: AppColors.c_1C1C1C),
            title: Text("Home",style: AppTextStyle.interMedium.copyWith(color: AppColors.c_1C1C1C)),
            onTap: () {
              Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/icons/category.svg',width: 20.w,color: AppColors.c_1C1C1C),
            title: Text("Category",style: AppTextStyle.interMedium.copyWith(color: AppColors.c_1C1C1C)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ItemListScreen(category: Category.Hammasi)));
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite_border,weight: 20.w,color: AppColors.c_1C1C1C),
            title: Text("Favourite",style: AppTextStyle.interMedium.copyWith(color: AppColors.c_1C1C1C)),
            onTap: () {
            },
          ),
          ListTile(
            leading: SvgPicture.asset("assets/icons/order.svg",color: AppColors.c_1C1C1C),
            title: Text("My Orders",style: AppTextStyle.interMedium.copyWith(color: AppColors.c_1C1C1C)),
            onTap: () {
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language,color: AppColors.c_1C1C1C,weight: 20.w),
            title: Text("English | USD",style: AppTextStyle.interMedium.copyWith(color: AppColors.c_1C1C1C)),
            onTap: () {
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.contact_mail,weight: 20.w,color: AppColors.c_1C1C1C),
            title: Text("Contact us",style: AppTextStyle.interMedium.copyWith(color: AppColors.c_1C1C1C)),
            onTap: () {
            },
          ),
          ListTile(
            leading: Icon(Icons.info,weight: 20.w,color: AppColors.c_1C1C1C),
            title: Text("About",style: AppTextStyle.interMedium.copyWith(color:AppColors.c_1C1C1C)),
            onTap: () {
            },
          ),
          ListTile(
            leading: const SizedBox(),
            title: Text("User agreement",style: AppTextStyle.interMedium.copyWith(color: AppColors.c_1C1C1C)),
            onTap: () {
            },
          ),
          ListTile(
            leading: const SizedBox(),
            title: Text("Partnership",style: AppTextStyle.interMedium.copyWith(color: AppColors.c_1C1C1C)),
            onTap: () {
            },
          ),
          ListTile(
            leading: const SizedBox(),
            title: Text("Privacy policy",style: AppTextStyle.interMedium.copyWith(color: AppColors.c_1C1C1C)),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}
