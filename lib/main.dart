import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sub_space/src/services/blog_provider.dart';
import 'package:sub_space/src/screens/blog_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => ChangeNotifierProvider(
        create: (context) => BlogProvider(),
        child: MaterialApp(
          title: 'Sub Space Assignment',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const BlogList(),
        ),
      ),
    );
  }
}
