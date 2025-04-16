import '../../../core/common/common_imports.dart';
import '../../../core/styles/cached_network_image_widget.dart';
import '../../../core/styles/colors/app_colore.dart';
import '../../../core/styles/images/app_images.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget(
      {super.key, this.imageUrl, this.width = 100, this.height = 100});
  final String? imageUrl;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ClipOval(
          child: imageUrl == '' || imageUrl == null
              ? Container(
                  width: 35,
                  height: 35,
                  color: AppColors.primaryColor,
                  child: Image.asset(
                    AppImages.appLogo,
                    width: 35,
                    height: 35,
                    fit: BoxFit.cover,
                  ),
                )
              : CachedNetworkImageWidget(
                  imageUrl: imageUrl,
                  width: 35,
                  height: 35,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
