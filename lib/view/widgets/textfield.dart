import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatefulWidget {
  final String? Function(String?)? validation;
  final String? Function(String?)? onSubmitted;
  final bool isPassword;
  final bool enabled;
  final String hintText;
  final String title;
  final double width;
  final Color hintColor;
  final Color textColor;
  final Color fillColor;
  final TextEditingController? controller;
  final List<TextInputFormatter>? regExp;
  final double? sizedBox;
  final double? titleSize;
  final int? maxLines;

  TextFieldWidget(
      {super.key,
      this.validation,
      required this.hintText,
      required this.title,
      this.controller,
      this.regExp,
      this.width = 20,
      this.sizedBox = 20,
      this.maxLines = 1,
      this.titleSize = 16,
      this.onSubmitted,
      this.enabled=true,
      this.isPassword: false,
      this.hintColor = Colors.grey,
      this.textColor = Colors.white,
      this.fillColor = const Color(0xff767676)});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool visible = true;

  void initState() {
    visible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 3.w),
          child: Text(
            widget.title,
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: widget.titleSize!),
          ),
        ),
        SizedBox(
          height: widget.sizedBox!.h,
        ),
        Container(
            width: widget.width,
            child: TextFormField(
              enabled: widget.enabled,
              onFieldSubmitted: widget.onSubmitted,
              obscureText:
                  widget.isPassword == true ? visible : widget.isPassword,
              maxLines: widget.maxLines,
              inputFormatters: widget.regExp,
              style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
              controller: widget.controller,
              decoration: widget.isPassword == true
                  ? InputDecoration(
                      suffixIcon: InkWell(
                        child: visible
                            ? Icon(
                                Icons.visibility_off,
                                size: 18,
                              )
                            : Icon(
                                Icons.visibility,
                                size: 18,
                              ),
                        onTap: () {
                          setState(() {
                            visible = !visible;
                          });
                        },
                      ),
                      hintText: widget.hintText,
                      hintStyle:
                          TextStyle(fontSize: 20.0, color: Color(0xffC4C5C4)),
                      border: InputBorder.none,
                      counter: Offstage(),
                      filled: true,
                      fillColor: Color(0xffFAFAFA),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide:
                            BorderSide(width: 1, color: Color(0xff000000)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    )
                  : InputDecoration(
                      hintText: widget.hintText,
                      hintStyle:
                          TextStyle(fontSize: 20.0, color: Color(0xffC4C5C4)),
                      border: InputBorder.none,
                      counter: Offstage(),
                      filled: true,
                      fillColor: Color(0xffFAFAFA),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide:
                            BorderSide(width: 1, color: Color(0xff000000)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
              validator: widget.validation,
            )),
      ],
    );
  }
}
