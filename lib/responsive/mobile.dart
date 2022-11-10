import 'package:flutter/material.dart';
import 'package:flutter_udemy_course/responsive/adaptive.dart';
import 'package:flutter_udemy_course/responsive/constants.dart';

class DeskTopScreen extends StatelessWidget {
  const DeskTopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.teal,
            ),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("login Now ===================="),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text("email"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text("email"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: () {},
                          child: Text("login"),
                          color: Colors.teal,
                          height: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        MaterialButton(
                          onPressed: () {},
                          child: Text("register"),
                          color: Colors.blue,
                          height: 30,
                        )
                      ],
                    ),
                    Center(
                      child: AdaptiveIndicator(
                        os: getOS(),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
