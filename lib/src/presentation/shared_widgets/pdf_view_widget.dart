// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:short_path/dependency_injection/di.dart';
// import 'package:short_path/src/presentation/mangers/career/career_viewmodel.dart';
// import 'package:short_path/src/presentation/shared_widgets/pdf_viewer.dart';
//
// class PdfViewerWithDownloadScreen extends StatelessWidget {
//   const PdfViewerWithDownloadScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Get the injected viewmodel instance.
//     final careerViewmodel = getIt<CareerViewmodel>();
//
//     return BlocProvider(
//       create: (_) => careerViewmodel,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('PDF Viewer'),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.download),
//               onPressed: () {
//                 // Trigger the download action when tapped.
//                 careerViewmodel.downloadFile();
//               },
//             ),
//           ],
//         ),
//         body: BlocConsumer<CareerViewmodel, CareerState>(
//           listener: (context, state) {
//             if (state is DownloadCvSuccess) {
//               // When download succeeds, navigate to the PDF viewer.
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => PdfViewerScreen(
//                     filePath: careerViewmodel.filePath ?? '',
//                   ),
//                 ),
//               );
//             } else if (state is DownloadCvError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text(state.message)),
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is DownloadCvLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             // Inform the user to tap the download button.
//             return const Center(
//               child: Text('Tap the download icon to fetch the PDF.'),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
