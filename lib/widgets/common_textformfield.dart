import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';

import 'package:flutter_svg/svg.dart';
import '../constants/colors.dart';
import '../controller/employee/employee_controller.dart';

class CommonTextFormField extends StatefulWidget {
  const CommonTextFormField(
      {Key? key,
      this.validator,
      this.lableText,
      this.hintText,
      this.password = false,
      this.maxLength,
      this.keyboardType,
      this.controller,
      this.phoneCode = false,
      this.errorText,
      this.maxlines = 1,
      this.enable = true,
      this.inputFormatters,
      this.isBlackColors = false,
      this.order,
      this.width = 230,
      this.isDatePicker = false,
      this.onClear,
      this.child,
      this.onTap,
      this.onChanged,
      this.action,
      this.filled,
      this.suffixIcon,
      this.fillColor,
      this.readOnly = false,
      this.onSaved,
      this.autofillHints,
      this.prefixIcon,
      this.showPrefixIcon,
      this.suffixIcononClear})
      : super(key: key);

  final String? lableText;
  final bool? suffixIcononClear;
  final List<String>? autofillHints;
  final String? hintText;
  final String? errorText;
  final bool? password;
  final double width;
  final bool? isDatePicker;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool? phoneCode;
  final int? maxlines;
  final Widget? child;
  final bool? readOnly;
  final bool? filled;
  final Color? fillColor;
  final Icon? suffixIcon;
  final bool isBlackColors;
  final Function()? onTap;
  final Function()? onClear;
  final Function(dynamic)? onChanged;
  final Function(dynamic)? onSaved;
  final bool enable;
  final double? order;
  final TextInputAction? action;
  final IconData? prefixIcon;
  final bool? showPrefixIcon;

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: widget.width==""||widget.width==null?230:widget.width,
      // onTap: () {
      //           // if (widget.isDatePicker == true) {
      //           //   widget.onTap!();
      //           //   // widget.onTap;
      //           // }
      //           // widget.readOnly == false ? widget.onTap!() : "";
      //         },
      child: TextFormField(
        textInputAction: widget.action,
        // onTap: widget.onTap,
        onChanged: (data) {
          if (widget.onChanged != null) {
            widget.onChanged!(data);
          }
          ;
        },
        onSaved: (data) {
          print("on pressed called");
          if (widget.onSaved != null) {
            widget.onSaved!(data);
          }
          ;
        },
        readOnly: widget.readOnly == true ? true : false,
        // readOnly: widget.readOnly == true
        //     ? true
        //     : widget.suffixIcon != null
        //         ? true
        //         : widget.isDatePicker == true
        //             ? true
        //             : false,
        inputFormatters: widget.inputFormatters,
        // cursorColor: Theme.of(context).textTheme.,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        enabled: widget.enable,
        maxLength: widget.maxLength,
        maxLines: widget.maxlines,
        validator: widget.validator,
        style: TextStyle(
            // color: AppColors.black,
            fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          prefixIcon: widget.showPrefixIcon == true
              ? Icon(
                  widget.prefixIcon,
                  color: AppColors.grey,
                )
              : null,
          labelText: widget.lableText,
          filled: widget.filled,
          fillColor: widget.fillColor,
          counterStyle: TextStyle(color: AppColors.black),
          alignLabelWithHint: true,
          hintText: widget.hintText,
          isDense: true, // Added this
          contentPadding: EdgeInsets.all(8),
          // widget.maxlines == 1
          //     ? EdgeInsets.all(8)
          //     : EdgeInsets.only(top: 30, left: 8), // Added this
          hintStyle: TextStyle(
              // color: AppColors.black.withAlpha(150),
              fontSize: 13),
          labelStyle: TextStyle(
              // color: AppColors.black.withAlpha(200),
              fontSize: 13),
          errorText: widget.errorText,
          suffixIcon: widget.suffixIcon != null
              ? InkWell(
                  onTap: () async {
                    if(widget.suffixIcononClear==true){
                      widget.controller?.text = "";
                      await EmployeeController.to.getEmployeeList(search:true);
                    }
                  },
                  child: widget.suffixIcon)
              : widget.isDatePicker == true
                  ? FocusScope(
                      canRequestFocus: false,
                      child: Container(
                        width: 20,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                widget.onTap!();
                              },
                              child: Icon(LineIcons.calendar,
                                  color: AppColors.black),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            InkWell(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                widget.controller!.clear();
                                widget.onClear!();
                              },
                              child: Icon(Icons.close, color: AppColors.black),
                            ),
                          ],
                        ),
                      ),
                    )
                  : widget.password == true
                      ? FocusScope(
                          canRequestFocus: false,
                          child: InkWell(
                              onTap: () {
                                setState(
                                  () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                              child: Transform.scale(
                                  scale: 0.5,
                                  child: SvgPicture.asset(
                                    fit: BoxFit.cover,
                                    !passwordVisible
                                        ? "assets/icons/eye_close.svg"
                                        : "assets/icons/eye_open.svg",
                                  ))
                              //child: Icon(
                              //                     !passwordVisible
                              //                         ? Icons.visibility
                              //                         : Icons.visibility_off,
                              //                     color: AppColors.grey),
                              ),
                        )
                      : FocusScope(
                          canRequestFocus: false,
                          child: const SizedBox(
                            height: 20,
                            width: 0,
                          )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.lightGrey, width: 1.7),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.lightGrey, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.lightGrey, width: 1),
          ),
        ),
        obscureText: widget.password == true ? !passwordVisible : false,
      ),
    );
  }
}
