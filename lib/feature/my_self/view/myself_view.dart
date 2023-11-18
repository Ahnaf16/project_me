import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../widget/widget.dart';

class MySelfView extends HookConsumerWidget {
  const MySelfView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = useState(false);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('My Self'),
            AnimatedButton(
              onTap: () {
                selected.value = !selected.value;
              },
              child: const Text('BUTTON'),
            ),
          ],
        ),
      ),
    );
  }
}
