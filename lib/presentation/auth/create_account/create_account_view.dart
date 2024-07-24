import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/model/user_model.dart';
import 'package:untitled/presentation/auth/login/login_cubit/auth_bloc.dart';
import 'package:untitled/presentation/auth/login/login_view.dart';
import 'package:untitled/resources/common_widgets.dart';
import 'package:untitled/utils/strings_utils.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

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
            child: BlocListener<AuthBloc, AuthState>(
              listener: (BuildContext context, state) {
                if (state.isAuthenticated) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginView()));
                } else if (state.error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.error!),
                  ));
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightBox(120.h),
                      Text(
                       strCreateAccountHeader,
                        style: TextStyle(color: Colors.black.withOpacity(0.60), fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                      heightBox(30.h),
                      _getNameField(),
                      heightBox(20.h),
                      _getEmailField(),
                      heightBox(20.h),
                      _getPasswordField(),
                      heightBox(20.h),
                      _getConfirmPasswordField(),
                      heightBox(15.h),
                      commonButton(
                          text: strSignupButton,
                          onTap: () async {
                            final email = emailController.text;
                            final password = passwordController.text;
                            if (email.isNotEmpty && password.isNotEmpty) {
                              final user = UserModel(email: email, password: password);
                              context.read<AuthBloc>().signUp(user);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(strInvalidInput),
                              ));
                            }
                          }),
                      heightBox(140.h),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: strAlreadyAccount,
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                  text: strLogin,
                                  style: TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                    Navigator.pop(context);
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
            ),
          );
        }),
      ),
    );
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

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return strEnterPassword;
    } else if (value.length < 6) {
      return strPasswordInfo;
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

  Widget _getNameField() {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
        labelText: strName,
        border: OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // validator: _validateEmail,
    );
  }

  Widget _getPasswordField() {
    return TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
        labelText: strPassword,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: _validatePassword,
    );
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return strCPasswordInfo;
    } else if (value != passwordController.text) {
      return strPasswordNotMatch;
    }
    return null;
  }

  Widget _getConfirmPasswordField() {
    return TextFormField(
      controller: confirmPasswordController,
      decoration: InputDecoration(
        labelText: strConfirmPassword,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: _validateConfirmPassword,
    );
  }
}
