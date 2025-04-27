import '../../../../../../core/common/common_imports.dart';
import '../../../../../../core/styles/colors/app_colore.dart';
import '../../../../mangers/home/jobs/jobs_viewmodel.dart';

class PaginationControls extends StatelessWidget {
  final JobsViewmodel jobsViewmodel;

  const PaginationControls({Key? key, required this.jobsViewmodel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2))
        ],
      ),
      child: FittedBox(
        child: Row(
          children: [
            IconButton(
                icon: const Icon(Icons.first_page),
                onPressed: jobsViewmodel.currentPage > 0
                    ? () => jobsViewmodel.getJobsForPage(0)
                    : null),
            IconButton(
                icon: const Icon(Icons.navigate_before),
                onPressed: jobsViewmodel.currentPage > 0
                    ? () => jobsViewmodel
                        .getJobsForPage(jobsViewmodel.currentPage - 1)
                    : null),
            ..._buildPaginationButtons(),
            IconButton(
                icon: const Icon(Icons.navigate_next),
                onPressed:
                    jobsViewmodel.currentPage < jobsViewmodel.totalPages - 1
                        ? () => jobsViewmodel
                            .getJobsForPage(jobsViewmodel.currentPage + 1)
                        : null),
            IconButton(
                icon: const Icon(Icons.last_page),
                onPressed:
                    jobsViewmodel.currentPage < jobsViewmodel.totalPages - 1
                        ? () => jobsViewmodel
                            .getJobsForPage(jobsViewmodel.totalPages - 1)
                        : null),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPaginationButtons() {
    List<Widget> buttons = [];
    int total = jobsViewmodel.totalPages;
    int current = jobsViewmodel.currentPage;

    if (total <= 7) {
      buttons.addAll(List.generate(total, _buildPageButton));
    } else {
      buttons.add(_buildPageButton(0));
      if (current > 2) buttons.add(const Text("..."));
      for (int i = (current - 1).clamp(1, total - 2);
          i <= (current + 1).clamp(1, total - 2);
          i++) {
        buttons.add(_buildPageButton(i));
      }
      if (current < total - 3) buttons.add(const Text("..."));
      buttons.add(_buildPageButton(total - 1));
    }
    return buttons
        .map((w) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8), child: w))
        .toList();
  }

  Widget _buildPageButton(int page) {
    final bool isActive = jobsViewmodel.currentPage == page;
    return ElevatedButton(
      onPressed: isActive ? null : () => jobsViewmodel.getJobsForPage(page),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColors.primaryColor; // Selected background color
            }
            return Colors.white; // Default background color
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.white; // Selected text color
            }
            return AppColors.primaryColor; // Default text color
          },
        ),
        side: MaterialStateProperty.all(
          BorderSide(color: AppColors.primaryColor),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      child: Text(
        '${page + 1}',
        style: TextStyle(
          fontSize: 24,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
