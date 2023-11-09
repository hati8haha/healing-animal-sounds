import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/theme_provider.dart';

class DarmModeSwitch extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var darkMode = ref.watch(darkModeProvider);

    return Switch(
        value: darkMode,
        onChanged: ((value) {
          ref.read(darkModeProvider.notifier).toggle();
        }));
  }
}
