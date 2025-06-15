
import 'package:cyber_net_application/views/registrationformscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var loginController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, cons){
          return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: cons.maxHeight
              ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Welcome message
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 285,
                    child: const Center(
                      child: Text(
                        "CyberNet Online Store",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100,),
                  //login form
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.all(
                        Radius.circular(60),
                        ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.black26,
                            offset: Offset(0, -3)
                        )
                      ]
                    ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30,30,8),
                        child: Column(
                          children: [
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  //Login screen
                                  TextFormField(
                                      controller: loginController,
                                    validator: (val) => val == "" ? "Please write login" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.login_sharp,
                                        color: Colors.black,
                                      ),
                                      hintText: "Login",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.white
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.white
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.white
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6
                                      ),
                                        fillColor: Colors.white,
                                      filled: true
                                    ),

                                  ),
                                  const SizedBox(height: 18,),
                                  //Password
                                  Obx(
                                      ()=>TextFormField(
                                        controller: passwordController,
                                        obscureText: isObsecure.value,
                                        validator: (val) => val == "" ? "Please write password" : null,
                                        decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.vpn_key_sharp,
                                              color: Colors.black,
                                            ),
                                            suffixIcon: Obx(
                                                    ()=> GestureDetector(
                                                  onTap:(){
                                                    isObsecure.value = !isObsecure.value;
                                                  },
                                                  child: Icon(
                                                    isObsecure.value ? Icons.visibility_off : Icons.visibility,
                                                    color: Colors.black,
                                                  ),
                                                )
                                            ),
                                            hintText: "Password",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                  color: Colors.white
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                  color: Colors.white
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                  color: Colors.white
                                              ),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                  color: Colors.white
                                              ),
                                            ),
                                            contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 14,
                                                vertical: 6
                                            ),
                                            fillColor: Colors.white,
                                            filled: true
                                        ),

                                      ),
                                  ),
                                  //Login button
                                  const SizedBox(height: 18,),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(50,0,0,0),
                                    child: Row(
                                      children: [
                                        Material(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.circular(30),
                                          child: InkWell(
                                            onTap: () async {
                                              if (!formKey.currentState!.validate()) return;
                                              bool ok = await controller.login(loginController.text.trim(), passwordController.text.trim());
                                              if (ok) {
                                                Get.offAllNamed('/home');
                                              } else {
                                                Get.snackbar('Error', 'Invalid credentials');
                                              }
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 28
                                              ),
                                              child: Text(
                                                "Login",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                )
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20,),
                                        Material(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.circular(30),
                                          child: InkWell(
                                            onTap: ()
                                            {
                                                Get.to(const RegisterFormScreen());
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 28
                                              ),
                                              child: Text(
                                                "Register",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                )
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )

                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}