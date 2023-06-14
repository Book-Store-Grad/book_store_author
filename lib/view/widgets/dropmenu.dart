import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class DropMenu extends StatefulWidget {

  final List<String> items;
  final String value;
  final double? width;
  final String title;
  final Function(String?)? onChange;
  final String? Function(String?)? validation;

  DropMenu(
      {super.key,
        required this.items,
        required this.value,
        this.onChange,
        this.validation,
        this.width=20,
        required this.title});

  @override
  State<DropMenu> createState() => _DropMenuState();
}

class _DropMenuState extends State<DropMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 3.w),
          child: Text(
            widget.title,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 16
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsetsDirectional.only(start: 5.w),
          width:widget.width,
          height: .063.sh,
          decoration: BoxDecoration(
              color: const Color(0xffFAFAFA),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.white, width: 0.0)),
          child: DropdownButton(
            value: widget.value,
            underline: const SizedBox(),
            dropdownColor: Colors.grey.shade400,
            isExpanded: true,
            items: widget.items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    item,
                    style: TextStyle(
                        fontSize: 16,
                        color: item == widget.value
                            ?  Color(0xff000000)
                            : Colors.black),
                  ),
                ),
              );
            }).toList(),
            onChanged: widget.onChange,
          ),
        ),
      ],
    );
  }
}
