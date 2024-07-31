import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'text_widget.dart';

class DropdownMenuWidget extends StatefulWidget {
  const DropdownMenuWidget({
    super.key,
    required this.hintText,
    required this.items,
    this.fieldWidth,
    this.fieldHeight,
    this.dropdownWidth,
    this.dropdownHeight,
    this.onTap,
    this.value,
  });

  final String hintText;
  final List<String> items;
  final double? fieldWidth;
  final double? fieldHeight;
  final double? dropdownWidth;
  final double? dropdownHeight;
  final void Function(int selectedIndex, String selectedValue)? onTap;
  final String? value;
  @override
  State<DropdownMenuWidget> createState() => _DropdownMenuWidgetState();
}

class _DropdownMenuWidgetState extends State<DropdownMenuWidget> {
  String? selectedValue;
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          widget.hintText,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 15.sp,
          ),
        ),
        items: widget.items.asMap().entries.map((MapEntry<int, String> entry) {
          final int index = entry.key;
          final String item = entry.value;
          return DropdownMenuItem<String>(
            value: item,
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              if (widget.onTap != null) {
                widget.onTap!(index, item);
              }
            },
            child: Text(
              item,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
              ),
            ),
          );
        }).toList(),
        // value: selectedValue,
        value:
            selectedIndex != null ? widget.items[selectedIndex!] : widget.value,
        onChanged: (value) {
          setState(() {
            selectedIndex = widget.items.indexOf(value!);
          });
        },
        buttonStyleData: ButtonStyleData(
          height: widget.fieldHeight ?? 36.h,
          width: widget.fieldWidth ?? 200.w,
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                offset: Offset(0, 2),
                color: Color(0xff000000).withOpacity(0.12),
              ),
            ],
          ),
          elevation: 0,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_downward,
            size: 20,
          ),
          iconEnabledColor: Colors.black45,
          iconDisabledColor: Colors.black45,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: widget.dropdownHeight ?? 200.h,
          width: widget.dropdownWidth ?? 155.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          offset: const Offset(0, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}


// curl -X POST "https://spamcheck.postmarkapp.com/filter" -H "Accept: application/json" -H "Content-Type: application/json" -v -d '{"email":"raw dump of email", "options":"long"}'
// https://www.npmjs.com/package/spamc