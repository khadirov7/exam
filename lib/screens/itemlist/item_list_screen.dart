import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nt_exam_4/data/models/product_model.dart';
import 'package:nt_exam_4/screens/detail/detail_screen.dart';
import '../../blocs/product/product_state.dart';
import '../../blocs/product/products_bloc.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/images/app_images.dart';
import '../../utils/size/size_utils.dart';
import '../../utils/styles/app_text_style.dart';
import '../route.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key, required this.category});

  final Category category;

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  bool isGrid = false;
  bool isColumn = false;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    String searchQuery = '';
    TextEditingController searchController = TextEditingController();
    @override
    void dispose() {
      searchController.dispose();
      super.dispose();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.category.toString().substring(9),
            style: TextStyle(
              fontSize: 18.w,
              color: AppColors.c_1C1C1C,
              fontWeight: FontWeight.w600,
            ),
          ),
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
        body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          if (state.status == ProductsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ProductsStatus.failure) {
            return Center(
              child: Text(
                "Error: ${state.errorMessage}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state.products.isEmpty) {
            return const Center(child: Text("Mahsulot mavjud emas"));
          } else {
            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Qidiruv...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(categoryTech.length, (index) {
                        String category = categoryTech[index];
                        return GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 7.h, horizontal: 10),
                              decoration: BoxDecoration(
                                color: AppColors.c_EFF2F4,
                                border: Border.all(
                                  width: 1.w,
                                  color: AppColors.c_DEE2E7,
                                ),
                                borderRadius: BorderRadius.circular(7.w),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Text(
                                      category,
                                      style: TextStyle(
                                        fontSize: 13.w,
                                        color: AppColors.c_0D6EFD,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            backgroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: AppColors.c_DEE2E7),
                                borderRadius: BorderRadius.circular(6.r))),
                        child: Row(
                          children: [
                            Text(
                              "Sort: Newest",
                              style: AppTextStyle.interMedium.copyWith(
                                  color: AppColors.c_1C1C1C, fontSize: 13.sp),
                            ),
                            SizedBox(
                              width: 15.h,
                            ),
                            Icon(
                              Icons.sort,
                              color: AppColors.c_8B96A5,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            backgroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: AppColors.c_DEE2E7),
                                borderRadius: BorderRadius.circular(6.r))),
                        child: Row(
                          children: [
                            Text(
                              "Filter",
                              style: AppTextStyle.interMedium.copyWith(
                                  color: AppColors.c_1C1C1C, fontSize: 13.sp),
                            ),
                            SizedBox(
                              width: 15.h,
                            ),
                            const Icon(
                              Icons.filter_alt_outlined,
                              color: AppColors.c_8B96A5,
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        isColumn = !isColumn;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(6.w),
                              topRight: Radius.circular(6.w)),
                          color: isColumn == false
                              ? AppColors.c_DEE2E7
                              : Colors.white,
                          border:
                              Border.all(width: 1.w, color: AppColors.c_DEE2E7),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppImages.menu,
                              width: 20.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (isColumn == true) {}
                        isGrid = !isGrid;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(6.w),
                              topRight: Radius.circular(6.w)),
                          color: isGrid == false
                              ? AppColors.c_DEE2E7
                              : Colors.white,
                          border:
                              Border.all(width: 1.w, color: AppColors.c_DEE2E7),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/group.svg",
                              width: 20.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                ...List.generate(state.products.length, (index) {
                  ProductModel product = state.products[index];
                  if(widget.category == Category.Hammasi) {
                    return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 5.h),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(productModel: product)));
                                },
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
                                        product.images,
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
                                            product.name,
                                            style: TextStyle(
                                              fontSize: 16.w,
                                              color: AppColors.c_505050,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(height: 3.h),
                                          Text(
                                            "\$${product.price}",
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
                                              "${product.orders} orders",
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
                              )
                            ]));
                  }
                  else if(product.category == widget.category) {
                    return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 5.h),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(productModel: product)));
                                },
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
                                        product.images,
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
                                            product.name,
                                            style: TextStyle(
                                              fontSize: 16.w,
                                              color: AppColors.c_505050,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(height: 3.h),
                                          Text(
                                            "\$${product.price}",
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
                                              "${product.orders} orders",
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
                              )
                            ]));
                  }else{
                    return SizedBox();
                  }
                }),
                 Padding(
                    padding: EdgeInsets.only(
                        left: 18.0.w, top: 20.h, bottom: 10.h),
                    child: Text("You may also like",
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
                            if (product.category == Category.Kiyimlar) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(productModel: product)));
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
