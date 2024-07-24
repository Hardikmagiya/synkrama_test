import 'package:flutter/material.dart';
import 'package:untitled/utils/strings_utils.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text(strOrderPage),
  automaticallyImplyLeading: false,
),
    );
  }
}
