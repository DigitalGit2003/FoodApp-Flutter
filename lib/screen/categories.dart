import 'package:flutter/material.dart';
import 'package:food_app/modles/food_categories_modle.dart';
import 'package:food_app/screen/detail_page.dart';
import 'package:food_app/screen/home_page.dart';
import 'package:food_app/screen/widget/bottom_Container.dart';

// ignore: must_be_immutable
class Categories extends StatelessWidget {
  List<FoodCategoriesModle> list = [];
  // List<CategoriesModle> list = [];
  Categories({required this.list});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (contet) => HomePage()));
            },
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: GridView.count(
              shrinkWrap: false,
              primary: false,
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: list
                  .map(
                    (e) => BottomContainer(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              image: e.image,
                              name: e.name,
                              price: e.price,
                            ),
                          ),
                        );
                      },
                      image: e.image,
                      price: e.price,
                      name: e.name,
                    ),
                  )
                  .toList()),
        ));
  }
}
