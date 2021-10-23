import 'dart:math';
import 'package:control/widgets/CustomWidgets.dart';
import 'package:control/widgets/ControlPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control Panel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade800,
      body: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: <Widget>[
          Transform.translate(
            offset: Offset(0,-MediaQuery.of(context).size.height / 3),
            child: Hero(
              tag: 'background',
              flightShuttleBuilder: (
                BuildContext flightContext,
                Animation<double> animation,
                HeroFlightDirection flightDirection,
                BuildContext fromHeroContext,
                BuildContext toHeroContext,
              ){
                Animation<double> newAnimation = Tween<double>(begin: 0, end: 0.3).animate(animation);
                return RotationTransition(
                  turns: newAnimation,
                  child: Material(
                    color: Colors.transparent,
                    child: toHeroContext.widget
                  ),
                );
              },
              child: Transform.rotate(
                angle: pi / 6,
                child: SvgPicture.asset(
                  'assets/images/Circles.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Hero(
                      tag: 'leading',
                      child: Text(
                        'Control\nPanel',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ),
                    Hero(
                      tag: 'trailing',
                      child: SvgPicture.asset('assets/images/user.svg')
                    )
                  ],
                ),
              ),
              Hero(
                tag: 'head',
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                    left: 20,
                    top: 30
                  ),
                  child: Text(
                    'All Rooms',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.grey.shade100
                  ),
                ),
              ),
              Flexible(
                child: Hero(
                  tag: 'body',
                  child: Container(
                    color: Colors.grey.shade100,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      padding: EdgeInsets.only(top: 30),
                      children: <Widget>[
                        ListItem(
                          image: 'assets/images/bed.svg',
                          title: 'Bed room',
                          lights: 4,
                          function: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_)=>ControlPage(
                              title: 'Bed\nRoom', lights: 4
                            ))
                          ),
                        ),
                        ListItem(
                          image: 'assets/images/room.svg',
                          title: 'Living room',
                          lights: 2
                        ),
                        ListItem(
                          image: 'assets/images/kitchen.svg',
                          title: 'Kitchen',
                          lights: 5
                        ),
                        ListItem(
                          image: 'assets/images/bathtube.svg',
                          title: 'Bathroom',
                          lights: 1
                        ),
                        ListItem(
                          image: 'assets/images/house.svg',
                          title: 'Outdoor',
                          lights: 5
                        ),
                        ListItem(
                          image: 'assets/images/balcony.svg',
                          title: 'Balcony',
                          lights: 2
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SvgPicture.asset('assets/images/bulb.svg'),
                    SvgPicture.asset('assets/images/Icon feather-home.svg'),
                    SvgPicture.asset('assets/images/Icon feather-settings.svg'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
