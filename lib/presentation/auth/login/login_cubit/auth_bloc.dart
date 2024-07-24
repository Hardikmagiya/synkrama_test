import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/model/user_model.dart';
import 'package:untitled/utils/app_constants.dart';
import 'package:untitled/utils/shared_prefrence_utils.dart';
import 'package:untitled/utils/strings_utils.dart';

enum AuthEvent { signIn, signUp, signOut, checkAuth,fetchUser }

class AuthState {
  final bool isAuthenticated;
  final UserModel? user;
  final String? error;

  AuthState({required this.isAuthenticated, this.user, this.error});
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LocalStorageService localStorageService;

  //Auth function
  AuthBloc(this.localStorageService) : super(AuthState(isAuthenticated: false, error: null)) {
    on<AuthEvent>((event, emit) async {
      switch (event) {
        case AuthEvent.signIn:
          final UserModel user = await localStorageService.getUser() ?? UserModel(email: '', password: '');
          if (user != null && user.email == state.user?.email && user.password == state.user?.password) {
            emit(AuthState(isAuthenticated: true, user: user));
          } else {
            emit(AuthState(isAuthenticated: false, error: strInvalidCredential));
          }
          break;
        case AuthEvent.signUp:
          final existingUser = await localStorageService.getUser();
          if (existingUser != null && existingUser.email == state.user?.email) {
            emit(AuthState(isAuthenticated: false, error: strUserExist));
          } else {
            await localStorageService.saveUser(state.user!);
            emit(AuthState(isAuthenticated: true, user: state.user));
          }
          break;
        case AuthEvent.signOut:
          await localStorageService.clearUser();
          emit(AuthState(isAuthenticated: false));
          break;
        case AuthEvent.checkAuth:
          final user = await localStorageService.getUser();
          if (user != null) {
            emit(AuthState(isAuthenticated: true, user: user));
          }
          break;
        case AuthEvent.fetchUser:
          final user = await localStorageService.getUser();
          if (user != null) {
            emit(AuthState(isAuthenticated: true, user: user));
          } else {
            emit(AuthState(isAuthenticated: false));
          }
          break;
      }
    });
  }

  GoogleSignInAccount? _user;

  GoogleSignInAccount get googleUser => _user!;

  ///Social login
  Future googleLogin() async {
    _user = await googleSignIn.signOut();
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) return;

    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);

      debugPrint('GOOGLE USER $googleUser');

      /// Social detail ///
      var nameSplit = googleUser.displayName!.split(' ');

      isSocialProvider = 'google';
      isSocialId = googleUser.id;
      isSocialName = nameSplit[0];
      isSocialEmail = googleUser.email;

      //Register user
      final user = UserModel(email: isSocialEmail, password: '123456');
      signUp(user);
    } catch (e) {
      debugPrint('$e');
    }
  }


  void signIn(UserModel user) {
    emit(AuthState(isAuthenticated: false, user: user, error: null));
    add(AuthEvent.signIn);
  }

  void signUp(UserModel user) {
    emit(AuthState(isAuthenticated: false, user: user, error: null));
    add(AuthEvent.signUp);
  }

  void signOut() {
    add(AuthEvent.signOut);
  }

  void checkAuth() {
    add(AuthEvent.checkAuth);
  }

  void fetchUser(){
    add(AuthEvent.fetchUser);
  }
}
