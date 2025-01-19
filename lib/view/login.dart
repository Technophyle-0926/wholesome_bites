import 'package:flutter/material.dart';
import 'package:healthy_recipies/view/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String emailId = "admin@gmail.com";
  String pass = "1234";
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool issuccess = true;
  bool obscurePass = true;
  void setData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email.text);
    await prefs.setString('password', password.text);
  }

  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    final String? password = prefs.getString('password');
    if (email == emailId && password == pass) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
      }
    } else {
      print("error");
    }
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/login.png",
              ),
              opacity: .6,
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelText: "Enter Email",
                  hintText: "example@gmail.com",
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: password,
                obscureText: obscurePass,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelText: "Enter Password",
                  hintText: "Password",
                  suffixIcon: GestureDetector(
                    onTap: () {
                      obscurePass = !obscurePass;
                      setState(() {});
                    },
                    child: obscurePass
                        ? const Icon(
                            Icons.visibility,
                          )
                        : const Icon(
                            Icons.visibility_off,
                          ),
                  ),
                  prefixIcon: const Icon(
                    Icons.lock,
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (email.text == emailId && password.text == pass) {
                        setData();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Dashboard()));
                        issuccess = true;
                      } else {
                        issuccess = false;
                      }

                      setState(() {});
                    },
                    child: const Text("Login")),
              ),
              issuccess ? const Text("") : const Text("Oops, Try again!")
            ],
          ),
        ),
      ),
    );
  }
}
