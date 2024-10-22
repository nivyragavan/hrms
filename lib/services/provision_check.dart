import 'package:dreamhrms/controller/provision/provision_controller.dart';
import 'package:dreamhrms/services/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../widgets/no_record.dart';

 ProvisionedWidget({required String provision,required Widget child, required String type}) async {
  print("ProvisionedWidget$provision type $type");
  return await ProvisionController.to.getProvisions(provision,type)?child:UtilService().showToast("error", message:"You don't have an ${type.toLowerCase()} permission.".toString());
}

Widget ViewProvisionedWidget({required String provision,required Widget child, required String type})   {
  return FutureBuilder<bool>(
    future: ProvisionController.to.getProvisions(provision, type),
    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
      if (snapshot.hasData && snapshot.data == true) {
        return child;
      } else {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(); // Or any other loading indicator
        }else{
          return NoViewPermission();
        }
      }
    },
  );
}

get() async {
  bool result=await ProvisionController.to.getProvisions("employees","create");
  return result;
}

class ProvisionsWithIgnorePointer extends StatefulWidget {
  const ProvisionsWithIgnorePointer({Key? key,required this.provision,required this.child, required  this.type}) : super(key: key);
  final String provision;
  final  Widget child;
  final String type;
  @override
  State<ProvisionsWithIgnorePointer> createState() => _ProvisionsWithIgnorePointerState();
}




class _ProvisionsWithIgnorePointerState extends State<ProvisionsWithIgnorePointer> {
  bool ignore=false;

  checkIgnore()async{
    Future.delayed(Duration(seconds: 0),()async{
      print("Ignore Pointer ${widget.provision} ${widget.type} ignore $ignore");
      bool res=await ProvisionController.to.getProvisions(widget.provision,widget.type);
      print("response ignore case$ignore");
      setState(()  {
       ignore= res;
        print("Ignore Pointer ${widget.provision} ${widget.type} ignore $ignore");
      });
    });
  }
  @override
  initState() {
    super.initState();
    widget.provision==""?ignore=true:checkIgnore();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: IgnorePointer(
        ignoring: ignore == true ? false : true,
        child: widget.child,
      ),
      onTap: () async{
        print("check the data${widget.provision}");
        await ignore == false ?
        UtilService().showToast("error", message:"You don't have an ${widget.type.toLowerCase()} permission.".toString()): null;
      },
    );
  }
}