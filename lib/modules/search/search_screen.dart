import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/component/article_item.dart';
import 'package:news_app/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
 final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BNBCubit,BNBStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = BNBCubit.getObject(context).search;
        var cubit = BNBCubit.getObject(context);
        return Scaffold(
          appBar: AppBar(
            title:const Text("Search"),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15
                ),
                child: TextFormField(
                  style: TextStyle(
                    color: primaryColor
                  ),
                  onChanged: (value) {
                    cubit.getSearch(value);
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 28,
                      ),
                      label:const Text(
                        "Search",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:const BorderSide(
                          color: Colors.grey
                        )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:const BorderSide(
                              color: Colors.grey
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:const BorderSide(
                              color: Colors.grey
                          )
                      ),
                  ),
                ),
              ),
              Expanded(child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) => articleItem(list[index], cubit ,context),
              ))
            ],
          ),
        );
      },
    );
  }
}
