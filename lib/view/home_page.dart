import 'dart:async';
import 'package:chevrolet/controller/data.dart';
import 'package:chevrolet/view/back_card.dart';
import 'package:chevrolet/view/front_card.dart';
import 'package:chevrolet/model/car.dart';

//import 'package:animation_exp/PageReveal/page_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  PageController pageController;
  PageController textController;
  AnimationController _buttonController;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;
  Animation<double> width;
  int flag = 0;

  List<CarModel> data = carsData;

  List<int> dummyCount = [1, 2];

  int page = 0;

  void initState() {
    super.initState();
    page = data.length ~/ 2;

    textController = new PageController(
      initialPage: page,
      viewportFraction: 0.25,
    );

    pageController = new PageController(initialPage: data.length ~/ 2);

    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    rotate = new Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          var i = data.removeLast();
          data.insert(0, i);

          _buttonController.reset();
        }
      });
    });
    right = new Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    bottom = new Tween<double>(
      begin: 0.0,
      end: 100.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    width = new Tween<double>(
      begin: 20.0,
      end: 25.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    timeDilation = 0.4;

    double backCardWidth = - 10.0;
    return new Scaffold(
      appBar: new AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: new BackButton(
          color: Colors.black,
        ),
        title: new Text(
          'Timeline',
          style: textTheme.subhead.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: new Container(
        alignment: Alignment.bottomCenter,
        child: new Column(
          children: <Widget>[
            Container(
              height: 40.0,
              child: new PageView.builder(
                  controller: textController,
                  pageSnapping: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      child: index == page
                          ? new Text(
                              carsData[index].year,
                              style: textTheme.display1.copyWith(
                                  fontWeight: FontWeight.w700,fontFamily: 'Denial',
                                  fontSize: 36.0,
                                  color: Colors.black),
                            )
                          : new Text(
                              carsData[index].year,
                              style: textTheme.display1.copyWith(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.0,
                                fontFamily: 'Denial',
                                fontSize: 34.0,
                                color: Colors.grey.shade100,
                                shadows: [
                                  Shadow(
                                      // bottomLeft
                                      offset: Offset(-1.5, -1.5),
                                      color: Colors.black),
                                  Shadow(
                                      // bottomRight
                                      offset: Offset(1.5, -1.5),
                                      color: Colors.black),
                                  Shadow(
                                      // topRight
                                      offset: Offset(1.5, 1.5),
                                      color: Colors.black),
                                  Shadow(
                                      // topLeft
                                      offset: Offset(-1.5, 1.5),
                                      color: Colors.black),
                                ],
                              ),
                            ),
                    );
                  },
                  onPageChanged: (pageNum) {
                    setState(() {
                      page = pageNum;
                      pageController.jumpToPage(textController.page.round());
                    });
                  }),
            ),
            new Expanded(
              child: new PageView.builder(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                pageSnapping: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return new Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        (((index - 2) < 0) || (page > data.length - 3))
                            ? new SizedBox()
                            : backCard(null, 20.0, backCardWidth,
                            context),
                        (((index - 1) < 0) || (page > data.length - 2))
                            ? new SizedBox()
                            : backCard(null, 10.0, backCardWidth + 30,
                            context),
                        (((index - 1) < 0) || (page > data.length - 2))
                            ? new SizedBox()
                            : backCard(data[page == 0 ? page : page - 1], 0.0, backCardWidth + 30, context),
                        frontCard(
                          data[index],
                          bottom.value,
                          right.value,
                          0.0,
                          backCardWidth + 10,
                          rotate.value,
                          rotate.value < -10 ? 0.1 : 0.0,
                          context,
                          (direction) {
                            print('index: $page');
                            setState(() {
                              if (direction == DismissDirection.endToStart) {
                                pageController?.jumpToPage(page.round() + 1);
                              } else if (direction ==
                                  DismissDirection.startToEnd) {
                                pageController?.jumpToPage(page.round() - 1);
                              }
                            });
                          },
                          flag,
                        )
                      ]);
                },
                onPageChanged: (pageNum) {
                  setState(() {
                    page = pageNum;
                    textController.animateToPage(page.round(),
                        duration: new Duration(milliseconds: 300),
                        curve: Curves.ease);
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
