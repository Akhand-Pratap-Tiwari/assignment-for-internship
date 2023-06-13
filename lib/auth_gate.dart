import 'package:firebase_auth/firebase_auth.dart' hide PhoneAuthProvider;
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:lottie/lottie.dart';

import 'home_screen/home_screen.dart';
import 'keys/keys.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    List<AuthProvider<AuthListener, AuthCredential>>? providers = [
      GoogleProvider(clientId: googleClientId),
      PhoneAuthProvider(),
    ];
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SignInScreen(
              providers: providers,
              headerBuilder: (context, constraints, shrinkOffset) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: LottieBuilder.asset("assets/lurking-cat.json"),
                  ),
                );
              },
              subtitleBuilder: (context, action) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: action == AuthAction.signIn
                      ? const Text('Please Sign In')
                      : const Text('Please Sign Up'),
                );
              },
              footerBuilder: (context, action) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: MediaQuery.of(context).platformBrightness ==
                                Brightness.dark
                            ? Colors.white12
                            : Colors.black87,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Center(
                            child: Text(
                              'or',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        PhoneVerificationButton(label: "Sign In With Phone"),
                      ],
                    ),
                  ),
                );
              },
              // sideBuilder: (context, shrinkOffset) {
              //   return Padding(
              //     padding: const EdgeInsets.all(20),
              //     child: AspectRatio(
              //       aspectRatio: 1,
              //       child: Image.asset('assets/GIFs/taxi.gif'),
              //     ),
              //   );
              // },
            );
          }
          
          return const HomeScreen();
        });
  }
}
