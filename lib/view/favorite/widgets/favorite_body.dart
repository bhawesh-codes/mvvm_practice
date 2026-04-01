import 'package:flutter/material.dart';
import 'package:mvvm_practice/view/favorite/favorite_viewmodel.dart';
import 'package:mvvm_practice/view/favorite/widgets/favorite_grid.dart';
import 'package:provider/provider.dart';

class FavoriteBody extends StatelessWidget {
  const FavoriteBody({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FavoriteViewModel>();

    if (vm.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.blueAccent),
      );
    }

    if (vm.favoriteBooks.isEmpty) {
      return const Center(child: Text("No favorite books"));
    }

    return const Padding(
      padding: EdgeInsets.all(12),
      child: FavoriteGrid(), // ✅ extracted
    );
  }
}
