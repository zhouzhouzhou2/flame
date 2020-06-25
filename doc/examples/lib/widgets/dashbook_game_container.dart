import 'package:flutter/material.dart';

class DashbookGameContainer extends StatelessWidget {
  final Future<Widget> Function(Size size) asyncStoryLoader;
  final Widget Function(Size size) storyLoader;

  DashbookGameContainer({
    this.storyLoader, this.asyncStoryLoader
  });

  @override
  Widget build(_) {
    return LayoutBuilder(
        builder: (ctx, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          final child = asyncStoryLoader != null
              ? FutureBuilder<Widget>(
                  future: asyncStoryLoader(size),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return snapshot.data;
                      } else {
                        return const Text('Error');
                      }
                    }
                    return const Text('Loading');
                  })
          : storyLoader(size);

          return Container(
              width: size.width,
              height: size.height,
              child: child,
          );
        }
    );
  }
}
