import 'package:flutter/material.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/modules/webview/webview_screen.dart';
import 'package:news_app/shared/styles/colors.dart';

Widget articleItem(dynamic article ,BNBCubit cubit , BuildContext context)=>
    InkWell(
      onTap:() {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => WebViewScreen(url: article["url"]),)
        );
      },
      child: Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
      children: [
        Container(
          height: 130,
          width: 130,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image:article["urlToImage"]==null?const NetworkImage("https://th.bing.com/th/id/R.5cdff4b062f9ef6bcd16b492a6dd246f?rik=FFOiGa1g2gQu1g&riu=http%3a%2f%2fi.ytimg.com%2fvi%2fPAlFmyd8a8c%2fmaxresdefault.jpg&ehk=kDUc9BDaWOBLoMvlpONaweo54qDGX2kT0S4sMW6sONY%3d&risl=&pid=ImgRaw&r=0"): NetworkImage("${article["urlToImage"]}"),
                  fit: BoxFit.cover
              )
          ),
        ),
        const SizedBox(width: 20,),
        Expanded(
          child: SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "${article["title"]}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style:  TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: cubit.isLight?primaryColor:Colors.cyanAccent
                    ),
                  ),
                ),
                Text(
                  "${article["publishedAt"]}",
                  style:  TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    color: cubit.isLight?primaryColor:Colors.cyan
                  ),
                )
              ],
            ),
          ),
        )
      ],
  ),
),
    );