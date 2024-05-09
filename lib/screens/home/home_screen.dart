import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nt_exam_4/screens/detail/detail_screen.dart';
import 'package:nt_exam_4/screens/home/widgets/drawer.dart';
import 'package:nt_exam_4/screens/itemlist/item_list_screen.dart';
import 'package:nt_exam_4/screens/route.dart';
import 'package:nt_exam_4/utils/colors/app_colors.dart';
import 'package:nt_exam_4/utils/images/app_images.dart';
import '../../blocs/product/product_event.dart';
import '../../blocs/product/product_state.dart';
import '../../blocs/product/products_bloc.dart';
import '../../data/models/product_model.dart';
import '../../utils/size/size_utils.dart';
import '../../utils/styles/app_text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  Category selectedCategory = Category.Hammasi;
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<ProductBloc>().add(
          GetProductsEvent(
              category: selectedCategory,
              productName: selectedCategory.toString()),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: AppColors.white,
      appBar: AppBar(
        titleSpacing: 1,
        title: SvgPicture.asset(
          AppImages.brand,
          width: 116.w,
          height: 36.h,
        ),
        backgroundColor: AppColors.white,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.cartScreen);
              },
              icon: SvgPicture.asset(
                AppImages.shoppingCart,
                width: 24.w,
                height: 24.h,
              )),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                AppImages.person,
                width: 24.w,
                height: 24.h,
              ))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0.w),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Qidiruv...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.sp),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: Category.values.map((category) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: ChoiceChip(
                    label: Text(category.toString().split('.').last),
                    selected: selectedCategory == category,
                    onSelected: (isSelected) {
                      setState(() {
                        selectedCategory =
                            isSelected ? category : Category.Hammasi;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ItemListScreen(category: selectedCategory)));
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state.status == ProductsStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.status == ProductsStatus.failure) {
                  return Center(
                    child: Text(
                      "Error: ${state.errorMessage}",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else if (state.products.isEmpty) {
                  return Center(child: Text("Mahsulot mavjud emas"));
                } else {
                  return ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Visibility(
                        visible: selectedCategory == Category.Hammasi,
                        child: Stack(
                          children: [
                            Image.asset(AppImages.lastedNews),
                            Positioned(
                              top: 25.h,
                              bottom: 0.h,
                              left: 26.w,
                              right: 0.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Latest trending",
                                    style: TextStyle(
                                        color: AppColors.c_1C1C1C,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "Electronic items",
                                    style: TextStyle(
                                        color: AppColors.c_1C1C1C,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  TextButton(
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  AppColors.white)),
                                      onPressed: () {},
                                      child: Text(
                                        "Learn more",
                                        style: TextStyle(
                                            color: AppColors.c_0D6EFD,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.h),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14.0),
                              child: Column(
                                children: [
                                  Text("Deals and offers",
                                      style: TextStyle(
                                          color: AppColors.c_1C1C1C,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600)),
                                  Text("Electronic equipments",
                                      style: TextStyle(
                                          color: AppColors.c_505050,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 13.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                  color: AppColors.c_EFF2F4
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "14",
                                    style: AppTextStyle.interSemiBold.copyWith(
                                        color: AppColors.c_8B96A5, fontSize: 16.sp),
                                  ),
                                  Text(
                                    "Hour",
                                    style: AppTextStyle.interSemiBold.copyWith(
                                        color: AppColors.c_8B96A5, fontSize: 11.sp),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 13.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                  color: AppColors.c_EFF2F4
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "52",
                                    style: AppTextStyle.interSemiBold.copyWith(
                                        color: AppColors.c_8B96A5, fontSize: 16.sp),
                                  ),
                                  Text(
                                    "Min  ",
                                    style: AppTextStyle.interSemiBold.copyWith(
                                        color: AppColors.c_8B96A5, fontSize: 11.sp),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 13.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                  color: AppColors.c_EFF2F4
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "12",
                                    style: AppTextStyle.interSemiBold.copyWith(
                                        color: AppColors.c_8B96A5, fontSize: 16.sp),
                                  ),
                                  Text(
                                    "Sec  ",
                                    style: AppTextStyle.interSemiBold.copyWith(
                                        color: AppColors.c_8B96A5, fontSize: 11.sp),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Visibility(
                        visible: selectedCategory == Category.Hammasi,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...List.generate(state.products.length, (index) {
                                ProductModel product = state.products[index];
                                if (product.isDiscount == true) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                      productModel: product)));
                                    },
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
                                              product.images,
                                              width: 76.w,
                                              height: 83.h,
                                            ),
                                          ),
                                          Text(product.name),
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
                                } else {
                                  return SizedBox();
                                }
                              })
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: selectedCategory == Category.Hammasi,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 18.0.w, top: 20.h, bottom: 10.h),
                          child: Text("Home and outdoor",
                              style: TextStyle(
                                  color: AppColors.c_1C1C1C,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                      Visibility(
                        visible: selectedCategory == Category.Hammasi,
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...List.generate(
                                    state.products.length,
                                    (index) {
                                      ProductModel product =
                                          state.products[index];
                                      if (product.category ==
                                              Category.Mebellar &&
                                          selectedCategory ==
                                              Category.Hammasi) {
                                        return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailScreen(
                                                              productModel:
                                                                  product)));
                                            },
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
                                                    padding: EdgeInsets.only(
                                                        top: 8.0.h),
                                                    child: Image.network(
                                                      product.images,
                                                      width: 76.w,
                                                      height: 83.h,
                                                    ),
                                                  ),
                                                  Text(product.name),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Text(
                                                      "From USD ${product.price}"),
                                                ],
                                              ),
                                            ));
                                      } else {
                                        return SizedBox();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ItemListScreen(
                                                  category: selectedCategory,
                                                )));
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 10.0.h, top: 8.h),
                                    child: Text(
                                      "Source now -->",
                                      style: AppTextStyle.interRegular
                                          .copyWith(color: AppColors.c_0D6EFD),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: selectedCategory == Category.Hammasi,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 18.0.w, top: 20.h, bottom: 10.h),
                          child: Text("Consumer Electronics",
                              style: TextStyle(
                                  color: AppColors.c_1C1C1C,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                      Visibility(
                        visible: selectedCategory == Category.Hammasi,
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...List.generate(state.products.length,
                                      (index) {
                                    ProductModel product =
                                        state.products[index];
                                    if (product.category ==
                                            Category.Qurilmalar &&
                                        selectedCategory == Category.Hammasi) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailScreen(
                                                          productModel:
                                                              product)));
                                        },
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
                                                  product.images,
                                                  width: 76.w,
                                                  height: 83.h,
                                                ),
                                              ),
                                              Text(product.name),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Text("From USD ${product.price}"),
                                            ],
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ItemListScreen(
                                                  category: selectedCategory,
                                                )));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0.h, top: 8.h, bottom: 15.h),
                                    child: Text(
                                      "Source now -->",
                                      style: AppTextStyle.interRegular
                                          .copyWith(color: AppColors.c_0D6EFD),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: selectedCategory == Category.Hammasi,
                        child: Stack(
                          children: [
                            Image.asset(AppImages.suppliers),
                            Positioned(
                              top: 25.h,
                              bottom: 0.h,
                              left: 26.w,
                              right: 0.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "An easy way to send",
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "requests to all suppliers",
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
                        ),
                      ),
                      Visibility(
                        visible: selectedCategory == Category.Hammasi,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 18.0.w, top: 20.h, bottom: 10.h),
                          child: Text("Recommended items",
                              style: TextStyle(
                                  color: AppColors.c_1C1C1C,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                      Visibility(
                        visible: selectedCategory == Category.Hammasi,
                        child: SizedBox(
                          height: 280.h,
                          child: GridView.count(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            crossAxisCount: 2,
                            crossAxisSpacing: 2.w,
                            mainAxisSpacing: 8.h,
                            childAspectRatio: 0.66786,
                            children: [
                              ...List.generate(state.products.length, (index) {
                                ProductModel product = state.products[index];
                                {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                      productModel: product)));
                                    },
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
                                            product.images,
                                            width: 143.w,
                                            height: 143.h,
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
                                            product.description,
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
                              }),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: selectedCategory == Category.Qurilmalar,
                        child: SizedBox(
                          height: height,
                          child: GridView.count(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            crossAxisCount: 2,
                            crossAxisSpacing: 2.w,
                            mainAxisSpacing: 8.h,
                            childAspectRatio: 0.66786,
                            children: [
                              ...List.generate(state.products.length, (index) {
                                ProductModel product = state.products[index];
                                {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                      productModel: product)));
                                    },
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
                                            product.images,
                                            width: 143.w,
                                            height: 143.h,
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
                                            "T-shirts with multiple colors, for men",
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
                              }),
                              Spacer()
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: selectedCategory == Category.Akksessuarlar,
                        child: SizedBox(
                          height: height,
                          child: GridView.count(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            crossAxisCount: 2,
                            crossAxisSpacing: 2.w,
                            mainAxisSpacing: 8.h,
                            childAspectRatio: 0.66786,
                            children: [
                              ...List.generate(state.products.length, (index) {
                                ProductModel product = state.products[index];
                                {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                      productModel: product)));
                                    },
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
                                            product.images,
                                            width: 143.w,
                                            height: 143.h,
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
                                            "T-shirts with multiple colors, for men",
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
                              }),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: selectedCategory == Category.Kiyimlar,
                        child: SizedBox(
                          height: height,
                          child: GridView.count(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            crossAxisCount: 2,
                            crossAxisSpacing: 2.w,
                            mainAxisSpacing: 8.h,
                            childAspectRatio: 0.66786,
                            children: [
                              ...List.generate(state.products.length, (index) {
                                ProductModel product = state.products[index];
                                {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                      productModel: product)));
                                    },
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
                                            product.images,
                                            width: 143.w,
                                            height: 143.h,
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
                                            "T-shirts with multiple colors, for men",
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
                              }),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: selectedCategory == Category.Kitoblar,
                        child: SizedBox(
                          height: height,
                          child: GridView.count(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            crossAxisCount: 2,
                            crossAxisSpacing: 2.w,
                            mainAxisSpacing: 8.h,
                            childAspectRatio: 0.66786,
                            children: [
                              ...List.generate(state.products.length, (index) {
                                ProductModel product = state.products[index];
                                {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                      productModel: product)));
                                    },
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
                                            product.images,
                                            width: 143.w,
                                            height: 143.h,
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
                                            "T-shirts with multiple colors, for men",
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
                              }),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: selectedCategory == Category.Mebellar,
                        child: SizedBox(
                          height: height,
                          child: GridView.count(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            crossAxisCount: 2,
                            crossAxisSpacing: 2.w,
                            mainAxisSpacing: 8.h,
                            childAspectRatio: 0.66786,
                            children: [
                              ...List.generate(state.products.length, (index) {
                                ProductModel product = state.products[index];
                                {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                      productModel: product)));
                                    },
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
                                            product.images,
                                            width: 143.w,
                                            height: 143.h,
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
                                            "T-shirts with multiple colors, for men",
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
                              }),
                              Spacer()
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

//
