import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/BNB_layout/bnb_news_layout.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/component/block_observer.dart';
import 'package:news_app/shared/network/local/cach_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/colors.dart';

void main()async {
  //https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=b279858c8f624136aa7d2bfb33e01903
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();
 bool? isDark = CashHelper.getPool(key: "key");
  runApp( MyApp(isDark: isDark,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key ,this.isDark});
  final bool? isDark;
  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocProvider(
      create: (context) => BNBCubit()
        ..getBusiness()
        ..getScience()
        ..getSorts()
        ..changeLight(fromShared: isDark),
      child: BlocConsumer<BNBCubit,BNBStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BNBCubit.getObject(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                      backgroundColor: primaryColor,
                      titleTextStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      systemOverlayStyle: const SystemUiOverlayStyle(
                        statusBarColor: Colors.black12,
                        statusBarIconBrightness: Brightness.light,
                      )),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: primaryColor,
                      elevation: 12.5)),
              darkTheme: ThemeData(
                  appBarTheme: const AppBarTheme(
                      backgroundColor: Color(0xff333739),
                      titleTextStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Color(0xff333739),
                        statusBarIconBrightness: Brightness.light,
                      )),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      backgroundColor: Color(0xff333739),
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.white,
                      unselectedItemColor: Colors.grey,
                      elevation: 12.5),
                  scaffoldBackgroundColor: const Color(0xff333739)),
              themeMode: cubit.isLight?ThemeMode.light:ThemeMode.dark,
              home: const BNBNewsLayout(),
            ),
          );
        },
      ),
    );
  }
}
