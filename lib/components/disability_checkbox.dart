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

  void _onYesChanged(bool? value) {
    setState(() {
      widget.onCheck(true);
      _isYesChecked = value!;
      if (_isYesChecked) _isNoChecked = false;
    });
  }

  void _onNoChanged(bool? value) {
    setState(() {
      widget.onCheck(false);
      _isNoChecked = value!;
      if (_isNoChecked) _isYesChecked = false;
    });
  }

  @override
  void initState() {
    super.initState();
    final initial = widget.initVal;
    if (initial != null) {
      (initial) ? _onYesChanged(true) : _onNoChanged(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kecacatan (OKU)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: _isYesChecked,
                  onChanged: _onYesChanged,
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
                  onChanged: _onNoChanged,
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
