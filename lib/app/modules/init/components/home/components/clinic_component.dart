part of '../pages/home_page.dart';

class _ClinicComponent extends BaseHomeComponents {

  const _ClinicComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        titleWidget(
            TextConstant.clinic
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: controller.defaultListHeight,
          child: ListView.builder(
            itemCount: controller.clinicTypeList.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              var model = controller.clinicTypeList[index];
              return itemHorizontalWidget(
                  index: index,
                  title: model.clinicTypeName ?? '',
                  onTap: controller.onClinicTypeClicked,
                  isEnabled: model.isEnabled.value
              );
            },
          ),
        ),
        SizedBox(
          height: MarginSizeConstant.medium.h,
        ),
        if (controller.getClinicList().isNotEmpty) ListView.builder(
          itemCount: controller.getClinicList().length,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var model = controller.getClinicList()[index];
            return itemVerticalWidget(
                picture: model.clinicPicture ?? '',
                title: model.clinicTitle ?? '',
                address: model.clinicAddress ?? ''
            );
          },
        ).marginSymmetric(
          horizontal: MarginSizeConstant.medium.w
        ) else const MainEmptyDataWidget()
      ],
    ));
  }
}
