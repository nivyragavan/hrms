import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/colors.dart';

class CustDropDown<T> extends StatefulWidget {
  final List<CustDropdownMenuItem> items;
  final Function onChanged;
  final String hintText;
  final double borderRadius;
  final double maxListHeight;
  final double borderWidth;
  final int defaultSelectedIndex;
  final bool enabled;
  final IconData expandedIcon;
  final IconData collapsedIcon;

  CustDropDown({
    required this.items,
    required this.onChanged,
    this.hintText = "",
    this.borderRadius = 10,
    this.borderWidth = 1,
    this.maxListHeight = 100,
    this.defaultSelectedIndex = -1,
    Key? key,
    this.enabled = true,
    this.expandedIcon = Icons.arrow_drop_up,
    this.collapsedIcon = Icons.arrow_drop_down,
  }) : super(key: key);

  @override
  _CustDropDownState createState() => _CustDropDownState();
}

class _CustDropDownState extends State<CustDropDown>
    with WidgetsBindingObserver {
  bool _isOpen = false, _isValueEmpty = false, _isReverse = false;
  late OverlayEntry _overlayEntry;
  late RenderBox? _renderBox;
  Widget? _itemSelected;
  String? _imageSelected;
  late Offset dropDownOffset;
  final LayerLink _layerLink = LayerLink();
  var languageCode;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          dropDownOffset = getOffset();
        });
      }
      if (widget.defaultSelectedIndex != -1) {
        setState(() {
          _isValueEmpty = true;
          _imageSelected = widget.items[widget.defaultSelectedIndex].image;
          _itemSelected = widget.items[widget.defaultSelectedIndex].child;
          languageCode = widget.defaultSelectedIndex == 1 ? "ja" : "en";
        });
      }
    });
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  void _addOverlay() {
    if (mounted) {
      setState(() {
        _isOpen = true;
      });
    }

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)!.insert(_overlayEntry);
  }

  void _removeOverlay() {
    if (mounted) {
      setState(() {
        _isOpen = false;
      });
      _overlayEntry.remove();
    }
  }

  @override
  dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  OverlayEntry _createOverlayEntry() {
    _renderBox = context.findRenderObject() as RenderBox?;
    var size = _renderBox!.size;
    dropDownOffset = getOffset();
    return OverlayEntry(
        maintainState: false,
        builder: (context) => Align(
              alignment: Alignment.center,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: dropDownOffset,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: _isReverse
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 30, right: 40),
                      child: Container(
                        height: widget.maxListHeight,
                        constraints: BoxConstraints(maxWidth: size.width * 1.5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(widget.borderRadius),
                          ),
                          child: Material(
                            color: AppColors.white,
                            child: ListView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              children: widget.items
                                  .map((item) => Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 0),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  border: Border()),
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (mounted) {
                                                        setState(() {
                                                          isDropdownOpen =
                                                              !isDropdownOpen;
                                                          _isValueEmpty = true;
                                                          _itemSelected =
                                                              item.child;
                                                          _imageSelected =
                                                              item.image;
                                                          _removeOverlay();
                                                          if (widget
                                                                  .onChanged != null)
                                                            widget.onChanged(
                                                                item.value);
                                                        });
                                                      }
                                                    },
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 8),
                                                        item.child,
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                              visible: item.value == "en",
                                              child: Divider(
                                                color: AppColors.grey,
                                                thickness: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  Offset getOffset() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    double y = renderBox!.localToGlobal(Offset.zero).dy;
    double spaceAvailable = _getAvailableSpace(y + renderBox.size.height);
    if (spaceAvailable > widget.maxListHeight) {
      _isReverse = false;
      // return Offset(-9, renderBox.size.height);
      return Offset(-10, renderBox.size.height);
    } else {
      _isReverse = true;
      return Offset(
          0,
          renderBox.size.height -
              (widget.maxListHeight + renderBox.size.height));
    }
  }

  bool isDropdownOpen = false;
  double _getAvailableSpace(double offsetY) {
    double safePaddingTop = MediaQuery.of(context).padding.top;
    double safePaddingBottom = MediaQuery.of(context).padding.bottom;

    double screenHeight =
        MediaQuery.of(context).size.height - safePaddingBottom - safePaddingTop;

    return screenHeight - offsetY;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CompositedTransformTarget(
        link: _layerLink,
        child: GestureDetector(
          onTap: widget.enabled
              ? () {
                  _isOpen ? _removeOverlay() : _addOverlay();
                }
              : null,
          child: Container(
            decoration: _getDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: _isValueEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(_imageSelected!),
                              SizedBox(width: 8),
                              _itemSelected!,
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 4.0), // change it here
                          child: Text(
                            "-",
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                ),
                Flexible(
                  flex: 1,
                  child: Icon(_isOpen
                      ? widget.expandedIcon
                      : widget.collapsedIcon), // Use custom icon when provided
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Decoration? _getDecoration() {
    if (_isOpen && !_isReverse) {
      return BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(widget.borderRadius),
              topRight: Radius.circular(
                widget.borderRadius,
              )));
    } else if (_isOpen && _isReverse) {
      return BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(widget.borderRadius),
              bottomRight: Radius.circular(
                widget.borderRadius,
              )));
    } else if (!_isOpen) {
      return BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)));
    }
  }
}

class CustDropdownMenuItem<T> extends StatelessWidget {
  final T value;
  final Widget child;
  final String? image;

  CustDropdownMenuItem({required this.value, required this.child, this.image});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
