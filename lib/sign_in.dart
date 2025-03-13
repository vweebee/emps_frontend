import 'package:emps1/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC1DB3C),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.1),
                  // Image.network(
                  //   "https://i.postimg.cc/nz0YBQcH/Logo-light.png",
                  //   height: 100,
                  // ),
                  SizedBox(height: constraints.maxHeight * 0.1),
                  Text(
                      "SIGN IN",
                      style: GoogleFonts.jacquesFrancois(
                          fontSize: 24,
                          color: Colors.black
                      )
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            filled: true,
                            fillColor: Color(0xFFF5FCF9),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0 * 1.5, vertical: 10.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (email) {
                            // Save it
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              filled: true,
                              fillColor: Color(0xFFF5FCF9),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.0 * 1.5, vertical: 10.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            onSaved: (password) {
                              // Save it
                            },
                          ),
                        ),

                        const SizedBox(height: 30.0),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              // Navigate to the main screen
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: const Color(0xFFEDF9B1),
                            foregroundColor: Colors.black,
                            minimumSize: const Size(48, 52),
                            shape: const StadiumBorder(),
                          ),
                          child: Text("Sign In",
                              style: GoogleFonts.jacquesFrancois(
                                  fontSize: 18,
                                  color: Colors.black
                              )
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        // TextButton(
                        //   onPressed: () {},
                        //   child: Text(
                        //     'Forgot Password?',
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .bodyMedium!
                        //         .copyWith(
                        //       color: Theme.of(context)
                        //           .textTheme
                        //           .bodyLarge!
                        //           .color!
                        //           .withOpacity(0.64),
                        //     ),
                        //   ),
                        // ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()
                              )
                            );
                          },
                          child: Text.rich(
                            TextSpan(
                              text: "Don't have an account? ",
                              style: GoogleFonts.jacquesFrancois(
                                  fontSize: 18,
                                  color: Colors.black
                              ),
                              children: [
                                TextSpan(
                                    text: "Register here",
                                    style: GoogleFonts.jacquesFrancois(
                                        fontSize: 18,
                                        color: Color(0xE6CC4385)
                                    )
                                ),
                              ],
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .color!
                                  .withOpacity(0.64),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
