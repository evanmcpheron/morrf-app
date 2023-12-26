import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MorrfSlidable extends StatefulWidget {
  final Widget child;
  const MorrfSlidable({super.key, required this.child});

  @override
  State<MorrfSlidable> createState() => _MorrfSlidableState();
}

class _MorrfSlidableState extends State<MorrfSlidable> {
  void doNothing() {
    print("doNothing");
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) {
              doNothing();
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              doNothing();
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: widget.child,
    );
  }
}
