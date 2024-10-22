import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import 'commonSearchableDropDown.dart';

class MainSearchableDropDown extends StatefulWidget {
  final String title;
  final String? title1;
  final String? label;
  final String? hint;
  final String? initialValue;
  final items;
  final double? order;
  final Function(dynamic) onChanged;
  final TextEditingController controller;
  final DropdownEditingController? searchController;
  final bool isRequired;
  final bool? filled;
  final Color? fillColor;
  final String? error;
  final double? dropdownHeight;
  MainSearchableDropDown({
    Key? key,
    required this.items,
    this.label,
    required this.title,
    required this.controller,
     this.searchController,
    this.initialValue,
    this.isRequired = false,
    this.order,
    required this.onChanged,
    this.hint,
    this.filled,
    this.fillColor,
    this.error,
    this.title1 = "", this.dropdownHeight,
  }) : super(key: key);

  @override
  State<MainSearchableDropDown> createState() => _MainSearchableDropDownState();
}

class _MainSearchableDropDownState extends State<MainSearchableDropDown> {
  String validationControllerText = "";
  // var items;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      setState(() {
        widget.controller.text = widget.initialValue!;
      });
    }

    setState(() {
      validationControllerText = "test";
    });
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      canRequestFocus: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: DropdownFormField<Map<String, dynamic>>(
                // label: "${widget.label}",
                  dropdownHeight: widget.dropdownHeight,
                  order: widget.order,
                  hint: widget.hint,
                  filled: widget.filled,
                  fillColor: widget.fillColor,
                  isRequired: widget.isRequired,
                  title: "${widget.title}",
                  initialValue: widget.controller.text == ""
                      ? widget.initialValue ?? ""
                      : widget.controller.text,
                  validator: (dynamic data) {
                    // debugPrint("test validator $data");
                    if (data == null) {
                      setState(() {
                        if (widget.controller.text.isEmpty) {
                          validationControllerText = "";
                        }
                      });
                    }
                  },
                  onChanged: (dynamic data) {
                    if (data == "") {
                      // setState((){
                      //   validationControllerText="";
                      // });
                    } else {
                      setState(() {
                        validationControllerText = "${data['${widget.title}']}";
                      });
                      widget.onChanged(data);
                      print("widget.title1widget.title1${widget.title1}");
                      widget.controller.text ='${data['${widget.title1}']}'=="null"?'${data['${widget.title}']}':'${data['${widget.title}']} ${data['${widget.title1??""}']}';
                      // '${data['${widget.title}']} ${data['${widget.title1}']}';
                    }
                  },
                  textController: widget.controller,
                  displayItemFn: (dynamic item) {
                    return Text(
                      '${(item ?? {})['${widget.title}'] ?? ""} ${(item ?? {})['${widget.title1}'] ?? ""}',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                        // color: AppColors.primaryColor
                      ),
                    );
                  },
                  findFn: (dynamic str) async => widget.items ?? [],
                  selectedFn: (dynamic item1, dynamic item2) {
                    if (item1 != null && item2 != null) {
                      return item1['${widget.title}'] ==
                          item2['${widget.title}'];
                    }
                    return false;
                  },
                  filterFn: (dynamic item, str) =>
                  item['${widget.title}']
                      .toLowerCase()
                      .indexOf(str.toLowerCase()) >=
                      0,
                  dropdownItemFn: (dynamic item, int position, bool focused,
                      bool selected, Function() onTap, index) =>
                      InkWell(
                        onTap: onTap,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              gradient: position == index
                                  ? AppColors
                                  .primaryColor1
                                  : null,
                              color: position == index
                                  ? AppColors.primaryColor
                                  : Colors.transparent),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 7),
                            child: Text(
                              widget.title1 != ""
                                  ? "${item['${widget.title}']} ${item['${widget.title1}']}"
                                  : "${item['${widget.title}']}",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: position == index
                                      ? AppColors.white
                                      : AppColors.primaryColor),
                            ),
                          ),
                        ),
                      )),
            ),
          ),
          widget.isRequired == true
              ? validationControllerText == ""
              ? Transform.translate(
            offset: Offset(10, -4),
            child: Text(
              "Required ${widget.error}",
              style:
              TextStyle(fontSize: 12, color: Colors.red.shade700),
            ),
          )
              : SizedBox()
              : SizedBox()
        ],
      ),
    );
  }
}
