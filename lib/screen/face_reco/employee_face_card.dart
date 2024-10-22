import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/model/face_model.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:flutter/material.dart';

class EmployeeFaceCard extends StatelessWidget {
  final FaceDetails face;
  // call back function return id and status
  final Function({required int id, required int status}) onActionPressed;

  const EmployeeFaceCard({
    super.key,
    required this.face,
    required this.onActionPressed,
  });

  Widget _buildStatusContainer(int status) {
    return Container(
      height: 24,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: status == 0
            ? AppColors.yellow.withOpacity(0.7)
            : status == 2
                ? AppColors.red.withOpacity(0.7)
                : status == 1
                    ? AppColors.green.withOpacity(0.7)
                    : AppColors.black,
      ),
      child: Center(
        child: CustomText(
            text: status == 0
                ? "Pending"
                : status == 2
                    ? "Rejected"
                    : "Approved",
            color: status == 0
                ? Color(0xFFFFC107)
                : status == 2
                    ? AppColors.red
                    : status == 1
                        ? AppColors.darkClrGreen
                        : AppColors.black,
            fontSize: 11,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _actionButtons() {
    return Material(
        color: Colors.transparent,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                onActionPressed(id: face.id, status: 1);
              },
              splashRadius: 20,
              icon: CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.lightGreen,
                child: Icon(
                  Icons.check,
                  color: AppColors.darkClrGreen,
                  size: 18,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                onActionPressed(id: face.id, status: 2);
              },
              splashRadius: 20,
              icon: CircleAvatar(
                backgroundColor: AppColors.lightRed,
                radius: 15,
                child: Icon(
                  Icons.close,
                  color: AppColors.red,
                  size: 18,
                ),
              ),
            ),
          ],
        ));
  }

  void viewImage(BuildContext context, String imageUrl) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Stack(children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: InteractiveViewer(
                        minScale: 0.5,
                        maxScale: 5.0,
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.person,
                            size: 40,
                            color: AppColors.grey,
                          ),
                        ),
                      )),
                  Positioned(
                    top: 10, // Adjust the top position as needed
                    right: 10, // Adjust the right position as needed
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ]),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: ThemeController.to.isDarkTheme == true ? null : AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.lightGrey),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1))
        ],
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              viewImage(context, face.punchInImage);
            },
            child: ClipOval(
                child: Image.network(
              face.punchInImage,
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.2,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: AppColors.grey,
                ),
              ),
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.2,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(),
                      child: CircularProgressIndicator(
                        color: AppColors.darkClrGreen,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  ),
                );
              },
            )),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: face.firstName + " " + face.lastName,
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 5),
                CustomText(
                  text: face.jobPosition.position.positionName,
                  color: AppColors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatusContainer(face.punchInStatus),
              if (face.punchInStatus == 0) SizedBox(height: 10),
              if (face.punchInStatus == 0) _actionButtons(),
            ],
          )
        ],
      ),
    );
  }
}
