part of '../pages/home_page.dart';

class _BannerComponent extends BaseHomeComponents {
  const _BannerComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => CarouselSlider(
      options: CarouselOptions(
        height: 140.h,
        autoPlay: true,
        enlargeCenterPage: true
      ),
      items: controller.bannerList.map((element) => PhotoWidget(
        photoURL: element.bannerPicture,
        borderRadius: BorderRadius.circular(BorderRadiusConstant.low.r),
      )).toList(),
    ));
  }
}
