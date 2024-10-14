import 'package:flutter/material.dart';

class DisabilityCheckbox extends StatefulWidget {
  final void Function(bool data) onCheck;
  final bool? initVal;
  const DisabilityCheckbox({super.key, required this.onCheck, this.initVal});

  @override
  DisabilityCheckboxState createState() => DisabilityCheckboxState();
}

class DisabilityCheckboxState extends State<DisabilityCheckbox> {
  bool _isYesChecked = false;
  bool _isNoChecked = false;

  void _onYesChanged(bool? value, [bool isInit = false]) {
    setState(() {
      if (!isInit) widget.onCheck(true);
      _isYesChecked = value!;
      if (_isYesChecked) _isNoChecked = false;
    });
  }

  void _onNoChanged(bool? value, [bool isInit = false]) {
    setState(() {
      if (!isInit) widget.onCheck(false);
      _isNoChecked = value!;
      if (_isNoChecked) _isYesChecked = false;
    });
  }

  @override
  void initState() {
    super.initState();
    final initial = widget.initVal;
    if (initial != null) {
      (initial) ? _onYesChanged(true, true) : _onNoChanged(true, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kecacatan (OKU)',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: _isYesChecked,
                  onChanged: (val) {
                    if (!val!) return;
                    _onYesChanged(val);
                  },
                ),
                const Text('Ya'),
              ],
            ),
            const SizedBox(width: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: _isNoChecked,
                  onChanged: (val) {
                    if (!val!) return;
                    _onNoChanged(val);
                  },
                ),
                const Text('Tiada'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
