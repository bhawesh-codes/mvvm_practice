import 'package:flutter/material.dart';
import 'package:mvvm_practice/view/favorite/favorite_viewmodel.dart';
import 'package:mvvm_practice/view/favorite/widgets/favorite_body.dart';
import 'package:mvvm_practice/view/widgets/my_appbar.dart';
import 'package:provider/provider.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoriteViewModel(),
      builder: (context, _) => Scaffold(
        appBar: MyAppbar(),
        body: const FavoriteBody(), // ✅ extracted
      ),
    );
  }
}
