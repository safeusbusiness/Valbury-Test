import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valbury/app/data/commons/constants/ui_constant.dart';
import 'package:valbury/app/data/commons/widgets/global_widget.dart';
import 'package:valbury/app/data/models/main_scaffold/main_scaffold_appbar_model.dart';
import 'package:valbury/app/data/models/main_scaffold/main_scaffold_bottombar_model.dart';
import 'package:valbury/app/data/models/main_scaffold/main_scaffold_bottomsheet_model.dart';

class MainScaffoldWidget extends StatelessWidget {

  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Function()? onBackPressed;
  final MainScaffoldAppbarModel? appBar;
  final Widget body;
  final Widget? endDrawer;
  final MainScaffoldBottomSheetModel? bottomSheet;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool isUseShadow;

  const MainScaffoldWidget({
    super.key,
    this.scaffoldKey,
    this.onBackPressed,
    this.appBar,
    this.endDrawer,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    required this.body,
    this.backgroundColor,
    this.isUseShadow = true,
    this.bottomSheet
  });

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Widget insideItemWidget() {
      return isUseShadow ? GlobalWidget.shadowBody(child: body) : body;
    }

    Widget titleWidget() => Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
            appBar?.titleTextAppBar ?? '',
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.left
        ),
        if (appBar?.titleIconAppBar != null) Icon(
          appBar?.titleIconAppBar,
          size: 22.h,
        )
      ],
    );

    Widget appBarWidget(MainScaffoldBottomAppBarModel bottomAppBar) => TabBar(
        controller: bottomAppBar.controller,
        padding: bottomAppBar.padding,
        labelColor: Colors.white,
        labelStyle: Theme.of(context).textTheme.bodyLarge
            ?.copyWith(fontWeight: FontWeight.bold),
        onTap: bottomAppBar.onTap,
        splashBorderRadius: BorderRadius.circular(120.r),
        indicator: bottomAppBar.indicator ??
            BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(120.r)),
              color: appBar?.appBarColor ?? Theme.of(context).primaryColor,
            ),
        unselectedLabelColor: appBar?.appBarColor ?? Theme.of(context).primaryColor,
        unselectedLabelStyle: Theme.of(context).textTheme.bodyLarge
            ?.copyWith(fontWeight: FontWeight.bold),
        indicatorWeight: bottomAppBar.indicatorWeight,
        tabs: bottomAppBar.tabs);

    PreferredSizeWidget? bottomAppBar() {
      if (appBar?.bottomAppBar != null) {
        return PreferredSize(
          preferredSize: Size(double.maxFinite, 60.h),
          child: Container(
              transform: Matrix4.translationValues(0, -10, 0),
              color: Theme.of(context).primaryColorLight,
              child: appBarWidget(appBar!.bottomAppBar!)),
        );
      }
      return null;
    }

    return WillPopScope(
      onWillPop: () async => await onBackPressed!(),
      child: Scaffold(
        key: scaffoldKey,
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButton: floatingActionButton,
        bottomSheet: bottomSheet != null ? Padding(
          padding: bottomSheet!.margin,
          child: SizedBox(
              height: bottomSheet!.size.h,
              child: bottomSheet!.child
          ),
        ) : null,
        endDrawer: endDrawer,
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor ?? Colors.white,
        appBar: appBar != null ? PreferredSize(
          preferredSize: Size(55.w, appBar!.toolbarHeight.h),
          child: Material(
            child: AppBar(
              centerTitle: false,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark
              ),
              bottom: bottomAppBar(),
              leading: appBar?.isShowBackIcon ?? true ? onBackPressed != null ? IconButton(
                icon: Icon(
                    Icons.chevron_left_rounded,
                    color: Colors.black87,
                    size: 30.h
                ),
                onPressed: onBackPressed,
              ) : null : null,
              elevation: appBar?.elevationAppBar,
              shadowColor: Colors.white70,
              title: appBar?.titleWidgetAppBar ?? ((appBar?.isShowBackIcon ?? true) ? Container(
                transform: Matrix4.translationValues(-14, 0, 0),
                child: titleWidget(),
              ) : titleWidget()),
              backgroundColor: appBar?.appBarColor ?? Colors.white,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: MarginSizeConstant.medium,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: appBar?.actionsAppBar ?? [],
                  ),
                )
              ],
            ),
          ),
        ) : null,
        body: SafeArea(
          child: insideItemWidget(),
        ),
      ),
    );
  }
}
