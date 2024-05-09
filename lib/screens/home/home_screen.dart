import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nt_exam_4/screens/detail/detail_screen.dart';
import 'package:nt_exam_4/screens/home/widgets/discount_products.dart';
import 'package:nt_exam_4/screens/home/widgets/drawer.dart';
import 'package:nt_exam_4/screens/home/widgets/hour.dart';
import 'package:nt_exam_4/screens/home/widgets/product_items.dart';
import 'package:nt_exam_4/screens/home/widgets/products_gridview.dart';
import 'package:nt_exam_4/screens/home/widgets/stack.dart';
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
                        child: const StackWidget(
                          image: AppImages.lastedNews,
                          title: "New Discount",
                          subtitle: "gadgets image news",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.h),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14.0),
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
                            const TimeWidget(
                              type: "Hour",
                              time: "12",
                            ),
                            const TimeWidget(
                              type: "Min  ",
                              time: "38",
                            ),
                            const TimeWidget(
                              type: "Sec  ",
                              time: "57",
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
                                  return DiscountWidget(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                        productModel:
                                                            product)));
                                      },
                                      image: product.images,
                                      name: product.name);
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
                                        return ProductItemsWidget(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailScreen(
                                                              productModel:
                                                                  product)));
                                            },
                                            image: product.images,
                                            name: product.name,
                                            price: product.price);
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
                                      return ProductItemsWidget(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailScreen(
                                                            productModel:
                                                                product)));
                                          },
                                          image: product.images,
                                          name: product.name,
                                          price: product.price);
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
                        child: const StackWidget(
                            image: AppImages.suppliers,
                            title: "An easy way to send",
                            subtitle: "requests to all suppliers"),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 2.w,
                                  mainAxisSpacing: 8.h,
                                  childAspectRatio: 0.66786,
                                  children: [
                                    ...List.generate(state.products.length,
                                        (index) {
                                      ProductModel product =
                                          state.products[index];
                                      {
                                        return ProductsGridViewWidget(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailScreen(
                                                              productModel:
                                                                  product)));
                                            },
                                            image: product.images,
                                            name: product.name,
                                            price: product.price);
                                      }
                                    }),
                                    Spacer(),
                                  ]))),
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
                                  ...List.generate(state.products.length,
                                      (index) {
                                    ProductModel product =
                                        state.products[index];
                                    {
                                      return ProductsGridViewWidget(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailScreen(
                                                            productModel:
                                                                product)));
                                          },
                                          image: product.images,
                                          name: product.name,
                                          price: product.price);
                                    }
                                  }),
                                  Spacer()
                                ],
                              ))),
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
                                  return ProductsGridViewWidget(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                        productModel:
                                                            product)));
                                      },
                                      image: product.images,
                                      name: product.name,
                                      price: product.price);
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
                                  ...List.generate(state.products.length,
                                      (index) {
                                    ProductModel product =
                                        state.products[index];
                                    {
                                      return ProductsGridViewWidget(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailScreen(
                                                            productModel:
                                                                product)));
                                          },
                                          image: product.images,
                                          name: product.name,
                                          price: product.price);
                                    }
                                  }),
                                  Spacer(),
                                ],
                              ))),
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
                                  return ProductsGridViewWidget(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                        productModel:
                                                            product)));
                                      },
                                      image: product.images,
                                      name: product.name,
                                      price: product.price);
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
                                  ...List.generate(state.products.length,
                                      (index) {
                                    ProductModel product =
                                        state.products[index];
                                    {
                                      return ProductsGridViewWidget(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailScreen(
                                                            productModel:
                                                                product)));
                                          },
                                          image: product.images,
                                          name: product.name,
                                          price: product.price);
                                    }
                                  }),
                                  Spacer()
                                ],
                              )))
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
