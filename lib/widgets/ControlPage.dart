import 'dart:async';
import 'dart:math';
import 'package:control/widgets/CustomWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ControlPage extends StatefulWidget {

  final String title;
  final int lights;

  ControlPage({
    required this.title,
    required this.lights
  });
  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> with SingleTickerProviderStateMixin{

  double _value = 100;
  Color _color = Colors.orangeAccent;
  late AnimationController _animationController;
  late Animation<double> _translateItems;
  late Curve _curve;

  @override
  initState() {
    _curve = Curves.easeOut;
    _animationController = AnimationController(vsync: this, duration: Duration(
      milliseconds: 300
    ));
    _animationController.addListener(() {
      setState(() {});
    });
    _translateItems = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 1, curve: _curve,),
    ));
    Timer(Duration(seconds: 1), animate);
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade800,
      body: Stack(
        fit: StackFit.loose,
        alignment: Alignment.center,
        children: <Widget>[
          Transform.translate(
            offset: Offset(0,-MediaQuery.of(context).size.height / 3),
            child: Hero(
              tag: 'background',
              child: Transform.rotate(
                angle: pi,
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
                padding: const EdgeInsets.only(
                  left: 10, right: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 30, left: 20
                      ),
                      child: GestureDetector(
                        onTap: ()=>Navigator.pop(context),
                        child: Hero(
                          tag: 'leading',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.arrow_back,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    widget.title.split('\n').first,
                                    style: Theme.of(context).textTheme.headline4!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
                                  )
                                ],
                              ),
                              Stack(
                                children: <Widget>[
                                  Text(
                                    widget.title.split('\n').last,
                                    style: Theme.of(context).textTheme.headline4!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
                                  ),
                                  Transform(
                                    transform: Matrix4.translationValues(
                                      0,
                                      _translateItems.value * 40,
                                      0
                                    ),
                                    child: Text(
                                      '${widget.lights} Lights',
                                      style: Theme.of(context).textTheme.headline6!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orangeAccent.withOpacity(_translateItems.value)
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Transform(
                      transform: Matrix4.translationValues(
                        0,
                        - 10 + _translateItems.value * 10,
                        0
                      ),
                      child: Hero(
                        tag: 'trailing', child: Stack(
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/images/light bulb.svg',
                              color: _color.withOpacity(_value / 100),
                            ),
                            SvgPicture.asset(
                              'assets/images/Group 38.svg',
                            ),
                          ],
                        )
                      ),
                    ),                    
                  ],
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(
                  300 - _translateItems.value * 300,
                  0,
                  0
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: <Widget>[
                      HeadItems(
                        icon: 'assets/images/surface1.svg',
                        label: 'Main Light',
                        opacity: _translateItems.value,
                      ),
                      HeadItems(
                        icon: 'assets/images/furniture-and-household.svg',
                        label: 'Desk Lights',
                        opacity: _translateItems.value,
                        selected: true,
                      ),
                      HeadItems(
                        icon: 'assets/images/bed (1).svg',
                        label: 'Bed Light',
                        opacity: _translateItems.value,
                      ),
                    ],
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  Hero(
                    tag: 'head',
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.only(
                        left: 20,
                        top: 15
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: Colors.grey.shade100
                      ),
                      child: Text(
                        'Intensity',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        'assets/images/Icon awesome-power-off.svg',
                      ),
                    ),
                  ),
                ],
              ),
              Hero(
                tag: 'body',
                child: Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.grey.shade100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SvgPicture.asset('assets/images/solution2.svg'),
                            Expanded(
                              child: Slider(
                                value: _value.toDouble() * _translateItems.value,
                                thumbColor: Colors.white,
                                divisions: 6,
                                min: 0,
                                max: 100,
                                activeColor: Colors.yellow,
                                inactiveColor: Colors.yellow.withOpacity(0.2),
                                onChanged: (values){
                                  setState(() {
                                    _value = values;
                                  });
                                }
                              ),
                            ),
                            SvgPicture.asset('assets/images/solution.svg'),
                          ],
                        ),
                        Text(
                          '\t\t\tColors',
                          style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Row(
                            children: <Widget>[
                              CustomTransform(
                                color: Colors.redAccent,
                                x: _translateItems.value * 50,
                                y: 0,
                                z: 0,
                                function: (){
                                  setState(() {
                                    _color = Colors.redAccent;
                                  });
                                },
                              ),
                              CustomTransform(
                                color: Colors.greenAccent.shade400,
                                x: -10 + _translateItems.value * 70,
                                y: 0,
                                z: 0,
                                function: (){
                                  setState(() {
                                    _color = Colors.greenAccent.shade400;
                                  });
                                },
                              ),
                              CustomTransform(
                                color: Colors.blueAccent,
                                x: -20 + _translateItems.value * 90,
                                y: 0,
                                z: 0,
                                function: (){
                                  setState(() {
                                    _color = Colors.blueAccent;
                                  });
                                },
                              ),
                              CustomTransform(
                                color: Colors.deepPurpleAccent,
                                x: -30 + _translateItems.value * 110,
                                y: 0,
                                z: 0,
                                function: (){
                                  setState(() {
                                    _color = Colors.deepPurpleAccent;
                                  });
                                },
                              ),
                              CustomTransform(
                                color: Colors.orangeAccent,
                                x: -40 + _translateItems.value * 130,
                                y: 0,
                                z: 0,
                                function: (){
                                  setState(() {
                                    _color = Colors.orangeAccent;
                                  });
                                },
                              ),
                              Transform(
                                transform: Matrix4.translationValues(
                                  -50 + _translateItems.value * 150,
                                  0,
                                  0
                                ),
                                child: CircleAvatar(
                                  child: SvgPicture.asset('assets/images/+.svg'),
                                  backgroundColor: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '\t\t\tScenes',
                          style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade50,
                  child: GridView.count(
                    childAspectRatio: 3,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 2
                    ),
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    children: <Widget>[
                      GridItem(
                        label: 'Birthday',
                        start: Colors.redAccent,
                        x: - 10 + _translateItems.value * 10,
                        y: 0,
                        z: 0,
                      ),
                      GridItem(
                        label: 'Party',
                        start: Colors.deepPurpleAccent,
                        x: - 100 + _translateItems.value * 100,
                        y: 0,
                        z: 0,
                      ),
                      GridItem(
                        label: 'Relax',
                        start: Colors.blue,
                        x: - 10 + _translateItems.value * 10,
                        y: 0,
                        z: 0,
                      ),
                      GridItem(
                        label: 'Fun',
                        start: Colors.lightGreenAccent,
                        x: - 100 + _translateItems.value * 100,
                        y: 0,
                        z: 0,
                      ),                          
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
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