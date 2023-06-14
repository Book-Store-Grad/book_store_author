import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultButton extends StatelessWidget {
  final double width;
  final double? height;
  final Color background;
  final Color textColor;
  final double textSize;
  final FontWeight textWeight;
  final double radius;
  final Function() function;
  final String text;
  final String icon;
  final Color borderColor;

  const DefaultButton({
    Key? key,
    this.height,
    this.width = double.infinity,
    this.background = const Color(0xffA30105),
    this.textColor = Colors.white,
    this.textSize = 3,
    this.textWeight = FontWeight.w400,
    this.radius = 15,
    required this.function,
    required this.text,
    this.icon = "",
    this.borderColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.w),
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: icon.isEmpty
            ? Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: textSize.sp,
                  fontWeight: textWeight,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: textSize.sp,
                      fontWeight: textWeight,
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                ],
              ),
      ),
    );
  }
}
