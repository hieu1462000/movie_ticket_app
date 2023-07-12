import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../model_views/auth_service.dart';
import '../widgets/share_widgets/auth_textfield.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback swapView;
  const SignInScreen({Key? key, required this.swapView}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthService authService = AuthService();
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;
  bool hidePassword = true;
  bool showClearText = false;
  String error = "";
  String email = "";
  String password = "";
  String passwordConfirm = "";
  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(
            color: Colors.black,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: const Color.fromARGB(66, 22, 22, 22),
            body: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 25.h,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  "https://cdn.tgdd.vn/Files/2019/05/03/1164670/cgv9.jpg",
                                ),
                                fit: BoxFit.fill)),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text("Hello Again!",
                          style: GoogleFonts.bebasNeue(
                            fontSize: 30.sp,
                            color: Colors.white,
                            shadows: <Shadow>[
                              const Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              const Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 8.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "Welcome back, you've been missed!",
                        style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            AuthTextField(
                              controller: emailController,
                              hintText: "Email",
                              suffix: GestureDetector(
                                child: Icon(
                                  showClearText ? Icons.clear_outlined : null,
                                  size: 12.sp,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  emailController.clear();
                                  showClearText = false;
                                },
                              ),
                              obscureText: false,
                              validator: (val) =>
                                  val.isEmpty ? "Enter an email" : null,
                              onChanged: (val) {
                                setState(() {
                                  if (val.toString().isNotEmpty) {
                                    showClearText = true;
                                  }
                                  email = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            AuthTextField(
                              controller: passwordController,
                              hintText: "Password",
                              suffix: GestureDetector(
                                child: Icon(
                                  hidePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: 12.sp,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                              ),
                              obscureText: hidePassword,
                              validator: (val) => val.length < 6
                                  ? "Enter a password at least 6 characters"
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Text(
                              error,
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await authService
                          .signInWithEmailAndPassword(email, password);
                      if (result == null) {
                        setState(() {
                          error = "Wrong password or couldn't find your email";
                          loading = false;
                        });
                      }
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    child: Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 214, 43, 31),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not a member?',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: widget.swapView,
                        child: const Text(
                          ' Login now.',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
