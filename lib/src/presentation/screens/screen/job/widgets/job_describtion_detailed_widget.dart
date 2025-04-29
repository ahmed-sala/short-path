import 'package:short_path/core/extensions/extensions.dart';

import '../../../../../../core/common/common_imports.dart';
import '../../../../../../core/styles/colors/app_colore.dart';

class JobDescriptionDetailedWidget extends StatefulWidget {
  const JobDescriptionDetailedWidget({super.key, required this.description});
  final String description;

  @override
  State<JobDescriptionDetailedWidget> createState() =>
      _JobDescriptionDetailedWidgetState();
}

class _JobDescriptionDetailedWidgetState
    extends State<JobDescriptionDetailedWidget> {
  @override
  Widget build(BuildContext context) {
    bool _isExpanded = false;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.localization.jobDescription,
                style: TextStyle(
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),
              AnimatedCrossFade(
                firstChild: Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.black54,
                  ),
                  maxLines: 12,
                  overflow: TextOverflow.ellipsis,
                ),
                secondChild: Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.black54,
                  ),
                ),
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Text(
                    _isExpanded
                        ? context.localization.readLess
                        : context.localization.readMore,
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
