import 'package:flutter/material.dart';
import 'package:mvvm_practice/view/favorite/favorite_viewmodel.dart';
import 'package:mvvm_practice/view/favorite/widgets/favorite_card.dart';
import 'package:provider/provider.dart';

class FavoriteGrid extends StatelessWidget {
  const FavoriteGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final books = context.watch<FavoriteViewModel>().favoriteBooks;

    return ListView(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: books.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 12,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (context, index) {
            return FavoriteCard(book: books[index]); // ✅ extracted
          },
        ),
      ],
    );
  }
}
