import 'package:flutter/material.dart';
import 'package:mvvm_practice/view/home/home_viewmodel.dart';
import 'package:provider/provider.dart';

class PaginationRow extends StatelessWidget {
  const PaginationRow({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (vm.apiService.page != 1)
          GestureDetector(
            onTap: () => context.read<HomeViewModel>().navigateToPreviousPage(),
            child: const Row(
              children: [
                Icon(Icons.arrow_back, size: 18, color: Colors.blueAccent),
                SizedBox(width: 4),
                Text(
                  "Previous Page",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ],
            ),
          ),
        const SizedBox(width: 16),
        if (vm.apiService.page != 5)
          GestureDetector(
            onTap: () => context.read<HomeViewModel>().navigateToNextPage(),
            child: const Row(
              children: [
                Text(
                  "Next Page",
                  style: TextStyle(color: Colors.blueAccent),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward, size: 18, color: Colors.blueAccent),
              ],
            ),
          ),
      ],
    );
  }
}
