import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:dreamhrms/widgets/no_record.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import 'common.dart';
import 'package:dreamhrms/model/team/admin_team_model.dart' hide State;

class MultiExpansionTileWidget extends StatefulWidget {
  final CustomText title;
  final CustomText subTitle;
  final Image image;
  // final List<Positions>? expansionList;
  final List<Children>? expansionList;
  final VoidCallback editOnPressed;
  final VoidCallback ContainerOnClick;
  final int mainIndex;
  final SvgPicture editIcon;
  final String value;
  final bool? editicon;
  const MultiExpansionTileWidget({
    Key? key,
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
  }) : super(key: key);

  @override
  State<MultiExpansionTileWidget> createState() =>
      _MultiExpansionTileWidgetState();
}

class _MultiExpansionTileWidgetState extends State<MultiExpansionTileWidget> {
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
        print(
            "ModalRoute.of(context)?.isCurrent${ModalRoute.of(context)?.isCurrent}");
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
            padding: const EdgeInsets.all(0.5),
            child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: expansion(widget.ContainerOnClick, widget.image,
                    widget.title, widget.subTitle, widget.expansionList)),
          ),
        ),
      ),
    );
  }

  Widget expansion(VoidCallback? containerOnClick, Image image,
      CustomText title, CustomText subTitle, List<Children>? expansionList) {
    return ExpansionTile(
      trailing: expansionList!.length>0?null:SizedBox.shrink(),
      maintainState: true,
      title: InkWell(
        onTap: containerOnClick,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                image,
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [title, SizedBox(height: 5), subTitle,
                    CustomText(
                      text: "Members : ${expansionList?.length??0}",
                      color: AppColors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      iconColor: AppColors.grey,
      // trailing: expansionList != null && expansionList.length > 0
      //     ? CircleAvatar(
      //   radius: 18,
      //   backgroundColor: AppColors.grey.withOpacity(0.1),
      //   child: Icon(
      //     Icons.keyboard_arrow_down_outlined,
      //     color: AppColors.grey.withOpacity(0.8),
      //     size: 30, // Custom icon for the collapsed state
      //   ),
      // )
      //     :null,
      // trailing: CircleAvatar(
      //   radius: 18,
      //   backgroundColor: AppColors.grey.withOpacity(0.1),
      //   child: Icon(
      //     Icons.keyboard_arrow_down_outlined,
      //     color: AppColors.grey.withOpacity(0.8),
      //     size: 30, // Custom icon for the collapsed state
      //   ),
      // ),
      children: <Widget>[
        Column(
          children: <Widget>[listView(expansionList)],
        ),
      ],
    );
  }

  listView(List<Children>? expansionList) {
    return expansionList?.length == 0 || expansionList?.length == null
        ? NoRecord()
        : ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: expansionList?.length ?? 0,
            itemBuilder: (context, index) {
              final teamsList = expansionList?[index];
              return Padding(
                padding: const EdgeInsets.only(left: 5), //left: 35
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: AppColors.blue.withOpacity(0.1),
                        border:
                            Border.all(color: AppColors.blue.withOpacity(0.1)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    // child: _buildList(context, index, teamsList)),
                    child: expansion(
                        () {},
                        Image.network(
                            commonNetworkImageDisplay(
                                '${teamsList?.profileImage}'),
                            fit: BoxFit.cover,
                            width: 40.0,
                            height: 40.0),
                        CustomText(
                          text:
                              '${teamsList?.firstName ?? "-"} ${teamsList?.lastName}',
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        CustomText(
                          text:
                              '${teamsList?.jobPosition?.position?.positionName}',
                          color: AppColors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                        teamsList?.children)),
              );
            },
          );
  }

  Widget _buildList(BuildContext context, int index, Children? teamsList) {
    return ListTile(
      title: Row(
        children: [
          CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.grey.withOpacity(0.1),
              child: SvgPicture.asset('${teamsList?.profileImage}')),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: '${teamsList?.firstName ?? "-"} ${teamsList?.lastName}',
                color: AppColors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 5),
              CustomText(
                text: '${teamsList?.jobPosition?.position?.positionName}',
                color: AppColors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ],
          ),
        ],
      ),
      trailing: Visibility(
        visible: teamsList?.children != null && teamsList?.children != [],
        child: InkWell(
          onTap: () {
            print("teamsList?.children${teamsList?.children}");
            // listView(teamsList?.children);

            MultiExpansionTileWidget(
                mainIndex: index,
                title: CustomText(
                  text:
                      '${teamsList?.firstName ?? "-"} ${teamsList?.lastName ?? "-"}',
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                subTitle: CustomText(
                  textAlign: TextAlign.start,
                  text: "${"teamsList.departmentName ??" "-"}",
                  color: AppColors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                image: Image.network(
                    commonNetworkImageDisplay('${teamsList?.profileImage}'),
                    fit: BoxFit.cover,
                    width: 40.0,
                    height: 40.0),
                expansionList: teamsList?.children,
                editIcon: SvgPicture.asset("assets/icons/eye_open.svg"),
                value: "Team",
                editicon: false,
                editOnPressed: () async {},
                ContainerOnClick: () {
                  Get.toNamed('/TeamProfile', arguments: index);
                });
          },
          child: CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.grey.withOpacity(0.1),
            child: Icon(
              Icons.keyboard_arrow_down_outlined,
              color: AppColors.grey.withOpacity(0.8),
              size: 30, // Custom icon for the collapsed state
              // Additional properties for the icon
            ),
          ),
        ),
      ),
      // Additional properties for each list item
    );
  }
}
