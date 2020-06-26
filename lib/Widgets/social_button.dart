import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final Image image;
  final Text text;
  final Function function;
  const SocialButton({
    Key key,
    @required this.screenWidth, this.image, this.text, this.function,
  }) : super(key: key);

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: screenWidth*0.1),
      child: SizedBox(
        height: 50,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.white,
          child: Row(
            children: [
              image,

              Expanded(
                child: Center(
                  child: text
                )
              )
            ],
          ),
          onPressed: function,
        ),
      ),
    );
  }
} 