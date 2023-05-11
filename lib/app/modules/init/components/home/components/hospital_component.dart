part of '../pages/home_page.dart';

class _HospitalComponent extends BaseHomeComponents {
  const _HospitalComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        titleWidget(
            TextConstant.hospital
        ),
        SizedBox(
          height: controller.defaultListHeight,
          child: ListView.builder(
            itemCount: controller.hospitalTypeList.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              var model = controller.hospitalTypeList[index];
              return itemHorizontalWidget(
                  index: index,
                  title: model.hospitalTypeName ?? '',
                  onTap: controller.onHospitalTypeClicked,
                  isEnabled: model.isEnabled.value
              );
            },
          ),
        ),
        SizedBox(
          height: MarginSizeConstant.medium.h,
        ),
        if (controller.getHospitalList().isNotEmpty) ListView.builder(
          itemCount: controller.getHospitalList().length,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var model = controller.getHospitalList()[index];
            return itemVerticalWidget(
                picture: model.hospitalPicture ?? '',
                title: model.hospitalTitle ?? '',
                address: model.hospitalAddress ?? ''
            );
          },
        ).marginSymmetric(
          horizontal: MarginSizeConstant.medium.w
        ) else const MainEmptyDataWidget()
      ],
    ));
  }
}
