import 'package:flutter/material.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/src/domain/entities/home/job_entity.dart';
import 'package:short_path/src/short_path.dart';

import '../../../../../core/styles/colors/app_colore.dart';
import 'job_card.dart';

class PaginatedJobList extends StatefulWidget {
  final List<JobEntity> jobs;

  const PaginatedJobList({Key? key, required this.jobs}) : super(key: key);

  @override
  _PaginatedJobListState createState() => _PaginatedJobListState();
}

class _PaginatedJobListState extends State<PaginatedJobList> {
  int currentPage = 1;
  final int itemsPerPage = 5;

  int get totalPages => (widget.jobs.length / itemsPerPage).ceil();

  List<JobEntity> get currentJobs {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage) > widget.jobs.length
        ? widget.jobs.length
        : startIndex + itemsPerPage;
    return widget.jobs.sublist(startIndex, endIndex);
  }

  void _goToPage(int page) {
    if (page >= 1 && page <= totalPages && page != currentPage) {
      setState(() {
        currentPage = page;
      });
    }
  }

  /// Returns a button for a given page number.
  Widget _pageButton(int page) {
    final bool isActive = currentPage == page;
    return ElevatedButton(
      onPressed: () => _goToPage(page),
      style: ElevatedButton.styleFrom(
        foregroundColor: isActive ? Colors.white : Colors.black,
        backgroundColor: isActive ? AppColors.primaryColor : Colors.white,
        side: BorderSide(
          color: isActive ? AppColors.primaryColor : Colors.grey.shade300,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: const Size(50, 50), // Increase button size
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 12), // Add padding
      ),
      child: Text(
        '$page',
        style: TextStyle(
          fontSize: 16, // Increase font size
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  /// Returns a fixed-width ellipsis widget.
  Widget _ellipsis() {
    return SizedBox(
      width: 40,
      child: Center(
        child: Text('...', style: TextStyle(color: Colors.grey)),
      ),
    );
  }

  /// Builds the page buttons using a dynamic range:
  /// - Always show the first and last page.
  /// - Show up to 3 pages around the current page.
  /// - Replace gaps with an ellipsis.
  List<Widget> _buildPageButtons() {
    List<Widget> buttons = [];
    if (totalPages <= 7) {
      // If 7 or fewer pages, display them all.
      for (int i = 1; i <= totalPages; i++) {
        buttons.add(_pageButton(i));
      }
    } else {
      // Always show the first page.
      buttons.add(_pageButton(1));

      // Determine a window around the current page.
      int startPage = currentPage - 1;
      int endPage = currentPage + 1;

      // Adjust if near the start.
      if (startPage <= 2) {
        startPage = 2;
        endPage = startPage + 2;
      }
      // Adjust if near the end.
      if (endPage >= totalPages - 1) {
        endPage = totalPages - 1;
        startPage = endPage - 2;
      }

      // Add ellipsis if there is a gap.
      if (startPage > 2) {
        buttons.add(_ellipsis());
      }

      // Add the pages within the calculated window.
      for (int i = startPage; i <= endPage; i++) {
        buttons.add(_pageButton(i));
      }

      // Add ellipsis if there is a gap.
      if (endPage < totalPages - 1) {
        buttons.add(_ellipsis());
      }

      // Always show the last page.
      buttons.add(_pageButton(totalPages));
    }
    // Provide spacing around each button.
    return buttons
        .map((w) => Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0), // Increase horizontal padding
            child: w))
        .toList();
  }

  /// Builds the complete pagination controls in one row.
  Widget _buildPaginationControls() {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 16, horizontal: 20), // Increase padding
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Jump to first page.
            IconButton(
              icon:
                  const Icon(Icons.first_page, size: 28), // Increase icon size
              onPressed: currentPage > 1 ? () => _goToPage(1) : null,
            ),
            // Previous page.
            IconButton(
              icon: const Icon(Icons.navigate_before,
                  size: 28), // Increase icon size
              onPressed:
                  currentPage > 1 ? () => _goToPage(currentPage - 1) : null,
            ),
            // Dynamic page buttons.
            ..._buildPageButtons(),
            // Next page.
            IconButton(
              icon: const Icon(Icons.navigate_next,
                  size: 28), // Increase icon size
              onPressed: currentPage < totalPages
                  ? () => _goToPage(currentPage + 1)
                  : null,
            ),
            // Jump to last page.
            IconButton(
              icon: const Icon(Icons.last_page, size: 28), // Increase icon size
              onPressed:
                  currentPage < totalPages ? () => _goToPage(totalPages) : null,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Display job cards for the current page.
        ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: currentJobs.length,
          itemBuilder: (context, index) => InkWell(
              onTap: () {
                navKey.currentState!.pushNamed(
                  RoutesName.jobDetail,
                  arguments: currentJobs[index],
                );
              },
              child: JobCard(job: currentJobs[index])),

          separatorBuilder: (context, index) => const SizedBox(height: 8),
        ),
        const SizedBox(height: 16),
        // Render the pagination controls.
        _buildPaginationControls(),
      ],
    );
  }
}
