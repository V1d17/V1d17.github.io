import 'package:flutter/material.dart';
import '../api calls/requests.dart';
import 'modal.dart';

class WatchModal extends StatelessWidget {
  const WatchModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Future<Map> _info;

    return Scaffold(
        body: Container(
      color: Color(0xFF17302b),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: GestureDetector(
                  onTap: () {
                    _info = fetchInfo();
                    showDialog(
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (context) => Modal(
                              info: _info,
                            ));
                  },
                  child: Image.asset("assets/images/logo.png"))),
        ],
      ),
    ));
  }
}

