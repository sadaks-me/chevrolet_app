import 'dart:math';

import 'package:chevrolet/view/detail_page.dart';
import 'package:chevrolet/model/car.dart';
import 'package:flutter/material.dart';

Positioned frontCard(
  CarModel carModel,
  double bottom,
  double right,
  double left,
  double cardWidth,
  double rotation,
  double skew,
  BuildContext context,
  ValueChanged<DismissDirection> onDismissed,
  int flag,
) {
  final ThemeData theme = Theme.of(context);
  final TextTheme textTheme = theme.textTheme;
  Size screenSize = MediaQuery.of(context).size;

  return new Positioned(
    bottom: bottom,
    right: flag == 0 ? right != 0.0 ? right : null : null,
    left: flag == 1 ? right != 0.0 ? right : null : null,
    child: new Dismissible(
      key: new UniqueKey(),
      crossAxisEndOffset: -0.3,
      onResize: () {},
      onDismissed: (DismissDirection direction) {
        onDismissed(direction);
      },
      child: new Transform(
        alignment: flag == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
        //transform: null,
        transform: new Matrix4.skewX(skew),
        //..rotateX(-math.pi / rotation),
        child: new RotationTransition(
          turns: new AlwaysStoppedAnimation(
              flag == 0 ? rotation / 360 : -rotation / 360),
          child: new Hero(
            tag: "img",
            child: new GestureDetector(
              onTap: () {
                Navigator.of(context).push(new PageRouteBuilder(
                  transitionDuration: new Duration(seconds: 1),
                  barrierDismissible: true,
                  pageBuilder: (_, __, ___) =>
                      new DetailPage(carModel: carModel),
                ));
              },
              child: SingleChildScrollView(
                child: new Material(
                  color: Colors.black,
                  elevation: 4.0,
                  borderRadius: new BorderRadius.only(topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
                  child: new ClipRRect(
                    borderRadius: new BorderRadius.only(topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
                    child: new Container(
                      alignment: Alignment.center,
                      width: screenSize.width,
                      height: screenSize.height / 1.4,
                      child: new Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          new Container(
                            margin: new EdgeInsets.symmetric(vertical: 10.0),
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.grey.shade600,
                            ),
                            height: 6.0,
                            width: 25.0,
                          ),
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                margin: new EdgeInsets.only(left: 15.0),
                                padding: EdgeInsets.symmetric(horizontal: 25.0),
                                child: new Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                      carModel.year,
                                      style: textTheme.display3.copyWith(
                                          color: Colors.white70,
                                          fontFamily: 'Denial',
                                          fontWeight: FontWeight.w500),
                                    ),
                                    new SizedBox(
                                      width: 20.0,
                                    ),
                                    new Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: new Text(
                                        '-${int.parse(carModel.year) + 1}',
                                        style: textTheme.headline.copyWith(
                                            color: Colors.black,
                                            fontFamily: 'Denial',
                                            shadows: [
                                              Shadow(
                                                  // bottomLeft
                                                  offset: Offset(-1.5, -1.5),
                                                  color: Colors.grey
                                              ),
                                              Shadow(
                                                  // bottomRight
                                                  offset: Offset(1.5, -1.5),
                                                  color: Colors.grey),
                                              Shadow(
                                                  // topRight
                                                  offset: Offset(1.5, 1.5),
                                                  color: Colors.grey),
                                              Shadow(
                                                  // topLeft
                                                  offset: Offset(-1.5, 1.5),
                                                  color: Colors.grey),
                                            ],
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              new Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  child: new Image(image: carModel.image, height: screenSize.height / 3.5,)),
                              new Container(
                                margin: new EdgeInsets.only(left: 15.0),
                                child: new Stack(
                                  children: <Widget>[
                                    new Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 25.0,
                                          ),
                                          margin: new EdgeInsets.only(bottom: 30.0),
                                          child: new Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new Column(
                                                children: <Widget>[
                                                  new Text(
                                                    '1',
                                                    style: textTheme.subhead
                                                        .copyWith(
                                                            color: Colors.white70),
                                                  ),
                                                  new SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  new Material(
                                                    type: MaterialType.circle,
                                                    color: Colors.white70,
                                                    child: new Container(
                                                      height: 3.0,
                                                      width: 3.0,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              new SizedBox(
                                                width: 20.0,
                                              ),
                                              new Text(
                                                '2',
                                                style: textTheme.subhead.copyWith(
                                                    color: Colors.white70),
                                              ),
                                              new SizedBox(
                                                width: 20.0,
                                              ),
                                              new Text(
                                                '3',
                                                style: textTheme.subhead.copyWith(
                                                    color: Colors.white70),
                                              ),
                                              new SizedBox(
                                                width: 20.0,
                                              ),
                                              new Text(
                                                '4',
                                                style: textTheme.subhead.copyWith(
                                                    color: Colors.white70),
                                              ),
                                            ],
                                          ),
                                        ),
                                        new Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: new Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              new Text(
                                                carModel.brand,
                                                style: textTheme.display1.copyWith(
                                                    color: Colors.white70,
                                                    fontSize: 30.0,
                                                    letterSpacing: 2.0,
                                                    fontWeight: FontWeight.w900),
                                              ),
                                              new Text(
                                                carModel.model,
                                                style: textTheme.display1.copyWith(
                                                    color: Colors.white70,
                                                    fontSize: 30.0,
                                                    letterSpacing: 2.0,
                                                    fontWeight: FontWeight.w900),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Positioned(
                                      right: 40.0,
                                      top: 40.0,
                                      child: ClipOval(
                                        child: new Image.asset(
                                          'assets/chevrolet.png',
                                          colorBlendMode: BlendMode.color,
                                          color: Colors.white70,
                                          height: 40.0,
                                          width: 40.0,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
