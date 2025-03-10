import 'package:emps1/sign_up.dart';
import 'package:emps1/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  VerificationScreen({super.key});
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
                      "We have sent a verification code to your email!",
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
                            hintText: 'Verification Code',
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
                            minimumSize: const Size(120, 52),
                            shape: const StadiumBorder(),
                          ),
                          child: Text("Resend",
                              style: GoogleFonts.jacquesFrancois(
                                  fontSize: 18,
                                  color: Colors.black
                              )
                          ),
                        ),
                        const SizedBox(height: 15.0),
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
                            minimumSize: const Size(120, 52),
                            shape: const StadiumBorder(),
                          ),
                          child: Text("Confirm",
                              style: GoogleFonts.jacquesFrancois(
                                  fontSize: 18,
                                  color: Colors.black
                              )
                          ),
                        ),
                        // const SizedBox(height: 20.0),

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
                              text: "Go back to ",
                              style: GoogleFonts.jacquesFrancois(
                                  fontSize: 18,
                                  color: Colors.black
                              ),
                              children: [
                                TextSpan(
                                    text: "Sign Up",
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
                        // const SizedBox(height: 2.0),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => SignInScreen()
                                )
                            );
                          },
                          child: Text.rich(
                            TextSpan(
                              text: "Have an account? ",
                              style: GoogleFonts.jacquesFrancois(
                                  fontSize: 18,
                                  color: Colors.black
                              ),
                              children: [
                                TextSpan(
                                    text: "Sign In here",
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
