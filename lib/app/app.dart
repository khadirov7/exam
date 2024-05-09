import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_exam_4/blocs/basket/basket_bloc.dart';
import 'package:nt_exam_4/blocs/product/product_event.dart';
import 'package:nt_exam_4/blocs/product/products_bloc.dart';
import 'package:nt_exam_4/data/repositories/basket_repository.dart';
import 'package:nt_exam_4/data/repositories/products_repositories.dart';

import '../screens/route.dart';

class App extends StatelessWidget {
  App({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => ProductsRepository()),
          RepositoryProvider(create: (_) => BasketRepository()),

        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) =>
                      ProductBloc(productsRepository: context.read<ProductsRepository>())),
              BlocProvider(
                  create: (context) =>
                      BasketBloc(basketRepository: context.read<BasketRepository>())),
            ],
            child: ScreenUtilInit(
                designSize: const Size(360, 800),
                builder: (context, child) {
                  ScreenUtil.init(context);
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    initialRoute: RouteNames.homeScreen,
                    navigatorKey: navigatorKey,
                    onGenerateRoute: AppRoutes.generateRoute,
                  );
                })));
  }
}
