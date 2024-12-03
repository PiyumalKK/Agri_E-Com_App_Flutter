import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_kart/pages/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:go_kart/pages/login.dart';
import 'package:go_kart/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _obscureText = true;
  bool _obscureText1 = true;
  final FirebaseAuthService _authService =
      FirebaseAuthService(FirebaseAuth.instance);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  String? _errorMessage; // To show any error message

  void _viewPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _viewPassword1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _signUp() async {
    if (_passwordController.text != _repeatPasswordController.text) {
      setState(() {
        _errorMessage = "Passwords do not match";
      });
      return;
    }

    try {
      // Call createUserWithEmailAndPassword with username, email, and password
      User? user = await _authService.createUserWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
        _usernameController.text,
      );
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Signup failed. Please try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20.0, right: 30.0, left: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Alatsi',
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                ),
                Text(
                  'Sign Up',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Alatsi',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40.0),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 50.0, left: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/goviyagoda.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email Address',
                        contentPadding:
                            EdgeInsets.only(top: 12.0, bottom: 12.0),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        hintText: 'Username',
                        contentPadding:
                            EdgeInsets.only(top: 12.0, bottom: 12.0),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.remove_red_eye),
                          onPressed: _viewPassword,
                        ),
                        contentPadding:
                            const EdgeInsets.only(top: 12.0, bottom: 12.0),
                      ),
                      obscureText: _obscureText,
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: _repeatPasswordController,
                      decoration: InputDecoration(
                        hintText: 'Repeat Password',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.remove_red_eye),
                          onPressed: _viewPassword1,
                        ),
                        contentPadding:
                            const EdgeInsets.only(top: 12.0, bottom: 12.0),
                      ),
                      obscureText: _obscureText1,
                    ),
                  ],
                ),
                const SizedBox(height: 50.0),
                InkWell(
                  onTap: _signUp,
                  child: SizedBox(
                    height: 45.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.grey[300],
                      color: Colors.white,
                      elevation: 5.0,
                      child: GestureDetector(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.check,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(width: 7.0),
                              Text(
                                "SIGN UP",
                                style: TextStyle(
                                  fontFamily: 'Alatsi',
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontFamily: 'Alatsi',
                        fontSize: 13.0,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                      child: Text(
                        ' Login',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Alatsi',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text(
                  "Continue with",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                    fontFamily: 'Alatsi',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/google_plus.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                      ),
                      onTap: () async {
                        User? user = await _authService.signInWithGoogle();
                        if (user != null) {
                          Fluttertoast.showToast(
                            msg: "Google Sign-in Successful!",
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: "Google Sign-in Failed.",
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      width: 18.0,
                    ),
                    InkWell(
                      child: Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fb.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
