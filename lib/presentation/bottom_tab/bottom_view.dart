import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/presentation/bottom_tab/order_tab/order_view.dart';
import 'package:untitled/presentation/bottom_tab/tab_bloc/tab_bloc.dart';
import 'package:untitled/utils/strings_utils.dart';

import 'home_tab/home_view.dart';
import 'profile_tab/profile_view.dart';

class MainScreen extends StatelessWidget {
  final List<Widget> _screens = [HomeScreen(), OrderView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TabBloc, TabState>(
        builder: (context, state) {
          return _screens[state.currentIndex];
        },
      ),
      bottomNavigationBar: BlocBuilder<TabBloc, TabState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.currentIndex,
            onTap: (index) {
              TabBloc.get(context).onTabChange(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: strHome,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: strOrder,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: strProfile,
              ),
            ],
          );
        },
      ),
    );
  }
}
