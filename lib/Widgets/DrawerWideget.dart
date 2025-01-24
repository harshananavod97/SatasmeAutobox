import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  final String title;
  final IconData iconData;
  final Function() onTap;

  DrawerWidget(
      {required this.title, required this.iconData, required this.onTap});

  @override
  DrawerWidgetState createState() => DrawerWidgetState();
}

class DrawerWidgetState extends State<DrawerWidget> {
  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return inkWellWidget(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  child: Icon(
                    widget.iconData,
                    size: 25,
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Text(widget.title, style: primaryTextStyle()),
                ),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget inkWellWidget({Function()? onTap, required Widget child}) {
  return InkWell(
      onTap: onTap,
      child: child,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent);
}

TextStyle primaryTextStyle({int? size, Color? color, FontWeight? weight}) {
  return TextStyle(
    fontSize: size != null ? size.toDouble() : 16,
    color: Colors.black,
    fontWeight: weight ?? FontWeight.normal,
  );
}
