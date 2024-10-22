import 'package:dreamhrms/controller/department/add_department_controller.dart';
import 'package:dreamhrms/controller/department/deparrtment_controller.dart';
import 'package:dreamhrms/model/department_model.dart';
import 'package:dreamhrms/screen/department/add_department.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:dreamhrms/widgets/no_record.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../constants/colors.dart';

class ExpansionTileWidget extends StatefulWidget {
  final CustomText title;
  final CustomText subTitle;
  final Image image;
  final List<Positions>? expansionList;
  final VoidCallback editOnPressed;
  final VoidCallback ContainerOnClick;
  final VoidCallback headerEditOnPressed;
  final int mainIndex;
  final SvgPicture editIcon;
  final String value;
  final bool? editicon;
  const ExpansionTileWidget(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.expansionList,
      required this.editOnPressed,
      required this.ContainerOnClick,
      required this.image,
      required this.mainIndex,
      required this.editIcon,
      required this.value,
      this.editicon = true,
      required this.headerEditOnPressed})
      : super(key: key);

  @override
  State<ExpansionTileWidget> createState() => _ExpansionTileWidgetState();
}

class _ExpansionTileWidgetState extends State<ExpansionTileWidget> {
  bool isExpanded = false;
  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (ModalRoute.of(context)?.isCurrent == true) {
          toggleExpand();
        }
        ;
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                maintainState: true,
                title: InkWell(
                  onTap: widget.ContainerOnClick,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          widget.image,
                          SizedBox(width: 8),
                          SizedBox(
                            width: Get.width*0.38,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.title,
                                SizedBox(height: 5),
                                widget.subTitle
                              ],
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: widget.editicon == true,
                        child: InkWell(
                          onTap: widget.headerEditOnPressed,
                          child: CircleAvatar(
                              radius: 18,
                              backgroundColor: AppColors.grey.withOpacity(0.1),
                              child: widget.editIcon),
                        ),
                      )
                    ],
                  ),
                ),
                iconColor: AppColors.grey,
                trailing: CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.grey.withOpacity(0.1),
                  child: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: AppColors.grey.withOpacity(0.8),
                    size: 30, // Custom icon for the collapsed state
                    // Additional properties for the icon
                  ),
                ),
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      widget.expansionList!.length<0?NoRecord():
                      ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: widget.expansionList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 35),
                            child: Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    color: AppColors.blue.withOpacity(0.1),
                                    border: Border.all(
                                        color: AppColors.blue.withOpacity(0.1)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: _buildList(
                                    context, index, widget.mainIndex)),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, int index, int mainIndex) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: '${widget.expansionList?[index].positionName}',
            color: AppColors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 5),
          CustomText(
            text:
                'Grade ${AddDepartmentController.to.getGradeName('${widget.expansionList![index].grade}')}',
            color: AppColors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ],
      ),
      trailing: InkWell(
        onTap: () async {
          if (widget.value == "Department") {
            await AddDepartmentController.to.clearData();
            await AddDepartmentController.to
                .setControllerValue(widget.expansionList?[index], mainIndex);
          }
          widget.editOnPressed();
        },
        child: CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.grey.withOpacity(0.1),
            child: SvgPicture.asset("assets/icons/edit_out.svg")),
      ),
      // Additional properties for each list item
    );
  }
}
