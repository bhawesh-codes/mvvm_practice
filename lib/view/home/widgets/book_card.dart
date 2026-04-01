import 'package:flutter/material.dart';
import 'package:mvvm_practice/view/book_details/book_details_view.dart';
import 'package:mvvm_practice/view/home/home_viewmodel.dart';
import 'package:mvvm_practice/models/book_model.dart';
import 'package:provider/provider.dart';

class BookCard extends StatelessWidget {
  final Result book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    return GestureDetector(
      onTap: () {
        print("Navigating with slug: ${book.slug}");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BookDetailsView(slug: book.slug!)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: book.frontCover != null
                    ? Image.network(
                        book.frontCover!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Container(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    book.title ?? "No title",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      context.read<HomeViewModel>().toggleFavorite(book),
                  icon: vm.isFavorite(book)
                      ? const Icon(Icons.favorite, color: Colors.red, size: 20)
                      : const Icon(Icons.favorite_border, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}
