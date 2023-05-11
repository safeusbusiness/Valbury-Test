import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:valbury/app/data/commons/constants/text_constant.dart';
import 'package:valbury/app/data/commons/constants/ui_constant.dart';
import 'package:valbury/app/data/commons/widgets/loading_widget.dart';
import 'package:valbury/app/data/commons/widgets/main_text_widget.dart';

class MainSmartRefresherWidget extends StatelessWidget {

  final bool enableReload;
  final bool enableLoadMore;
  final Function? onLoadMore;
  final Function? onReload;
  final RefreshController controller;
  final Widget child;

  const MainSmartRefresherWidget({
    super.key,
    this.enableReload = true,
    this.enableLoadMore = false,
    this.onLoadMore,
    required this.controller,
    required this.child,
    this.onReload
  });

  @override
  Widget build(BuildContext context) {
    Widget bodyWidget(IconData icon, String text) => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 23.h,
              color: Theme.of(context).hintColor,
            ),
            SizedBox(
              width: 16.w,
            ),
            MainTextWidget(
              text,
              style: Theme.of(context).textTheme.bodyMedium!
                  .copyWith(color: Theme.of(context).hintColor
              ),
            )
          ],
        );

    return SmartRefresher(
      enablePullDown: enableReload,
      enablePullUp: enableLoadMore,
      physics: const BouncingScrollPhysics(),
      footer: CustomFooter(
        builder: (context, mode) {
          Widget body;
          switch (mode) {
            case LoadStatus.idle:
              {
                body = bodyWidget(Icons.refresh_rounded, TextConstant.loadMore);
                break;
              }
            case LoadStatus.loading:
              {
                body = LoadingWidget.circularProgress();
                break;
              }
            case LoadStatus.failed:
              {
                body = bodyWidget(Icons.error_rounded, TextConstant.loadMore);
                break;
              }
            case LoadStatus.canLoading:
              {
                body = bodyWidget(
                    Icons.arrow_upward_rounded, TextConstant.loadMoreRelease);
                break;
              }
            default:
              {
                body = bodyWidget(
                    Icons.hourglass_full_rounded, TextConstant.loadMoreNoData);
                break;
              }
          }
          return Container(
            height: 55.0,
            padding: const EdgeInsets.only(bottom: MarginSizeConstant.large),
            child: Center(child: body),
          );
        },
      ),
      onLoading: () {
        if (onLoadMore != null) onLoadMore!();
      },
      onRefresh: () {
        if (onReload != null) onReload!();
      },
      controller: controller,
      child: child,
    );
  }
}
