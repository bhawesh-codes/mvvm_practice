import 'package:flutter/material.dart';
import 'package:mvvm_practice/view/home/home_viewmodel.dart';
import 'package:mvvm_practice/view/home/widgets/book_card.dart';
import 'package:provider/provider.dart';

class BookGrid extends StatelessWidget {
  const BookGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final books = context.watch<HomeViewModel>().bookData!.results ?? [];

    return GridView.builder(
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
        return BookCard(book: books[index]); // ✅ extracted
      },
    );
  }
}
