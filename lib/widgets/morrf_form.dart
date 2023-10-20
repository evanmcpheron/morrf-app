import 'package:flutter/material.dart';
import 'package:morrf/utils/enums/severity.dart';

class MorrfForm extends StatefulWidget {
  final void Function() onSubmit;
  final List<Widget> children;

  MorrfForm({
    super.key,
    required this.onSubmit,
    required this.children,
  });

  @override
  State<MorrfForm> createState() => _MorrfFormState();
}

class _MorrfFormState extends State<MorrfForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: widget.children,
        ));
  }
}
