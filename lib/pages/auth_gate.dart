import 'package:flutter/material.dart' ;
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart'; // new

import 'home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
              GoogleProvider(clientId: '940230830659-sad91r6gq1qbk6ac14b9hpmdtt9u6lhe.apps.googleusercontent.com'),
            ],
            headerBuilder: ((context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(aspectRatio: 1,
                child: Row(
                  children: [
                    IconButton(icon: Icon(Icons.arrow_back_rounded), onPressed: () {
                      Navigator.of(context).pop();
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    },),
                    Text('動物白噪音')
                  ],
                )
                //  child: Image.asset('asset/images/animals/bird.png')
                 ),
              );
            }),
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to FlutterFire, please sign in!')
                    : const Text('Welcome to Flutterfire, please sign up!'),
              );
            },
            footerBuilder:  (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey)
                ),
              );
            },
            sideBuilder: (context, shrinkOffset) {
              return Padding(
               padding: const EdgeInsets.all(20),
               child: AspectRatio(
                 aspectRatio: 1,
                //  child: Image.asset('flutterfire_300x.png'),
                // child: SizedBox(height: 20, width: 20,)
               ),
             );
           },
          );
        }
        return HomePage();
      },
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthStateListener<OAuthController>(
      child: Column(
        children: [SizedBox(width: 20, height: 80,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OAuthProviderButton(
              // or any other OAuthProvider
              provider: GoogleProvider(clientId: '940230830659-sad91r6gq1qbk6ac14b9hpmdtt9u6lhe.apps.googleusercontent.com'),
            ),
          ),
        ],
      ),
      listener: (oldState, newState, ctrl) {
        if (newState is SignedIn) {
          Navigator.pushReplacementNamed(context, '/profile');
        }
        return null;
      },
    );
  }
}