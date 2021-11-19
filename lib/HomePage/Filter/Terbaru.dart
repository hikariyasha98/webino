import 'package:flutter/material.dart';

class Terbaru extends StatelessWidget {
  const Terbaru({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14.0),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.white,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: BorderSide(
                color: Colors.white,
                width: 2,
              ),
            ),
          ),
        ),
        onPressed: () {},
        child: Container(
          height: (MediaQuery.of(context).size.height * 0.022),
          width: MediaQuery.of(context).size.width / 4.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Terbaru",
                style: TextStyle(
                    color: Color.fromRGBO(105, 191, 233, 1),
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
