import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class LanguageDetail extends StatefulWidget {
  final VoidCallback? onTap;
  final Color textColor;
  final SvgPicture icon;
  final String text;
  final bool showSwitch;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;

  const LanguageDetail({
    Key? key,
    this.onTap,
    required this.textColor,
    required this.icon,
    required this.text,
    required this.showSwitch,
    required this.isSelected,
    this.onSelected,
  }) : super(key: key);

  @override
  State<LanguageDetail> createState() => _LanguageDetailState();
}

class _LanguageDetailState extends State<LanguageDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.withOpacity(0.3),
      ),
      child: InkWell(
        highlightColor: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          } else {
            widget.onSelected?.call(true);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  widget.icon,
                  SizedBox(width: 10),
                  Text(
                    widget.text,
                    style: TextStyle(
                      color: widget.textColor,
                      fontFamily: 'Sora',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              if (widget.showSwitch)
                Radio<bool>(
                  activeColor: Colors.black,
                  value: true,
                  groupValue: widget.isSelected ? true : null,
                  onChanged: (value) {
                    widget.onSelected?.call(value == true);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
