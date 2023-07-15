import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quote_generator/common_widget/asses_files.dart';

class OnErrorWidget extends StatefulWidget {
  OnErrorWidget({Key? key, required this.onPressed}) : super(key: key);
  void Function() onPressed;

  @override
  State<OnErrorWidget> createState() => _OnErrorWidgetState();
}

class _OnErrorWidgetState extends State<OnErrorWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            onError,
            controller: _controller,
            fit: BoxFit.fill,
            height: 200,
            width: 200,
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
              width: double.infinity,
              height: 48,
              child:
                  ElevatedButton(onPressed: () {}, child: const Text('Reload')))
        ],
      ),
    );
  }
}
