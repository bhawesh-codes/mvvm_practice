import 'package:flutter/material.dart';
import 'package:mvvm_practice/view/favorite/favorite_viewmodel.dart';
import 'package:mvvm_practice/view/home/models/book_model.dart';
import 'package:provider/provider.dart';

class FavoriteCard extends StatelessWidget {
  final Result book;

  const FavoriteCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FavoriteViewModel>();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
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
                    context.read<FavoriteViewModel>().toggleFavorite(book),
                icon: vm.isFavorite(book)
                    ? const Icon(Icons.favorite, color: Colors.red, size: 20)
                    : const Icon(Icons.favorite_border, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
