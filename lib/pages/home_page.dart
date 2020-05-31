import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:testdeliverysidebar/consts.dart';
import 'package:testdeliverysidebar/model/food_model.dart';
import 'dart:math' as math;

import 'package:testdeliverysidebar/widgets/app_clipper.dart';

import 'detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FoodModel> foodModel = FoodModel.list;
  PageController _pageController = PageController(viewportFraction: .8);
  var paddingLeft = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: _buildingRightSection(),
            ),
            Container(
              padding: EdgeInsets.only(top: 40.0),
              color: AppColors.greenColor,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * .15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        image: DecorationImage(
                            image:
                                ExactAssetImage("assets/images/profile.jpg"))),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 12.0),
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        color: Colors.white),
                    child: Center(
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.black,
                        size: 28.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Transform.rotate(
                angle: -math.pi / 2,
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _buildMenu("Vegetables", 0),
                        _buildMenu("Chicken", 1),
                        _buildMenu("Beef", 2),
                        _buildMenu("Thai", 3),
                      ],
                    ),
                    AnimatedContainer(
                      margin: EdgeInsets.only(left: paddingLeft),
                      width: 140.0,
                      height: 70.0,
                      duration: Duration(
                        milliseconds: 250,
                      ),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: ClipPath(
                              clipper: AppClipper(),
                              child: Container(
                                width: 150.0,
                                height: 50.0,
                                color: AppColors.greenColor,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Transform.rotate(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.0,
                                ),
                              ),
                              angle: math.pi / 2,
                            ),
                          )
                        ],
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
  }

  Widget _buildMenu(String menu, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          paddingLeft = index * 115.0;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .3,
        padding: EdgeInsets.only(top: 28.0),
        child: Center(
          child: Text(
            menu,
            style: TextStyle(
                fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildingRightSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Column(
        children: <Widget>[
          _customAppBar(),
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  child: PageView.builder(
                      itemCount: foodModel.length,
                      physics: BouncingScrollPhysics(),
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailPage(foodModel[index])),);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30.0),
                            child: Stack(
                              children: <Widget>[
                                _buildBackgroundItems(index),
                                Positioned(
                                  right: 15.0,
                                  top: 15.0,
                                  child: Transform.rotate(
                                    child: Hero(
                                      tag: foodModel[index].imgPath,
                                      child: Image(
                                        image: AssetImage(
                                            "assets/images/${foodModel[index].imgPath}"),
                                        width: 150.0,
                                      ),
                                    ),
                                    angle: math.pi / 3,
                                  ),
                                ),
                                Positioned(
                                  bottom: 5.0,
                                  right: 35.0,
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: AppColors.redColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20.0)),
                                    ),
                                    child: Text(
                                      "\$ ${foodModel[index].price.toInt()}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                  height: MediaQuery.of(context).size.height * .45,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40.0),
                  child: Text(
                    "Popular",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
                _buildPopularList(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBackgroundItems(var index) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, bottom: 15.0, right: 10.0),
      margin: EdgeInsets.only(top: 50.0, bottom: 20.0, right: 50.0),
      decoration: BoxDecoration(
          color: AppColors.greenColor,
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: SizedBox(),
          ),
          Row(
            children: <Widget>[
              RatingBar(
                initialRating: 3.0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 14,
                unratedColor: Colors.black12,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder: (context, _) {
                  return Icon(
                    Icons.star,
                    color: Colors.black,
                  );
                },
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                "(120 Review)",
                style: TextStyle(fontSize: 14.0),
              )
            ],
          ),
          Text(
            "${foodModel[index].name}",
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _buildPopularList() {
    return ListView.builder(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.only(left: 32.0, bottom: 16.0, top: 20.0),
        shrinkWrap: true,
        itemCount: foodModel.length,
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.only(bottom: 16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      bottomLeft: Radius.circular(12.0))),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    "assets/images/${foodModel[index].imgPath}",
                    width: 100.0,
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 130.0,
                        child: Text(
                          "${foodModel[index].name}",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "\$ ${foodModel[index].price.toInt()} ",
                            style: TextStyle(
                                fontSize: 22,
                                color: AppColors.redColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Text(
                            "(${foodModel[index].weight.toInt()}) gm Weight",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ));
        });
  }

  Widget _customAppBar() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          RichText(
            text: TextSpan(
                text: "Hollo\n ",
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                      text: "Shailee Weedly",
                      style: TextStyle(
                          color: AppColors.greenColor,
                          fontWeight: FontWeight.bold,
                          height: 1.5))
                ]),
          ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                color: AppColors.greenColor),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Search"),
                  ),
                ),
                Icon(
                  Icons.search,
                  size: 22.0,
                )
              ],
            ),
          )),
          SizedBox(
            width: 16.0,
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            child: Center(
              child: Icon(
                Icons.shopping_basket,
                color: Colors.black,
                size: 22.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
