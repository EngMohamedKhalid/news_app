import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/search/search_screen.dart';

class BNBNewsLayout extends StatelessWidget {
  const BNBNewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <BNBCubit,BNBStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BNBCubit.getObject(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
                "News app "
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder:(context) =>  SearchScreen(),)
                    );
                  },
                  icon:const Icon(
                    Icons.search,
                    size: 30,
                  ),
              ),
              IconButton(
                  onPressed: () {
                    cubit.changeLight();
                    },
                  icon: Icon(
                   cubit.isLight?Icons.dark_mode :Icons.brightness_4_outlined,
                    size: 30,
                  ),
              ),
            ],
          ),
          bottomNavigationBar:BottomNavigationBar(
            onTap: (value) {
              cubit.changeCurrent(value);
            },
            currentIndex: cubit.current,
            items:cubit.bottomNavigationBarItems
          ) ,
          body:cubit.screens[cubit.current] ,

        );
      },
    );
  }
  // void getHttp() async {
  //   try {
  //     var response = await Dio().get("https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=b279858c8f624136aa7d2bfb33e01903");
  //     print("=======================$response==========================");
  //   } catch (e) {
  //     print("======$e=======");
  //   }
  // }
}
