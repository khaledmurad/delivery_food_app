import 'package:flutter/material.dart';
import 'package:food_delivery/componants/bigtext.dart';
import 'package:food_delivery/componants/config.dart';
import 'package:food_delivery/componants/profile_page_containers.dart';
import 'package:food_delivery/controller/address_controller.dart';
import 'package:food_delivery/controller/auth_controller.dart';
import 'package:food_delivery/controller/user_controller.dart';
import 'package:food_delivery/pages/address/address_page.dart';
import 'package:food_delivery/pages/profile/sub_page/previous_page.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Center(child: Text('Profile',style: TextStyle(
          color: Colors.black54
        ),)),
      ),
      body: GetBuilder<UserController>(builder: (userController){
        // userController.getUser();
        return userController.isLoading?
        Container(
          margin: EdgeInsets.only(top: config.height20),
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: config.height45*3,
                width: config.height45*3,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage('assets/images/profile.png'),fit: BoxFit.cover)
                ),
              ),
              //name
              SizedBox(height: config.height30,),
              ProfilePageContainers(iconData: Icons.person_sharp, text: userController.userModel!.name!),
              //email
              SizedBox(height: config.height20,),
              ProfilePageContainers(iconData: Icons.email_rounded, text: userController.userModel!.email!),
              //phone no
              SizedBox(height: config.height20,),
              ProfilePageContainers(iconData: Icons.phone_android_rounded, text: userController.userModel!.phone!),
              //address
              SizedBox(height: config.height20,),
              GestureDetector(
                  onTap: (){
                    Get.to(()=> AddressPage());
                  },
                  child: ProfilePageContainers(iconData: Icons.location_on_rounded, text: 'Add your adress')),
              //previous
              SizedBox(height: config.height20,),
              GestureDetector(
                  onTap: () async {
                     Get.to(() => PreviousCartPage());
                    // SharedPreferences sh = await SharedPreferences.getInstance();
                    // // sh.remove(AppConstants.CartHistoryList_SH_P);
                    // List<String>? a = sh.getStringList(AppConstants.CartHistoryList_SH_P);
                    // for(int i = 0; i<a!.length;i++) {
                    //   print('previous list is ${a[i]}');
                    // }
                  },
                  child: ProfilePageContainers(iconData: Icons.shopping_cart_outlined, text: 'Your previous orders')),
              //log out
              SizedBox(height: config.height20,),
              GestureDetector(
                onTap: (){
                  Get.find<AddressController>().clearaddressList();
                  Get.find<AuthController>().logout();
                  print('logged out');
                },
                child: Text('Log out',style: TextStyle(
                    color: Colors.redAccent,fontSize: config.font20,fontWeight: FontWeight.bold
                ),),
              )
            ],
          ),
        ):
        Container(child: Center(child: CircularProgressIndicator()),);
      }),
    );
  }

  @override
  void initState() {
    Get.find<UserController>().getUser();
    // Get.find<UserController>().isLoading = false;
    super.initState();
  }
}
