import 'package:flutter/material.dart';

class AbilityButton extends StatelessWidget {

  final String displayIcon;
  final VoidCallback onTap;
  final Color color;

  const AbilityButton({
    Key key, 
    this.displayIcon,
    this.color, 
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4)
        ),
        // color: color,
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.network(
              displayIcon,
              width: 30,
              height: 30,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}