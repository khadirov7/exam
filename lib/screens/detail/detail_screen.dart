import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nt_exam_4/blocs/basket/basket_bloc.dart';
import 'package:nt_exam_4/blocs/basket/basket_event.dart';
import 'package:nt_exam_4/data/models/product_model.dart';
import 'package:nt_exam_4/utils/styles/app_text_style.dart';
import '../../blocs/product/product_state.dart';
import '../../blocs/product/products_bloc.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/images/app_images.dart';
import '../../utils/size/size_utils.dart';
import '../route.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key,required this.productModel});
  final ProductModel productModel;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool readMore = false;

  @override
  Widget build(BuildContext context) {
    ProductModel product = widget.productModel;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.cartScreen);
            },
            icon: SvgPicture.asset(AppImages.shoppingCart),
          ),
          SizedBox(width: 4.w),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppImages.person),
          ),
          SizedBox(width: 4.w),
        ],
      ),
      body:BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      if (state.status == ProductsStatus.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.status == ProductsStatus.failure) {
        return Center(
          child: Text(
            "Error: ${state.errorMessage}",
            style:const TextStyle(color: Colors.red),
          ),
        );
      } else if (state.products.isEmpty) {
        return const Center(child: Text("Mahsulot mavjud emas"));
      } else {
        return ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(product.images,),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Row(
                  children: [
                    ...List.generate(
                      5,
                          (index) =>
                          SvgPicture.asset(
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
                    SvgPicture.asset(AppImages.shoppingBasket, width: 18,
                        color: AppColors.c_8B96A5),
                    SizedBox(width: 8.w),
                    Text(
                      "${product.orders} sold",
                      style: TextStyle(
                        fontSize: 13.w,
                        color: AppColors.c_8B96A5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 18.0.w, top: 20.h, bottom: 5.h),
              child: Text(product.name,
                  style: TextStyle(
                      color: AppColors.c_1C1C1C,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700)),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 18.0.w, top: 1.h, bottom: 10.h),
              child: Row(
                children: [
                  Text("\$${product.price}",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700)),
                  Text(" (50-100 pcs)",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 8.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              backgroundColor: MaterialStatePropertyAll(
                                  Colors.blueAccent)
                          ),
                          onPressed: () {
                            context.read<BasketBloc>().add(AddProductBasketEvent(product: product));
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Qoshildi")));
                          }, child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.h),
                        child: Text(product.isDiscount ? "Send inquiry -25%":"Send inquiry", style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w700)),
                      )),
                    ),
                    TextButton(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                            side: MaterialStatePropertyAll(
                                BorderSide(color: Colors.black87, width: 1))
                        ),
                        onPressed: () {},
                        child: Icon(Icons.favorite_border, size: 23.w
                          ,)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.h),
              child: Text(
                  product.description, maxLines: readMore == false ? 4 : null,
                  style: AppTextStyle.interThin.copyWith(
                      color: const Color(0xFF505050),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {
                        readMore = !readMore;
                        setState(() {});
                      },
                      child: Text(
                        readMore == false ? "Read more" : "Hide",
                        style: TextStyle(
                            color: AppColors.c_0D6EFD,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500),
                      )),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.w),
                color: Colors.white,
                border: Border.all(
                    width: 1.h, color: AppColors.c_DEE2E7),
              ),
              padding: EdgeInsets.symmetric(
                  vertical: 12.h, horizontal: 14.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        child: Text("R"),
                      ),
                      SizedBox(width: 15.w),
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Supplier",
                            style: TextStyle(
                              fontSize: 16.w,
                              color: AppColors.c_505050,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            "Guanjoi Trading LLC",
                            style: TextStyle(
                              fontSize: 16.w,
                              color: const Color(0xFF333333),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    children: [
                      SizedBox(width: 8.w, height: 10,),
                      Image.asset(
                        'assets/images/img.png', width: 20.w, height: 14.h,),
                      SizedBox(width: 15.w,),
                      Text("Germany", style: AppTextStyle.interMedium.copyWith(
                          color: const Color(0xFF505050), fontSize: 13.sp),)
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 18.0.w, top: 20.h, bottom: 10.h),
              child: Text("Similar products",
                  style: TextStyle(
                      color: AppColors.c_1C1C1C,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700)),
            ),
            Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(state.products.length, (index) {
                        ProductModel product = state.products[index];
                        if (product.category == Category.Mebellar) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(productModel: product)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: AppColors.c_DEE2E7,
                                    width: 1.w,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        product.images,
                                        width: 120.w,
                                        height: 120.h,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(height: 14.h),
                                      Text("\$${product.price}",
                                          style: AppTextStyle.interMedium
                                              .copyWith(
                                              color: AppColors.c_1C1C1C,
                                              fontSize: 16.sp)),
                                      SizedBox(height: 14.h),
                                      Text(
                                        product.name,
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
                              ),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      })
                    ],
                  ),
                ),

              ],
            )
          ],
        );
      }
  }
    )
    );
  }
}
