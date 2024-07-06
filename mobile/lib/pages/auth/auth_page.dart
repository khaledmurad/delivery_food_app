import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/componants/bigtext.dart';
import 'package:food_delivery/componants/config.dart';
import 'package:food_delivery/componants/sign_page_containers.dart';
import 'package:food_delivery/componants/smalltext.dart';
import 'package:food_delivery/componants/snack_bar.dart';
import 'package:food_delivery/controller/auth_controller.dart';
import 'package:food_delivery/pages/auth/log_in.dart';
import 'package:food_delivery/pages/auth/sign_up.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool _isLogin = false;

  void fieldRegisterCheck(){
    var name = nameController.text.trim();
    var email = emailController.text.trim();
    var password = passwordController.text.trim();
    var phone = phoneController.text.trim();
    var authController = Get.find<AuthController>();
    if(name.isEmpty){
      getSnackBar('Name can\'t be empty');
    }else if(phone.isEmpty){
      getSnackBar('Phone can\'t be empty');
    }else if(email.isEmpty){
      getSnackBar('Email can\'t be empty');
    }else if(!GetUtils.isEmail(email)){
      getSnackBar('Invalid email');
    }else if(password.isEmpty){
      getSnackBar('Password can\'t be empty');
    }else if(password.length<6){
      getSnackBar('Password shouldn\'t be less than 6 characters');
    }else{
      getSnackBar('Well done',isError: false,title: 'Done');
      authController.Register(name, email, password, phone);
    }
  }

  void fieldLoginCheck(){
    var email = emailController.text.trim();
    var password = passwordController.text.trim();
    var authController = Get.find<AuthController>();
    if(email.isEmpty){
      getSnackBar('Email can\'t be empty');
    }else if(!GetUtils.isEmail(email)){
      getSnackBar('Invalid email');
    }else if(password.isEmpty){
      getSnackBar('Password can\'t be empty');
    }else if(password.length<6){
      getSnackBar('Password shouldn\'t be less than 6 characters');
    }else{
      getSnackBar('Logged in',isError: false,title: 'Done');
      authController.login(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return  SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(top: config.height10*4,bottom: config.height10*2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //logo
                Container(
                  height: config.height45*4,
                  width: config.height45*4,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/chef.jpg'),fit: BoxFit.cover)
                  ),
                ),
                //if login page
                _isLogin?
                Column(
                  children: [
                    SizedBox(height: config.height20,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: config.width20),
                      child: Row(
                        children: [
                          Text('Welcome',style: TextStyle(
                              color: AppColors.paraColor,fontSize: config.font20*2.5,fontWeight: FontWeight.w600
                          ),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: config.width20*9),
                      child: Row(
                        children: [
                          Text('back',style: TextStyle(
                              color: AppColors.paraColor,fontSize: config.font20*2.5,fontWeight: FontWeight.w600
                          ),),
                        ],
                      ),
                    ),
                  ],
                ):
                Container(),
                //body
                _isLogin?
                SizedBox(height: config.height20*2,)
                    :SizedBox(height: config.height20,),
                _isLogin?
                LoginPage(passwordController: passwordController, emailController: emailController)
                    :SignupPage(emailController: emailController,nameController: nameController,passwordController: passwordController,phoneController: phoneController,),
                //button
                SizedBox(height: config.height20,),
                GestureDetector(
                  onTap: (){
                    _isLogin?
                    fieldLoginCheck():
                    fieldRegisterCheck();

                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: config.width20,vertical: config.height10),
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(config.radius20)
                    ),
                    child: !authController.isLoading? BigText(
                      text:_isLogin?AppConstants.LOGIN :AppConstants.SIGNUP,color: Colors.white,
                    ) :
                    const CircularProgressIndicator(color: Colors.white),
                  ),
                ),
                //have account or not
                SizedBox(height: config.height10,),
                InkWell(
                  onTap: (){
                    setState((){
                      _isLogin = !_isLogin;
                    });
                  },
                  child: SmallText(text: _isLogin?AppConstants.DONTHAVEACCOUNT :AppConstants.HAVEACCOUNT,color: AppColors.paraColor,),
                ),
                //use another ways
                SizedBox(height: config.height20,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: config.width30*2),
                  child: Row(
                    children: [
                      Expanded(child: Divider(color: AppColors.paraColor,thickness: 1,)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: config.width10),
                        child: BigText(text: 'OR',color: AppColors.paraColor,),
                      ),
                      Expanded(child: Divider(color: AppColors.paraColor,thickness: 1,)),

                    ],
                  ),
                ),
                SizedBox(height: config.height20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: config.height10*5,
                      width: config.height10*5,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/images/facebook.png'),fit: BoxFit.cover)
                      ),
                    ),
                    Container(
                      height: config.height45,
                      width: config.height45,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/images/google.png'),fit: BoxFit.cover)
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
