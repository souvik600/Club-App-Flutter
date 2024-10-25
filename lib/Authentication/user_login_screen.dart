import 'package:club_app/AppColors/AppColors.dart';
import 'package:club_app/Authentication/user_signup_screen.dart';
import 'package:club_app/UserScreens/user_home_screen.dart';
import 'package:club_app/Utilities/BottonStyle.dart';
import 'package:club_app/Utilities/InputDecorationStyle.dart';
import 'package:club_app/Widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Add FirebaseAuth package

class UserLogInScreen extends StatefulWidget {
  const UserLogInScreen({super.key});

  @override
  State<UserLogInScreen> createState() => _UserLogInScreenState();
}

class _UserLogInScreenState extends State<UserLogInScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = true;
  final TextEditingController _emailController = TextEditingController();  // Email field controller
  final TextEditingController _passwordController = TextEditingController();  // Password field controller
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isPasswordVisible = false;

  // Function to handle login with Firebase
  Future<void> _loginWithEmailAndPassword() async {
    if (_formSignInKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        // Navigate to profile screen after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        // Show successful login Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Successful')),
        );
      } on FirebaseAuthException catch (e) {
        // Display appropriate Snackbar based on error code
        String message;
        if (e.code == 'user-not-found') {
          message = 'No user found for this email.';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided.';
        } else {
          message = 'Login failed. Please try again.';
        }
        // Show error Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } catch (e) {
        // Handle any other exceptions
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred. Please try again.')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
              decoration: BoxDecoration(
                color: colorLight.withOpacity(.9),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignInKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: AppColors.pColor,
                          fontFamily: 'poppins',
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: _emailController,  // Connect controller to the TextField
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        decoration: AppInputDecoration("Enter Your Email"),
                      ),
                      const SizedBox(height: 25.0),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible, // Set based on visibility state
                        obscuringCharacter: '*',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          focusedBorder:   OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.pColor, width: 1.5,),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: colorLightGray,
                          filled: false,
                          contentPadding: EdgeInsets.fromLTRB(20, 8, 8, 20),
                          enabledBorder:  OutlineInputBorder(
                            borderSide:  BorderSide(color: AppColors.sColor, width: 1.5),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          border: OutlineInputBorder(),
                          labelText: 'Enter Your Password',
                          labelStyle: const TextStyle(
                            color: Colors.black38,
                            fontFamily: 'poppins',
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Change the icon based on the password visibility state
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              // Toggle password visibility state
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: rememberPassword,
                                onChanged: (bool? value) {
                                  setState(() {
                                    rememberPassword = value!;
                                  });
                                },
                                activeColor: AppColors.pColor,
                              ),
                              const Text(
                                'Remember me',
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            child: const Text(
                              'Forget password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.pColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButtonStyle(
                          onPressed: () {
                            _loginWithEmailAndPassword();  // Call Firebase login function
                          },
                          text: 'Log In',
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 10,
                            ),
                            child: Text(
                              'Sign up with',
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Logo(Logos.facebook_f),
                          Logo(Logos.twitter),
                          Logo(Logos.google),
                          Logo(Logos.apple),
                        ],
                      ),
                      const SizedBox(height: 25.0),
                      // don't have an account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account? ',
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (e) => const UserSignUpScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.pColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
