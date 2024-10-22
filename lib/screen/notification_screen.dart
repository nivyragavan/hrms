import 'package:dreamhrms/widgets/common_button.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../widgets/Custom_text.dart';
import '../widgets/back_to_screen.dart';
import '../widgets/common.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            navBackButton(),
            SizedBox(width: 8),
            CustomText(
              text: "Notification",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              children: [
                TextButton(onPressed: (){}, child: CustomText(
                    text: "Mark all as read",
                    color: AppColors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),),
                Icon(
                  Icons.check_circle_outline,
                  size: 18,
                  color: AppColors.blue,
                )
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/user.jpeg'),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: RichText(
                        text: TextSpan(
                            text: "Ray Arnold",
                            style: TextStyle(
                                color: Theme.of(context).textTheme.bodyMedium?.color,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            children: [
                          TextSpan(
                              text: " left 6 comments on",
                              style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                          TextSpan(
                              text: " Isla Nublar SOC2 compliance report",
                              style: TextStyle(
                                  color: Theme.of(context).textTheme.bodyMedium?.color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500))
                        ])),
                  ),
                  subtitle: index == 2
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    gradient: AppColors.primaryColor1,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: CustomText(
                                      text: "Accept",
                                    color: AppColors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      onPressed: () {}),
                                ),
                                SizedBox(width: 8,),
                                Container(
                                  width: 60,
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(color:AppColors.black,),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: CustomText(
                                      text: "Reject",
                                      color: AppColors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      onPressed: () {}),
                                ),
                              ],
                            ),
                            SizedBox(height:15,),
                            CustomText(
                                text: "Yesterday at 11:42 PM",
                                color: AppColors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ],
                        )
                      : CustomText(
                          text: "Yesterday at 11:42 PM",
                          color: AppColors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 15,
              );
            },
            itemCount: 10),
      ),
    );
  }
}
