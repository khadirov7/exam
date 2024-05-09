import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_exam_4/blocs/basket/basket_bloc.dart';
import 'package:nt_exam_4/blocs/basket/basket_event.dart';
import 'package:nt_exam_4/blocs/basket/basket_state.dart';
import 'package:nt_exam_4/data/models/product_model.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/size/size_utils.dart';
import '../../utils/styles/app_text_style.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    context.read<BasketBloc>().add(GetProductsBasketEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Shopping cart",
            style: TextStyle(
              fontSize: 18.w,
              color: AppColors.c_1C1C1C,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: BlocBuilder<BasketBloc, BasketState>(builder: (context, state) {
          if (state.status == BasketStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == BasketStatus.failure) {
            return Center(
              child: Text(
                "Error: ${state.errorMessage}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state.products.isEmpty) {
            return Center(child: Lottie.asset('assets/lottie/emty.json'));
          } else {
            return ListView(
              children: [
                ...List.generate(state.products.length, (index) {
                  ProductModel product = state.products[index];
                  return Container(
                    width: double.infinity,
                    height: 170.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title:
                          Text(product.name),
                          subtitle: Text(product.description,maxLines: 2,),
                          leading: Container(
                            width: 48.w,
                            height: 48.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.white),
                            child: Center(child: Image.network(product.images)),
                          ),
                          trailing: PopupMenuButton(
                            onSelected: (value) {
                              if (value == 'update') {
                              } else if (value == 'delete') {
                                context.read<BasketBloc>().add(
                                    DeleteProductBasketEvent(id: product.id));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Ochirildi")),
                                );
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text("Delete"),
                              ),
                            ],
                          ),
                          onTap: () {
                            // Handle tap
                          },
                        ),
                        SizedBox(height: 5.h),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 150.w,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: 40.w,
                                          height: 40.h,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.zero,
                                          ),
                                          child: IconButton(
                                              onPressed: () {
                                                if (product.count != 0) {
                                                  product = product.copyWith(
                                                      count: product.count - 1);
                                                  context.read<BasketBloc>().add(
                                                      UpdateProductBasketEvent(
                                                          product: product));
                                                }else if (product.count == 1){
                                                  context.read<BasketBloc>().add(
                                                      DeleteProductBasketEvent(id: product.id));
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(content: Text("Ochirildi")),
                                                  );
                                                  context.read<BasketBloc>().add(
                                                      UpdateProductBasketEvent(
                                                          product: product));
                                                }

                                              },
                                              icon: SvgPicture.asset(
                                                  'assets/icons/remove.svg')),
                                        ),
                                        Container(
                                          width: 60.w,
                                          height: 40.h,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.zero,
                                              border: Border.all(
                                                  width: 0.5,
                                                  color: Colors.grey.shade500)),
                                          child: Center(
                                              child: Text(
                                            state.products[index].count
                                                .toString(),
                                            style: AppTextStyle.interMedium
                                                .copyWith(fontSize: 20),
                                          )),
                                        ),
                                        Container(
                                          width: 40.w,
                                          height: 40.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.zero,
                                          ),
                                          child: IconButton(
                                              onPressed: () {
                                                product = product.copyWith(
                                                    count: product.count + 1);
                                                context.read<BasketBloc>().add(
                                                    UpdateProductBasketEvent(
                                                        product: product));
                                              },
                                              icon: SvgPicture.asset(
                                                  'assets/icons/add.svg')),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "\$${product.price}",
                                style: AppTextStyle.interMedium.copyWith(
                                    color: AppColors.black, fontSize: 18.w),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  );
                })
              ],
            );
          }
        }));
  }
}
