import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProfileDetail extends StatefulWidget {
  final VoidCallback? onTap;
  final Color textColor;
  final Icon icon;
  final String text;
  final bool showArrow;
  final bool showSwitch;

  const ProfileDetail({
    Key? key,
    this.onTap,
    required this.textColor,
    required this.icon,
    required this.text,
    required this.showArrow,
    required this.showSwitch,
  }) : super(key: key);

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  bool switchValue = true;

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
        onTap: widget.onTap,
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
              if (widget.showArrow)
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 20,
                ),
              if (widget.showSwitch)
                GestureDetector(
                  onTap: () {
                    if (widget.onTap != null) {
                      widget.onTap!();
                    } else {
                      setState(() {
                        switchValue = !switchValue;
                      });
                    }
                  },
                  child: CupertinoSwitch(
                    value: switchValue,
                    onChanged: (value) {
                      setState(() {
                        switchValue = value;
                      });
                      // Handle switch state change here.
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
