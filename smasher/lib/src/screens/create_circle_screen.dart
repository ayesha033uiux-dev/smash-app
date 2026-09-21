import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/controls.dart';
import '../widgets/primitives.dart';
import '../widgets/structures.dart';

/// P02 02 — Create Circle.
///
/// Body gap 28: Head Block (icon tile 40, eyebrow, H1 32, description) then a
/// single Input. The bottom bar carries one button, disabled until the field
/// has a name — which is the state the artboard is drawn in.
class CreateCircleScreen extends StatefulWidget {
  const CreateCircleScreen({super.key, this.onCreated});

  final ValueChanged<String>? onCreated;

  @override
  State<CreateCircleScreen> createState() => _CreateCircleScreenState();
}

class _CreateCircleScreenState extends State<CreateCircleScreen> {
  final _name = TextEditingController();
  var _canSubmit = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      header: const BackHeader(),
      bottomBar: BottomActionBar.single(
        SmasherButton(
          label: 'Create circle',
          onPressed:
              _canSubmit ? () => widget.onCreated?.call(_name.text.trim()) : null,
        ),
      ),
      children: [
        const HeadBlock(
          icon: SmasherIcons.usersPlus,
          eyebrow: 'Create your circle',
          title: 'Create your private circle',
          description: 'Give your circle a name. You can invite people you '
              'trust after it is created.',
        ),
        SmasherInput(
          label: 'Circle name',
          hint: 'e.g. Our Circle',
          helper: 'You can change this later.',
          controller: _name,
          onChanged: (v) => setState(() => _canSubmit = v.trim().isNotEmpty),
        ),
      ],
    );
  }
}
