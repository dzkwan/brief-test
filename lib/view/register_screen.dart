import 'package:brieftest/service/auth_service.dart';
import 'package:brieftest/view/login_screen.dart';
import 'package:brieftest/view/widget/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();

  signUpUser() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailCtrl.text,
        password: passwordCtrl.text,
      );
      Navigator.pop(context);
      if (credential != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Auth(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              titleTextStyle: TextStyle(fontSize: 16, color: Colors.black),
              title: Text(
                "Incorrect Email or Password",
                textAlign: TextAlign.center,
              ),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height),
            painter: PaintTopRight(),
          ),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
              ),
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 5.8),
                Center(
                  child: Icon(
                    Icons.lock,
                    size: 70,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 35),
                Text("Email id"),
                SizedBox(height: 12),
                TextFormField(
                  controller: emailCtrl,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This Field is Required";
                    } else if (!EmailValidator.validate(value)) {
                      return 'Please enter a valid email';
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    contentPadding: EdgeInsets.only(
                      bottom: 0,
                      top: 0,
                      left: 10,
                      right: 10,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text("Password"),
                SizedBox(height: 12),
                TextFormField(
                  controller: passwordCtrl,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  obscureText: true,
                  validator: (value) =>
                      value!.isEmpty ? "This Field is Required" : null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    contentPadding: EdgeInsets.only(
                      bottom: 0,
                      top: 0,
                      left: 10,
                      right: 10,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text("Confirm Password"),
                SizedBox(height: 12),
                TextFormField(
                  controller: confirmPasswordCtrl,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This Field is Required";
                    } else if (value != passwordCtrl.text) {
                      return 'Passwords do not match';
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    contentPadding: EdgeInsets.only(
                      bottom: 0,
                      top: 0,
                      left: 10,
                      right: 10,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                      color: Theme.of(context).colorScheme.errorContainer),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await signUpUser();
                        }
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: 36,
                        child: Center(
                          child: Text(
                            "Register",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    SizedBox(width: 43),
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text("or"),
                    SizedBox(width: 6),
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    ),
                    SizedBox(width: 43),
                  ],
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () => AuthService().signInWithGoogle(),
                  child: Container(
                    color: Colors.black12,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icon-google.png",
                          scale: 14,
                        ),
                        SizedBox(width: 12),
                        Text("Continue with Google")
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account ? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 22),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaintTopRight extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.red.shade200,
          Colors.red.shade500,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width, size.height / 8),
          radius: 100,
        ),
      )
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(size.width / 1.9, 0);
    path.cubicTo(size.width / 2.7, size.height / 9, size.width / 2.1,
        size.height / 7, size.width / 1.6, size.height / 6);
    path.cubicTo(size.width / 1.1, size.height / 5, size.width / 1.24,
        size.height / 3, size.width, size.height / 3.1);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
