import 'package:flutter/material.dart';

class MorrfPullDownRefresh extends StatefulWidget {
  final Widget child;
  final Function() onRefresh;
  const MorrfPullDownRefresh(
      {super.key, required this.child, required this.onRefresh});

  @override
  State<MorrfPullDownRefresh> createState() => _MorrfPullDownRefreshState();
}

class _MorrfPullDownRefreshState extends State<MorrfPullDownRefresh> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => widget.onRefresh(),
        child: widget.child,
      ),
    );
  }
}
