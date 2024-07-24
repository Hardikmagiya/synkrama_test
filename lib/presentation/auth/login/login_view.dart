import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/model/user_model.dart';
import 'package:untitled/presentation/auth/create_account/create_account_view.dart';
import 'package:untitled/presentation/auth/login/login_cubit/auth_bloc.dart';
import 'package:untitled/presentation/bottom_tab/bottom_view.dart';
import 'package:untitled/resources/common_widgets.dart';
import 'package:untitled/utils/strings_utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        heightBox(180.h),
                        Text(
                          strWelcome,
                          style: TextStyle(color: Colors.black, fontSize: 24.sp, fontWeight: FontWeight.w700),
                        ),
                        heightBox(5.h),
                        Text(
                          strLoginInformation,
                          style: TextStyle(color: Colors.black.withOpacity(0.60), fontSize: 18.sp, fontWeight: FontWeight.w500),
                        ),
                        heightBox(30.h),
                        _getEmailField(),
                        heightBox(20.h),
                        _getPasswordField(),
                        heightBox(10.h),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              strForgotPassword,
                              style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600),
                            )),
                        heightBox(15.h),
                        BlocListener<AuthBloc,AuthState>(
                          listener: (BuildContext context, state) {
                            if (state.isAuthenticated) {
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
                            } else if (state.error != null) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(state.error!),
                              ));
                            }
                          },
                          child: commonButton(
                              text: strLogin,
                              onTap: () async {
                                if(_validateEmail(emailController.text ?? '') == null && _validatePassword(passwordController.text ?? '') == null ){
                                  // SharedPreferences pref = await SharedPreferences.getInstance();
                                  // pref.setString(strUserEmailKey, loginCubit.emailController.text ?? '');
                                  // pref.setBool(strIsLoginKey, true);
                                  final user = UserModel(email: emailController.text ?? '', password: passwordController.text ?? '');
                                  context.read<AuthBloc>().signIn(user);

                                }else{
                                  showMessage(message: strErrorField);
                                }
                              }),
                        ),
                        heightBox(30.h),
                        InkWell(
                          onTap: () {
                            context.read<AuthBloc>().googleLogin();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 6, offset: Offset(0, 4), spreadRadius: 2)]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  strSignInWithGoogle,
                                  style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        heightBox(140.h),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: strDoNotHaveAccount,
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                    text: strCreateAccount,
                                    style: TextStyle(color: Colors.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CreateAccountView()));
                                      }),
                              ],
                            ),
                          ),
                        ),
                        heightBox(15.h)
                      ],
                    ),
                  ),
            ),
          );
        }),
      ),
    );
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return strEnterPassword;
    } else if (value.length < 6) {
      return strPasswordInfo;
    }
    return null;
  }

  String? _validateEmail(String? value) {
    // Basic email validation regex
    const pattern = r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$';
    final regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return strEnterEmail;
    } else if (!regExp.hasMatch(value)) {
      return strEnterValidEmail;
    }
    return null;
  }

  Widget _getEmailField() {
    return TextFormField(
      controller: emailController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: strEmail,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: _validateEmail,
    );
  }

  Widget _getPasswordField() {
    return TextFormField(
      controller: passwordController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: strPassword,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: _validatePassword,
    );
  }
}
