import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testdeliverysidebar/consts.dart';
import 'package:testdeliverysidebar/model/food_model.dart';

class DetailPage extends StatefulWidget {
  final FoodModel data;

  DetailPage(this.data);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int number = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenColor,
      body: Stack(
        children: <Widget>[
          Positioned(top: 0.0, right: 0.0, left: 0.0, child: _customAppBar()),
          Align(
            alignment: Alignment.bottomCenter,
            child: _customDetailSheet(),
          ),
          _customFoodImage(),
        ],
      ),
    );
  }

  Widget _customFoodImage() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 65.0,
          left: 30.0,
          right: 30.0,
          child: Container(
            margin: EdgeInsets.only(bottom: 16.0),
            height: MediaQuery.of(context).size.height * .38,
            width: MediaQuery.of(context).size.width * .7,
            decoration: BoxDecoration(
//              color: Colors.red,
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/bg.png"),
            )),
          ),
        ),
        Positioned(
          top: 65.0,
          left: 30.0,
          right: 30.0,
          child: Hero(
            tag: widget.data.imgPath,
            child: Container(
              margin: EdgeInsets.only(bottom: 16.0),
              height: MediaQuery.of(context).size.height * .3,
              width: MediaQuery.of(context).size.width * .1,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/${widget.data.imgPath}"),
              )),
            ),
          ),
        )
      ],
    );
  }

  Widget _customDetailSheet() {
    return Material(
      elevation: 10.0,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35.0), topRight: Radius.circular(35.0)),
      child: Container(
        height: MediaQuery.of(context).size.height * .5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black45,
                blurRadius: 15.0,
                offset: Offset(0.0, 8.0))
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35.0), topRight: Radius.circular(35.0)),
        ),
        child: _customDetailSheetMaterial(),
      ),
    );
  }

  Widget _customDetailSheetMaterial() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.data.name,
            style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 12.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "\$ ${(widget.data.price) * number}",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 40.0,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * .26,
                  height: MediaQuery.of(context).size.height * .06,
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                      color: AppColors.greenColor,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          setState(() {
                            number -= 1;
                          });
                        },
                        child: Icon(
                          Icons.remove,
                          size: 18.0,
                        ),
                      ),
                      Text(
                        number.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 26.0),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            number += 1;
                          });
                        },
                        child: Icon(
                          Icons.add,
                          size: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Weight",
                    style: TextStyle(color: Colors.black87, fontSize: 22.0),
                  ),
                  Text(
                    "${widget.data.weight} gm",
                    style: TextStyle(
                        color: AppColors.redColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Calories",
                    style: TextStyle(color: Colors.black87, fontSize: 22.0),
                  ),
                  Text(
                    "${widget.data.calory} ccal",
                    style: TextStyle(
                        color: AppColors.redColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Protein",
                    style: TextStyle(color: Colors.black87, fontSize: 22.0),
                  ),
                  Text(
                    "${widget.data.protein} gm",
                    style: TextStyle(
                        color: AppColors.redColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(widget.data.item , style: TextStyle(color: Colors.blueAccent , fontSize: 16.0),),
          SizedBox(height: 20.0,),
          Expanded(
            child: Material(
              elevation: 3.0,
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  border: Border.all(color: Colors.black38, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),
                child: Center(
                  child: Text("Add to Cart" , style: TextStyle(color: Colors.black87 , fontSize: 28.0),),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _customAppBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 36.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 22.0,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Center(
              child: Icon(
                Icons.lock,
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
