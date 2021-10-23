import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListItem extends StatelessWidget {

  final String image;
  final String title;
  final int lights;
  final void Function()? function;


  ListItem({
    required this.image,
    required this.title,
    required this.lights,
    this.function
  });
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.function,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 2,
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SvgPicture.asset(this.image),
              Text(
                this.title,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                ),
              ),
              Text(
                '${this.lights} Lights',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow.shade700
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {

  final String label;
  final Color start;
  final double x;
  final double y;
  final double z;

  GridItem({
    required this.label,
    required this.start,
    required this.x,
    required this.y,
    required this.z
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(
        this.x, this.y, this.z
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: <Color>[
              this.start,
              this.start,
              this.start.withOpacity(0.7),
            ],
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SvgPicture.asset('assets/images/surface2.svg'),
            Text(
              ''+this.label+'\t\t',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white
              ),
            )
          ]
        ),
      ),
    );
  }
}

class HeadItems extends StatelessWidget {

  final String icon;
  final String label;
  final bool selected;
  final double opacity;

  HeadItems({
    required this.icon,
    required this.label,
    required this.opacity,
    this.selected = false
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: this.selected ? Colors.blue.shade900.withOpacity(this.opacity) : Colors.white.withOpacity(this.opacity),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Opacity(
              opacity: this.opacity,
              child: SvgPicture.asset(
                this.icon,
              ),
            ),
            Text(
              '\t\t'+this.label+'',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.w700,
                color: this.selected ? Colors.white.withOpacity(this.opacity) : Colors.blue.shade900.withOpacity(this.opacity)
              ),
            )
          ]
        ),
      ),
    );
  }
}

class CustomTransform extends StatelessWidget {
  
  final Color color;
  final double x;
  final double y;
  final double z;
  final void Function()? function;

  CustomTransform({
    required this.color,
    required this.x,
    required this.y,
    required this.z,
    this.function
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(
        this.x,this.y,this.z
      ),
      child: GestureDetector(
        onTap: this.function,
        child: CircleAvatar(
          backgroundColor: this.color.withOpacity(0.5),
        ),
      ),
    );
  }
}