import '../../../../../../core/common/common_imports.dart';

class JobInfoWidget extends StatelessWidget {
  const JobInfoWidget(
      {super.key,
      required this.company,
      required this.location,
      required this.postedAgo});
  final String company;
  final String location;
  final String postedAgo;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 6.0.w,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            company,
            style: TextStyle(fontSize: 14.0.sp, color: Colors.black54),
          ),
          const Icon(Icons.circle, size: 5, color: Colors.black54),
          Text(
            location,
            style: TextStyle(fontSize: 14.0.sp, color: Colors.black54),
          ),
          const Icon(Icons.circle, size: 5, color: Colors.black54),
          Text(
            postedAgo,
            style: TextStyle(fontSize: 14.0.sp, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
