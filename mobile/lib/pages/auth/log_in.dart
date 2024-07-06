import 'package:flutter/material.dart';
import 'package:food_delivery/componants/config.dart';
import '../../componants/sign_page_containers.dart';

class LoginPage extends StatelessWidget {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();

  LoginPage({super.key,
    required this.passwordController,
    required this.emailController,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //phone
        SignPageContainers(controller: emailController,iconData: Icons.email_rounded,hintText: 'Email',textInputType: TextInputType.emailAddress,),
        //password
        SizedBox(height: config.height10,),
        SignPageContainers(controller: passwordController,iconData: Icons.password_rounded,hintText: 'Password',obscure: true),
      ],
    );
  }
}
