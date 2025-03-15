import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorSelector extends StatefulWidget {
  const ColorSelector(
      {super.key, required this.colors, required this.onChange});

  final List<Color> colors;
  final Function(Color) onChange;

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.colors.first;
    widget.onChange(_selectedColor);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: widget.colors
          .map((c) => InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  _selectedColor = c;
                  widget.onChange(c);
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: c,
                    child: _selectedColor == c
                        ? const Icon(
                            CupertinoIcons.check_mark,
                            color: Colors.white,
                            size: 20,
                          )
                        : null,
                  ),
                ),
              ))
          .toList(),
    );
  }
}
