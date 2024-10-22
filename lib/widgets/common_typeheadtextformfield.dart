import 'package:dreamhrms/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:line_icons/line_icons.dart';

import 'package:flutter_svg/svg.dart';
import '../constants/colors.dart';
import '../services/prefernce.dart';

class CommonTypeTextFormField extends StatefulWidget {
  const CommonTypeTextFormField({
    Key? key,
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
    this.readOnly,
    this.onSaved,
    this.autofillHints,
    required this.type,
  }) : super(key: key);

  final String? lableText;
  final List<String>? autofillHints;
  final String? hintText;
  final String? errorText;
  final bool? password;
  final double width;
  final String type;
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

  @override
  State<CommonTypeTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTypeTextFormField> {
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: widget.width==""||widget.width==null?230:widget.width,
      child: GestureDetector(
        onTap: () {
          if (widget.isDatePicker == true) {
            widget.onTap!();
          }
          widget.readOnly == false ? widget.onTap!() : "";
        },
        child: TypeAheadFormField(
          textFieldConfiguration: TextFieldConfiguration(
            textInputAction: widget.action,
            onTap: widget.onTap,
            onChanged: (data) {
              if (widget.onChanged != null) {
                widget.onChanged!(data);
              }
              ;
            },
            inputFormatters: widget.inputFormatters,
            cursorColor: AppColors.black,
            controller: widget.controller,
            enabled: widget.enable,
            maxLength: widget.maxLength,
            maxLines: widget.maxlines,
            style:
                TextStyle(
                    // color: AppColors.black,
                    fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              labelText: widget.lableText,
              filled: widget.filled,
              fillColor: widget.fillColor,
              counterStyle: TextStyle(color: AppColors.black),
              alignLabelWithHint: true,
              hintText: widget.hintText,
              isDense: true, // Added this
              contentPadding: widget.maxlines == 1
                  ? EdgeInsets.all(8)
                  : EdgeInsets.only(top: 30, left: 8), // Added this
              hintStyle: TextStyle(
                  // color: AppColors.black.withAlpha(150),
                  fontSize: 13),
              labelStyle: TextStyle(
                  // color: AppColors.black.withAlpha(200),
                  fontSize: 13),
              errorText: widget.errorText,
              suffixIcon: widget.suffixIcon != null
                  ? widget.suffixIcon
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
                                  child:
                                      Icon(Icons.close,),
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
                                      ))),
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
          suggestionsCallback: (pattern) {
            // return CitiesService.getSuggestions(pattern);
            // return widget.type == "username"
            //     ? PreferencesController.getUsernameSuggestions(pattern)
            //     : widget.type == "password"
            //         ? PreferencesController.getPasswordSuggestions(pattern)
            //         : PreferencesController.getUsernameSuggestions(pattern);
            return getUsernameAndPasswordSuggestions(pattern);
          },
          onSuggestionSelected: (String suggestion) {
            widget.controller?.text = suggestion;
            // print("widget.controller?.text${widget.controller?.text}");
            LoginController.to.password.text=LoginController.to.credentialsList.where((element) => element.username.toString()==widget.controller?.text.toString()).toList()[0].password;
          },
          hideOnEmpty: true,
          itemBuilder: (context, String suggestion) {
            // print("sugegestion $suggestion");
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(suggestion),
            );
          },
          itemSeparatorBuilder: (context, index) {
            return Divider(height: 0.5); // Adjust height for the Divider
          },
          transitionBuilder: (context, suggestionsBox, controller) {
            return suggestionsBox;
          },
          validator: widget.validator,
          onSaved: (data) {
            if (widget.onSaved != null) {
              widget.onSaved!(data);
            }
            ;
          },
        ),
      ),
    );
  }
}
