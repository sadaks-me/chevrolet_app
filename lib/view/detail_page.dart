import 'dart:async';
import 'dart:math';

import 'package:chevrolet/model/car.dart';
import 'package:chevrolet/utils/reveal/reveal_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class DetailPage extends StatefulWidget {
  final CarModel carModel;

  const DetailPage({Key key, this.carModel}) : super(key: key);

  @override
  _DetailPageState createState() => new _DetailPageState(carModel: carModel);
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  final CarModel carModel;
  AnimationController _containerController;
  Animation<double> _animation, scrollerXTranslation, scrollerOpacity;
  Animation<double> _reverseAnimation;
  bool isRevealed = false;
  double _fraction = 0.0;

  _DetailPageState({this.carModel});

  void initState() {
    super.initState();
    _containerController =
        new AnimationController(duration: new Duration(seconds: 2), vsync: this)
          ..addListener(() {});
    _animation = Tween(begin: 0.0, end: 1.0).animate(_containerController)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      })
      ..addStatusListener((AnimationStatus state) {
        if (state == AnimationStatus.completed) {
          setState(() {
            reset();
          });
        }
      });
    _reverseAnimation =
        Tween(begin: 1.0, end: 0.0).animate(_containerController);

    scrollerXTranslation = new Tween(begin: 60.0, end: 0.0).animate(
      new CurvedAnimation(
        parent: _containerController,
        curve: new Interval(
          0.830,
          1.000,
          curve: Curves.ease,
        ),
      ),
    );
    scrollerOpacity = new Tween(begin: 0.0, end: 1.0).animate(
      new CurvedAnimation(
        parent: _containerController,
        curve: new Interval(
          0.830,
          1.000,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    _containerController.forward();
  }

  @override
  void dispose() {
    _containerController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    reset();
    super.deactivate();
  }

  void reset() {
    _fraction = 0.0;
    isRevealed = true;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    Size screenSize = MediaQuery.of(context).size;
    timeDilation = 0.7;
    return AnimatedBuilder(
      animation: _containerController,
      builder: (context, child) {
        return new SingleChildScrollView(
          child: new Stack(
            children: <Widget>[
              new AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                brightness: isRevealed ? Brightness.light : Brightness.dark,
              ),
              new Material(
                color: isRevealed ? Colors.white : Colors.transparent,
                child: new Hero(
                  tag: "img",
                  child: new SafeArea(
                    top: true,
                    bottom: false,
                    child: new Container(
                      child: new Material(
                          borderRadius: new BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              topLeft: Radius.circular(20.0)),
                          color: Colors.black,
                          elevation: 0.0,
                          child: new Stack(children: <Widget>[
                            new Opacity(
                              opacity: isRevealed ? 0.0 : 1.0,
                              child: new Column(
                                children: <Widget>[
                                  new Stack(
                                    alignment: Alignment.topCenter,
                                    children: <Widget>[
                                      new Container(
                                        height: 55.0,
                                        alignment: Alignment.center,
                                        child: new Container(
                                          decoration: new BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            color: Colors.grey.shade600,
                                          ),
                                          height: 6.0,
                                          width: 25.0,
                                        ),
                                      ),
                                      new Opacity(
                                        opacity: _animation.value,
                                        child: new ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          leading: new BackButton(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Container(
                                        margin: new EdgeInsets.only(left: 15.0),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25.0),
                                        child: new Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            new Text(
                                              carModel.year,
                                              style: textTheme.display3
                                                  .copyWith(
                                                      color: Colors.white70,
                                                      fontFamily: 'Denial',
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                            new SizedBox(
                                              width: 20.0,
                                            ),
                                            new Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: new Text(
                                                '-${int.parse(carModel.year) + 1}',
                                                style: textTheme.headline
                                                    .copyWith(
                                                        color: Colors.black,
                                                        fontFamily: 'Denial',
                                                        shadows: [
                                                          Shadow(
                                                              // bottomLeft
                                                              offset: Offset(
                                                                  -1.5, -1.5),
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.7)),
                                                          Shadow(
                                                              // bottomRight
                                                              offset: Offset(
                                                                  1.5, -1.5),
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.7)),
                                                          Shadow(
                                                              // topRight
                                                              offset: Offset(
                                                                  1.5, 1.5),
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.7)),
                                                          Shadow(
                                                              // topLeft
                                                              offset: Offset(
                                                                  -1.5, 1.5),
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.7)),
                                                        ],
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      new Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: new Image(
                                            image: carModel.image,
                                            height: screenSize.height / 3.5,
                                          )),
                                      Container(
                                        margin: new EdgeInsets.only(left: 15.0),
                                        child: new Stack(
                                          children: <Widget>[
                                            new Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                new Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 25.0,
                                                  ),
                                                  margin: new EdgeInsets.only(
                                                      bottom: 30.0),
                                                  child: new Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      new Column(
                                                        children: <Widget>[
                                                          new Text(
                                                            '1',
                                                            style: textTheme
                                                                .subhead
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          new SizedBox(
                                                            height: 8.0,
                                                          ),
                                                          new Material(
                                                            type: MaterialType
                                                                .circle,
                                                            color:
                                                                Colors.white70,
                                                            child:
                                                                new Container(
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
                                                        style: textTheme.subhead
                                                            .copyWith(
                                                                color: Colors
                                                                    .white70),
                                                      ),
                                                      new SizedBox(
                                                        width: 20.0,
                                                      ),
                                                      new Text(
                                                        '3',
                                                        style: textTheme.subhead
                                                            .copyWith(
                                                                color: Colors
                                                                    .white70),
                                                      ),
                                                      new SizedBox(
                                                        width: 20.0,
                                                      ),
                                                      new Text(
                                                        '4',
                                                        style: textTheme.subhead
                                                            .copyWith(
                                                                color: Colors
                                                                    .white70),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 25.0),
                                                  child: new Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: <Widget>[
                                                      new Text(
                                                        carModel.brand,
                                                        style: textTheme
                                                            .display2
                                                            .copyWith(
                                                                color: Colors
                                                                    .white70,
                                                                fontSize: 40.0,
                                                                letterSpacing:
                                                                    2.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
                                                      ),
                                                      new Text(
                                                        carModel.model,
                                                        style: textTheme
                                                            .display2
                                                            .copyWith(
                                                                color: Colors
                                                                    .white70,
                                                                fontSize: 40.0,
                                                                letterSpacing:
                                                                    2.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
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
                                                  colorBlendMode:
                                                      BlendMode.color,
                                                  color: Colors.white70,
                                                  height: 40.0,
                                                  width: 40.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            new Opacity(
                              opacity: isRevealed ? 1.0 : 0.0,
                              child: new Container(
                                color: Colors.white,
                                child: new Column(
                                  children: <Widget>[
                                    new Stack(
                                      alignment: Alignment.topCenter,
                                      children: <Widget>[
                                        new Container(
                                          height: 55.0,
                                          alignment: Alignment.center,
                                          child: new Container(
                                            decoration: new BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              color: Colors.grey.shade600,
                                            ),
                                            height: 6.0,
                                            width: 25.0,
                                          ),
                                        ),
                                        new Opacity(
                                          opacity: _animation.value,
                                          child: new ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 5.0),
                                            leading: new BackButton(
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Container(
                                          margin:
                                              new EdgeInsets.only(left: 15.0),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: new Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new Text(
                                                carModel.year,
                                                style: textTheme.display3
                                                    .copyWith(
                                                        color: Colors.black,
                                                        fontFamily: 'Denial',
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                              new SizedBox(
                                                width: 20.0,
                                              ),
                                              new Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0),
                                                child: new Text(
                                                  '-${int.parse(carModel.year) + 1}',
                                                  style: textTheme.headline
                                                      .copyWith(
                                                          color: Colors.white,
                                                          fontFamily: 'Denial',
                                                          shadows: [
                                                            Shadow(
                                                                // bottomLeft
                                                                offset: Offset(
                                                                    -1.5, -1.5),
                                                                color: Colors
                                                                    .black),
                                                            Shadow(
                                                                // bottomRight
                                                                offset: Offset(
                                                                    1.5, -1.5),
                                                                color: Colors
                                                                    .black),
                                                            Shadow(
                                                                // topRight
                                                                offset: Offset(
                                                                    1.5, 1.5),
                                                                color: Colors
                                                                    .black),
                                                            Shadow(
                                                                // topLeft
                                                                offset: Offset(
                                                                    -1.5, 1.5),
                                                                color: Colors
                                                                    .black),
                                                          ],
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        new Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: new Image(
                                              image: carModel.image,
                                              fit: BoxFit.contain,
                                              height: screenSize.height / 3.5,
                                            )),
                                        new Container(
                                          margin:
                                              new EdgeInsets.only(left: 15.0),
                                          child: new Stack(
                                            children: <Widget>[
                                              new Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  new Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 25.0,
                                                    ),
                                                    margin: new EdgeInsets.only(
                                                        bottom: 30.0),
                                                    child: new Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        new Column(
                                                          children: <Widget>[
                                                            new Text(
                                                              '1',
                                                              style: textTheme
                                                                  .subhead
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                            ),
                                                            new SizedBox(
                                                              height: 8.0,
                                                            ),
                                                            new Material(
                                                              type: MaterialType
                                                                  .circle,
                                                              color:
                                                                  Colors.black,
                                                              child:
                                                                  new Container(
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
                                                          style: textTheme
                                                              .subhead
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        new SizedBox(
                                                          width: 20.0,
                                                        ),
                                                        new Text(
                                                          '3',
                                                          style: textTheme
                                                              .subhead
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        new SizedBox(
                                                          width: 20.0,
                                                        ),
                                                        new Text(
                                                          '4',
                                                          style: textTheme
                                                              .subhead
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  new Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 25.0),
                                                    child: new Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: <Widget>[
                                                        new Text(
                                                          carModel.brand,
                                                          style: textTheme
                                                              .display2
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      40.0,
                                                                  letterSpacing:
                                                                      2.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900),
                                                        ),
                                                        new Text(
                                                          carModel.model,
                                                          style: textTheme
                                                              .display2
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      40.0,
                                                                  letterSpacing:
                                                                      2.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Positioned(
                                                right: 40.0,
                                                top: 40.0,
                                                child: ClipOval(
                                                  child: new Image.asset(
                                                    'assets/chevrolet.png',
                                                    colorBlendMode:
                                                        BlendMode.color,
                                                    color: Colors.white70,
                                                    height: 40.0,
                                                    width: 40.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    new SizedBox(
                                      height: 20.0,
                                    ),
                                    _buildListScroller(context, Colors.black)
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0.0,
                              right: 0.0,
                              left: 0.0,
                              child: Opacity(
                                opacity: _reverseAnimation.value,
                                child: IgnorePointer(
                                  child: new Container(
                                    alignment: Alignment.bottomCenter,
                                    child: CustomPaint(
                                      painter: new RevealPainter(
                                          _fraction, screenSize, Colors.white),
                                      child: new SizedBox(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ])),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildListScroller(context, color) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    List<Widget> items = [
      new Container(
        height: 120.0,
        padding: new EdgeInsets.only(left: 40),
        child: new Column(
          children: <Widget>[
            new Divider(
              height: 0.5,
              color: color.withOpacity(0.5),
            ),
            new Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                        child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text('Production',
                            style: textTheme.subhead.copyWith(color: color)),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text(
                          carModel.production,
                          style: textTheme.title.copyWith(
                              color: color, fontWeight: FontWeight.w700),
                        )
                      ],
                    )),
                    new Expanded(
                        child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text('Class',
                            style: textTheme.subhead.copyWith(color: color)),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text(
                          'Sportcars',
                          style: textTheme.title.copyWith(
                              color: color, fontWeight: FontWeight.w700),
                        )
                      ],
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
        alignment: Alignment.center,
      ),
      new Container(
        height: 100.0,
        padding: new EdgeInsets.only(left: 40),
        child: new Column(children: <Widget>[
          new Divider(
            height: 0.5,
            color: color.withOpacity(0.5),
          ),
          new Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.centerLeft,
              child: new Text(
                carModel.description,
                style: textTheme.subhead.copyWith(color: color),
              ),
            ),
          )
        ]),
        alignment: Alignment.center,
      ),
    ];
    return new Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: new Transform(
        transform: new Matrix4.translationValues(
          0.0,
          scrollerXTranslation.value,
          0.0,
        ),
        child: new Opacity(
          opacity: scrollerOpacity.value,
          child: new Column(
            children: items,
          ),
        ),
      ),
    );
  }
}
