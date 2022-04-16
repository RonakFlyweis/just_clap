import 'package:flutter/material.dart';
import 'package:urban_home/pages/screens.dart';
import '../web_services/api_provider.dart';
import 'bottom_bar.dart';

class UrbanClapHomeState extends StatefulWidget {
  const UrbanClapHomeState({Key key}) : super(key: key);

  @override
  State<UrbanClapHomeState> createState() => _UrbanClapHomeStateState();
}

class _UrbanClapHomeStateState extends State<UrbanClapHomeState> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: [false],
      future: ApiProvider.autoLogin(),
      builder: (c, s) {
        if (s.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (s.data != false &&
            s.connectionState == ConnectionState.done) {
          return BottomBar();
        }
        return SplashScreen();
      },
    );
  }
}
