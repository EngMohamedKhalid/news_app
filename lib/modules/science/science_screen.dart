import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/component/article_item.dart';
import 'package:news_app/shared/styles/colors.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BNBCubit,BNBStates>(
      listener : (context, state) {},
      builder: (context, state) {
        var list = BNBCubit.getObject(context).science;
        var cubit = BNBCubit.getObject(context);
        return ConditionalBuilder(
          condition:list.isNotEmpty ,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return articleItem(list[index] , cubit ,context);
            },
            separatorBuilder: (context, index) => Container(
              margin:const EdgeInsets.symmetric(horizontal: 20),
              height: 1,
              color: primaryColor,
            ),
          ),
          fallback: (context) =>  Center(child: CircularProgressIndicator(color: primaryColor,)),
        );
      },
    );
  }
}
