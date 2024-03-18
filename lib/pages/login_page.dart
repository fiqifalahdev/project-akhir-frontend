import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/logic/states.dart';
import 'package:frontend_tambakku/pages/layout.dart';
import 'package:frontend_tambakku/pages/loading_page.dart';
import 'package:frontend_tambakku/pages/register_page.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/quickalert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isVisible = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "lib/assets/login-bg.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Masuk",
                    style:
                        TextStyle(fontSize: 37, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                formField(),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Lupa Kata Sandi?",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer(
                  builder: (context, ref, child) => ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });

                        ref
                            .read(authNotifierProvider.notifier)
                            .loginUser(email.text, password.text)
                            .then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LoadingScreen())))
                            .catchError((error) {
                          print(error);
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            title: "Error",
                            text: "Email atau Password Salah",
                          );

                          setState(() {
                            isLoading = false;
                          });
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(double.infinity, 55),
                        backgroundColor: const Color(0xff227BE5),
                        elevation: 4,
                        shadowColor: Colors.black),
                    child: isLoading
                        ? LoadingAnimationWidget.discreteCircle(
                            color: CustomColors.putih, size: 25)
                        : const Text("Masuk",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat')),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Belum punya akun?",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()));
                      },
                      child: const Text(
                        " Daftar Disini!",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.primary),
                      ),
                    )
                  ],
                )
                // Login Form
              ],
            ),
          )
        ],
      ),
    );
  }

  Form formField() {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Email",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                hintText: "Masukkan Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Email tidak boleh kosong";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Kata Sandi",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: password,
              obscureText:
                  isVisible ? false : true, // set value ketika icon di klik
              decoration: InputDecoration(
                hintText: "Masukkan Kata Sandi",
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    icon: isVisible
                        ? const Icon(Icons.visibility_rounded)
                        : const Icon(Icons.visibility_off)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Kata Sandi tidak boleh kosong";
                }
                return null;
              },
            ),
          ],
        ));
  }
}
