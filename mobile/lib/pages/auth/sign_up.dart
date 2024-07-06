import 'package:flutter/material.dart';
import 'package:food_delivery/componants/config.dart';
import '../../componants/sign_page_containers.dart';

class SignupPage extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  SignupPage({super.key, required this.emailController,
    required this.passwordController,required this.nameController,required this.phoneController,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //email
        SignPageContainers(controller: emailController,iconData: Icons.email_rounded,hintText: 'Email',textInputType: TextInputType.emailAddress,),
        //password
        SizedBox(height: config.height10,),
        SignPageContainers(controller: passwordController,iconData: Icons.password_rounded,hintText: 'Password',obscure: true),
        //name
        SizedBox(height: config.height10,),
        SignPageContainers(controller: nameController,iconData: Icons.person_sharp,hintText: 'Name',),
        //phone
        SizedBox(height: config.height10,),
        SignPageContainers(controller: phoneController,iconData: Icons.phone_android_rounded,hintText: 'Phone number',textInputType: TextInputType.number,),
      ],
    );
  }
}
