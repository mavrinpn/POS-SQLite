import 'package:flutter/material.dart';

class GoodsPage extends StatefulWidget {
  const GoodsPage({super.key});

  @override
  State<GoodsPage> createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Goods'),
    );
  }
}
