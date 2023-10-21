import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_me/route/route_names.dart';

class NavView extends HookConsumerWidget {
  const NavView(this.child, {super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabCtrl = useTabController(initialLength: 2);
    final path = GoRouterState.of(context).uri.pathSegments.first;

    useEffect(
      () {
        tabCtrl.index =
            RouteNames.shellRoutes.map((e) => e.name).toList().indexOf(path);
        return null;
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(path.toUpperCase()),
        actions: [
          Flexible(
            child: TabBar(
              controller: tabCtrl,
              physics: const NeverScrollableScrollPhysics(),
              isScrollable: true,
              onTap: (value) => RouteNames.shellRoutes[value].go(context),
              tabs: const [
                Tab(text: 'Myself'),
                Tab(text: 'Projects'),
              ],
            ),
          ),
        ],
      ),
      body: child,
    );
  }
}
