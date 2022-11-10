import 'package:flutter/material.dart';
import 'package:flutter_udemy_course/module/login/shop_login_screen.dart';
import 'package:flutter_udemy_course/shared/component/component.dart';
import 'package:flutter_udemy_course/shared/network/local/cache_helper.dart';
import 'package:flutter_udemy_course/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String body;

  OnBoardingModel(this.image, this.title, this.body);
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardingController = PageController();

  List<OnBoardingModel> myList = [
    OnBoardingModel(
        "assets/images/gg.png", "on boarding title 1", "on boarding body 1"),
    OnBoardingModel(
        "assets/images/gg.png", "on boarding title 2", "on boarding body 2"),
    OnBoardingModel(
        "assets/images/gg.png", "on boarding title 3", "on boarding body 3"),
  ];

  bool isLast = false;

  void submit() {
    CacheHelper.setData(key: "boarding", value: true).then((value) {
      if (value) {
        navigateAndReplace(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            buildTextButton(
              function: submit,
              text: "skip",
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                height: 500,
                child: PageView.builder(
                  onPageChanged: (index) {
                    if (index == myList.length - 1) {
                      print("is last");
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  physics: BouncingScrollPhysics(),
                  controller: boardingController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      buildOnBoarding(myList[index]),
                  itemCount: 3,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardingController,
                    count: 3,
                    effect: JumpingDotEffect(
                      activeDotColor: primaryColor,
                      dotHeight: 10,
                      dotWidth: 10,
                      jumpScale: .7,
                      verticalOffset: 15,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardingController.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.ease);
                      }
                    },
                    mini: true,
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget buildOnBoarding(OnBoardingModel boarding) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage("${boarding.image}"),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text("${boarding.title}", style: TextStyle(fontSize: 30)),
          SizedBox(
            height: 30,
          ),
          Text("${boarding.body}", style: TextStyle(fontSize: 20))
        ],
      );
}
