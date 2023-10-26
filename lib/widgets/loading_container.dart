import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/providers/loading_provider.dart';

class LoadingContainer extends ConsumerStatefulWidget {
  Widget child;
  LoadingContainer({super.key, required this.child});

  @override
  ConsumerState<LoadingContainer> createState() => _LoadingContainerState();
}

class _LoadingContainerState extends ConsumerState<LoadingContainer>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool determinate = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool loadingState = ref.watch(loadingProvider);
    return Stack(children: [
      widget.child,
      loadingState
          ? Container(
              color: Theme.of(context).cardColor.withOpacity(.8),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      value: controller.value,
                      semanticsLabel: 'Circular progress indicator',
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox(),
    ]);
  }
}
