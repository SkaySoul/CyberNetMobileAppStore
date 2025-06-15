
import 'package:cyber_net_application/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/register_controller.dart';


class RegisterFormScreen extends StatefulWidget {
  const RegisterFormScreen({super.key});
  @override
  State<RegisterFormScreen> createState() => _RegisterFormScreenState();
}

class _RegisterFormScreenState extends State<RegisterFormScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final controller = Get.put(RegisterController());
  var isObsecure = true.obs;
  var customValidator = Validator();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: const BackButton(
            color: Colors.white,
          ),
      ),
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 190,
                      child: const Center(
                        child: Text(
                          "Registration form",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
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
                                    //Login
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
                                    //Name
                                    const SizedBox(height: 18,),
                                    TextFormField(
                                      controller: nameController,
                                      validator: (val) => val == "" ? "Please write name" : null,
                                      decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.person,
                                            color: Colors.black,
                                          ),
                                          hintText: "Name",
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
                                    //Surname
                                    const SizedBox(height: 18,),
                                    TextFormField(
                                      controller: surnameController,
                                      validator: (val) => val == "" ? "Please write surname" : null,
                                      decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.person,
                                            color: Colors.black,
                                          ),
                                          hintText: "Surname",
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
                                    //Phone
                                    const SizedBox(height: 18,),
                                    TextFormField(
                                      controller: phoneController,
                                      validator: (val) {
                                        var isnull = customValidator.validateNonEmpty(val);
                                        return isnull == null ? isnull :customValidator.validatePhone(val);
                                      },

                                      decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.phone,
                                            color: Colors.black,
                                          ),
                                          hintText: "Phone number",
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
                                    //Email
                                    const SizedBox(height: 18,),
                                    TextFormField(
                                      controller: emailController,
                                      validator: (val) {
                                        var isnull = customValidator.validateNonEmpty(val);
                                        return isnull == null ? isnull :customValidator.validateEmail(val);
                                      },
                                      decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.email,
                                            color: Colors.black,
                                          ),
                                          hintText: "E-mail",
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

                                    //register button
                                    const SizedBox(height: 36,),
                                    Material(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(30),
                                      child: InkWell(
                                          onTap: () async {
                                            if (!formKey.currentState!.validate()) return;
                                            final ok = await controller.register(
                                              loginController.text.trim(),
                                              passwordController.text.trim(),
                                              emailController.text.trim(),
                                              phoneController.text.trim(),
                                              nameController.text.trim(),
                                              surnameController.text.trim(),
                                            );
                                            if (ok) {
                                              Get.snackbar('Success', 'Registered successfully');
                                              Get.offAllNamed('/login');
                                            } else {
                                              Get.snackbar('Error', 'Registration failed');
                                            }
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