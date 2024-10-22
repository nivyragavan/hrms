import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';


class MultiSelectDropDown extends StatefulWidget {
  const MultiSelectDropDown({
    Key? key,
    this.withLabel = false,
    this.label,
    this.requiredField = false,
    this.isTop = false,
    this.isSearch = false,
    required this.items,
    required this.onChanged,
    required this.selectedItems,
    this.isValid = true,
    this.isViewOnly = false,
    this.removeValue,
    this.title = 'Select Items',
    this.dropDownHeight,
  }) : super(key: key);
  final bool withLabel;
  final String? label;
  final bool requiredField;
  final bool isTop;
  final bool isSearch;
  final List<String> items; // List of items for the dropdown
  final List<String> selectedItems;
  final bool isValid;
  final bool isViewOnly;
  final String? removeValue;
  final String title;
  final double? dropDownHeight;
  final Function(List<String>) onChanged;

  @override
  State<MultiSelectDropDown> createState() => _MultiSelectDropDownState();
}

class _MultiSelectDropDownState extends State<MultiSelectDropDown> {
  List<String> selectedItem = [];
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedItem = List.from(widget.selectedItems);
  }

  @override
  void didUpdateWidget(MultiSelectDropDown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedItems != oldWidget.selectedItems) {
      setState(() {
        selectedItem = List.from(widget.selectedItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.withLabel
            ? CustomText(
            text: widget.label!,
            color: AppColors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500)
            : const SizedBox.shrink(),
        SizedBox(
          height: widget.withLabel ? 9.0 : 0,
        ),
        DropdownButtonHideUnderline(
          child: SizedBox(
            height: 45,
            child: DropdownButton2<String>(
              isExpanded: true,

              hint: CustomText(
                  text: widget.title,
                  color: AppColors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              iconStyleData: IconStyleData(iconEnabledColor: AppColors.grey),
              dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  padding: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 2,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  offset: widget.isTop
                      ? Offset(0, widget.isSearch ? 235 : 185)
                      : Offset.zero),
              items: widget.items.map(
                    (item) {
                  return DropdownMenuItem(
                    value: item,
                    enabled: true,
                    child: StatefulBuilder(
                      builder: (context, menuSetState) {
                        final isSelected = selectedItem.contains(item);
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              if (item != widget.removeValue) {
                                isSelected
                                    ? selectedItem.remove(item)
                                    : selectedItem.add(item);
                                widget.onChanged(selectedItem);
                              }
                              //This rebuilds the StatefulWidget to update the button's text
                              setState(
                                    () {},
                              );
                              menuSetState(
                                    () {},
                              );
                            },
                            child: Container(
                              height: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5),
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 4, top: 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  gradient: isSelected
                                      ? AppColors.primaryColor1
                                      : null),
                              child: SizedBox(
                                width: double.infinity,
                                child: CustomText(
                                    text: item,
                                   color: AppColors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ).toList(),
              //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
              value: selectedItem.isEmpty ? null : selectedItem.last,
              onChanged: widget.isViewOnly
                  ? null
                  : (value) {
                if (value != widget.removeValue) {
                  widget.onChanged(selectedItem);
                }
              },
              selectedItemBuilder: (context) {
                return widget.items.map(
                      (item) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            for (final item in selectedItem)
                              Container(
                                margin: const EdgeInsets.only(
                                  right: 5,
                                ),
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 4,
                                  bottom: 7,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomText(
                                        text: item,
                                        color: AppColors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                    SizedBox(),
                                    widget.isViewOnly
                                        ? const SizedBox.shrink()
                                        : MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(
                                                () {
                                              selectedItem.remove(item);
                                              widget.onChanged(
                                                  selectedItem);
                                            },
                                          );
                                        },
                                        child: const Padding(
                                          padding:
                                          EdgeInsets.only(top: 2),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.black,
                                            size: 14,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList();
              },
              buttonStyleData: ButtonStyleData(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: widget.isValid
                        ? Colors.grey.withOpacity(0.45)
                        : Colors.red,
                  ),
                ),
              ),
              menuItemStyleData: MenuItemStyleData(
                overlayColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
                height: 40,
                padding: EdgeInsets.zero,
              ),
              dropdownSearchData: DropdownSearchData(
                searchController: textEditingController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Visibility(
                  visible: widget.isSearch ? true : false,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextField(
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                      expands: true,
                      maxLines: null,
                      cursorHeight: 15,
                      controller: textEditingController,
                      decoration: InputDecoration(
                        isDense: false,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Search for an item...',
                        hintStyle: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.1,
                            color: Colors.grey.withAlpha(40),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.withAlpha(40),
                            width: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.withAlpha(40),
                            width: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value.toString().contains(searchValue);
                },
              ),
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  textEditingController.clear();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
