import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/presentation/auth/login/login_cubit/auth_bloc.dart';
import 'package:untitled/presentation/auth/login/login_view.dart';
import 'package:untitled/resources/common_widgets.dart';
import 'package:untitled/utils/app_constants.dart';
import 'package:untitled/utils/strings_utils.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strMyProfile),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, state) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$strEmail : ${state.user?.email}',
                  style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                heightBox(30.h),
                commonButton(
                    text: strLogout,
                    onTap: () async {
                      context.read<AuthBloc>().signOut();
                      await googleSignIn.signOut();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginView()));
                    })
              ],
            ),
          );
        },
      ),
    );
  }
}
