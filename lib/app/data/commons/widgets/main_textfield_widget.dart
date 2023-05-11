import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:valbury/app/data/commons/constants/ui_constant.dart';
import 'package:valbury/app/data/commons/helpers/regex_rule_helper.dart';
import 'package:valbury/app/data/commons/widgets/global_widget.dart';
import 'package:valbury/app/data/commons/widgets/main_text_widget.dart';

class MainTextFieldWidget extends StatefulWidget {
  final String? title;
  final String? hint;
  final Widget? statusWidget;
  final Widget? suffix;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final bool readOnly;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final TextCapitalization? textCapitalization;
  final bool obscureText;
  final int? maxLength;
  final String? initialValue;
  final List<RegexValidationHelper>? validation;
  final IconData? icon;
  final Function()? onTap;
  final RxString? errorText;
  final bool enableStrip;
  final List<TextInputFormatter>? listInputFormatters;
  final TextAlign textAlign;

  const MainTextFieldWidget(
      {Key? key,
      this.title,
      this.hint,
      this.statusWidget,
      this.suffix,
      this.controller,
      this.onChange,
      this.readOnly = false,
      this.keyboardType,
      this.textCapitalization,
      this.obscureText = false,
      this.maxLength,
      this.focusNode,
      this.initialValue,
      this.validation,
      this.icon,
      this.onTap,
      this.enableStrip = true,
      required this.errorText,
      this.listInputFormatters,
      this.textAlign = TextAlign.start})
      : super(key: key);

  @override
  State<MainTextFieldWidget> createState() => _MainTextFieldWidgetState();
}

class _MainTextFieldWidgetState extends State<MainTextFieldWidget> {
  TextEditingController? _controller;
  var isShowPassword = true.obs;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    if (widget.initialValue != null) {
      _controller ??= TextEditingController();
      _controller?.text = widget.initialValue!;
    }
  }

  @override
  Widget build(BuildContext context) {

    bool isTextInputPhone() => widget.keyboardType == TextInputType.phone;

    void onRequestFocusPhoneNumber() {
      if (widget.controller != null) {
        widget.controller!.text = '+62 - ';
        widget.controller!.selection = TextSelection.fromPosition(
            TextPosition(offset: widget.controller!.text.length));
      }
    }

    return Obx(() => GestureDetector(
          onTap: () {
            if (widget.onTap != null) widget.onTap!();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  color: Theme.of(context).primaryColor.withOpacity(0.25),
                ),
                SizedBox(
                  width: MarginSizeConstant.medium.w,
                )
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.title != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MainTextWidget(
                            widget.title ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w600, color: null),
                          ),
                          widget.statusWidget ?? const SizedBox()
                        ],
                      ),
                    if (!widget.obscureText && widget.icon == null)
                      const SizedBox(
                        height: MarginSizeConstant.small,
                      ),
                    TextField(
                      readOnly: widget.readOnly,
                      controller: _controller,
                      focusNode: widget.focusNode,
                      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
                      onChanged: (val) {
                        widget.errorText!.value = '';
                        if (isTextInputPhone()) {
                          if (val.length <= 6) {
                            onRequestFocusPhoneNumber();
                          } else {
                            String afterPlus62 = val.substring(6);
                            var phoneValidation = RegExp(RegexRuleHelper.phoneNumberValidationRule.regex);
                            if (!phoneValidation.hasMatch(afterPlus62)) {
                              onRequestFocusPhoneNumber();
                            }
                            var tenCharValidation = RegexRuleHelper.maximum10CharRule;
                            if (!RegExp(tenCharValidation.regex).hasMatch(afterPlus62)) {
                              widget.errorText!.value = tenCharValidation.errorMesssage!;
                            }
                            if (widget.onChange != null) {
                              widget.onChange!('0$afterPlus62');
                            }
                          }
                        } else {
                          widget.validation?.forEach((element) {
                            RegExp regExp = RegExp(element.regex);
                            if (!regExp.hasMatch(val)) {
                              widget.errorText!.value = element.errorMesssage!;
                            }
                          });
                          if (widget.onChange != null) {
                            widget.onChange!(val);
                          }
                        }
                      },
                      keyboardType: widget.keyboardType,
                      obscureText:
                          widget.obscureText ? isShowPassword.value : false,
                      maxLines: widget.keyboardType == TextInputType.multiline
                          ? 5
                          : 1,
                      textAlign: widget.textAlign,
                      inputFormatters: [
                        if (widget.listInputFormatters != null)
                          ...widget.listInputFormatters ?? [],
                        LengthLimitingTextInputFormatter(widget.maxLength),
                      ],
                      decoration: InputDecoration(
                        hintText: widget.hint,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Theme.of(context).hintColor),
                        contentPadding: const EdgeInsets.all(0),
                        isDense: true,
                        suffix: widget.obscureText
                            ? GestureDetector(
                                onTap: () => isShowPassword.value =
                                    !isShowPassword.value,
                                child: Icon(
                                  isShowPassword.value
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                  color: Theme.of(context).hintColor,
                                ),
                              )
                            : widget.suffix,
                        border: InputBorder.none,
                      ),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color:
                              widget.readOnly ? Colors.black54 : Colors.black),
                    ),
                    if (widget.enableStrip) ...[
                      const SizedBox(
                        height: MarginSizeConstant.small,
                      ),
                      GlobalWidget.customDivider(
                        height: 1
                      )
                    ],
                    if (widget.errorText!.value.isNotEmpty) ...[
                      const SizedBox(
                        height: MarginSizeConstant.extraSmall,
                      ),
                      MainTextWidget(
                        widget.errorText!.value,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.red),
                      )
                    ]
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
