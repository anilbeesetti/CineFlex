import 'package:cineflex/constansts.dart';
import 'package:cineflex/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DataProvider>(create: (_) => DataProvider())
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Lato'),
          primaryColor: Color(0xFF111820),
          accentColor: kAccentColor,
          backgroundColor: Color(0xFF111820),
          scaffoldBackgroundColor: kPrimaryColor,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
