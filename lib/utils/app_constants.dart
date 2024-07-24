import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final googleSignIn = GoogleSignIn();
String isSocialProvider = '';
String isSocialId = '';
String isSocialName = '';
String isSocialLastName = '';
String isSocialEmail = '';