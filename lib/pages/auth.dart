import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:healing_animal_sounds/utils/auth_state_provider.dart';

class AuthPage extends ConsumerStatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (authState.isLoggedIn) ...[
              // Display user profile
              CircleAvatar(
                backgroundImage: authState.userData.photoURL.isNotEmpty
                    ? NetworkImage(authState.userData.photoURL)
                    : null,
                child: authState.userData.photoURL.isEmpty
                    ? Text(authState.userData.username
                        .substring(0, 1)
                        .toUpperCase())
                    : null,
              ),
              Text(authState.userData.username),
            ] else ...[
              SizedBox(
                height: 30,
              )
            ],
            GoogleSignInButton(
              onPressed: () async => _handleAuthAction(authState.isLoggedIn),
              loggedIn: authState.isLoggedIn,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleAuthAction(bool isLoggedIn) async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (isLoggedIn) {
        await FirebaseAuth.instance.signOut();
        await GoogleSignIn().signOut();
        ref.read(authStateProvider.notifier).update((state) {
          return AuthState(UserData(username: '', email: ''), false);
        });
      } else {
        final userData = await signInWithGoogle();
        ref.read(authStateProvider.notifier).update((state) {
          return state.copyWith(
            userData: UserData(
              username: userData!.user!.displayName ?? '',
              email: userData.user!.email ?? '',
              photoURL: userData.user!.photoURL ?? '',
            ),
            isLoggedIn: true,
          );
        });

        // Navigate to logged-in screen
        // Navigator.pushNamed(context, '/home');
      }
      setState(() {
        _isLoading = false;
      });
        ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(isLoggedIn ? 'Sign out successful!' : 'Sign in successful!')));
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Sign in failed! QQ')));
    }
  }
}

class GoogleSignInButton extends StatelessWidget {
  final bool loggedIn;
  final bool isLoading;
  final VoidCallback onPressed;

  const GoogleSignInButton({
    super.key,
    required this.onPressed,
    required this.loggedIn,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: isLoading
          ? CircularProgressIndicator()
          : Text(loggedIn ? 'Sign out' : 'Sign in with Google'),
    );
  }
}

Future<UserCredential?> signInWithGoogle() async {
  // Trigger the authentication flow

  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
