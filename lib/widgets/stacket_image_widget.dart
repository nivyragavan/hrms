import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:flutter/cupertino.dart';

import '../constants/colors.dart';
import '../controller/theme_controller.dart';

class StackedWidgets extends StatelessWidget {
  final List<Widget> items;
  final TextDirection direction;
  final double size;
  final double xShift;
  final bool showCount;
  final String? count;

  const StackedWidgets({
    Key? key,
    required this.items,
    this.direction = TextDirection.ltr,
    this.size = 100,
    this.xShift = 20, required this. showCount, this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allItems = items
        .asMap()
        .map((index, item) {
          final left = size - xShift;
          final value = index ==3 && showCount==true?
          Container(
            width: size,
            height: size,
            child: Container(
                width: size,
                height: size,
                decoration:BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  border: Border.all(color: AppColors.white,width: 3.0)
                ),child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: "10+", color: AppColors.black, fontSize: 12, fontWeight: FontWeight.w600),
                  ],
                )),
            margin: EdgeInsets.only(left: left * index),
          ):
          Container(
            width: size,
            height: size,
            child: item,
            margin: EdgeInsets.only(left: left * index),
          );

          return MapEntry(index, value);
        })
        .values
        .toList();

    return Stack(
      children: direction == TextDirection.ltr
          ? allItems.reversed.toList()
          : allItems,
    );
  }
}

Widget buildExpandedBox({
  required List<Widget> children,
  required Color color,
}) =>
    Align(alignment: Alignment.centerLeft,
      child: Container(
        color: color,
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );

Widget buildStackedImages({
  TextDirection direction = TextDirection.ltr,double? imgsize, required bool showCount,  List<String>? images, String? count
}) {
  final double size = imgsize==null?38:imgsize;
  final double xShift = 13;
  final urlImages = images?.length!=0 && images!=null?images:
  [
    'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80',
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    ];

  final items = urlImages.map((urlImage) => buildImage(urlImage)).toList();

  return StackedWidgets(
    direction: direction,
    items: items,
    size: size,
    xShift: xShift,
    showCount:showCount,
    count: count,
  );
}

Widget buildImage(String urlImage) {
  final double borderSize = 3;

  return ClipOval(
    child: Container(
      padding: EdgeInsets.all(borderSize),
      color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
      child: ClipOval(
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
