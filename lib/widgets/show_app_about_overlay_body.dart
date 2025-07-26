import 'package:cookie/viewmodel/more_screen_view_model.dart';
import 'package:core/values/app_color.dart';
import 'package:core/values/app_string.dart';
import 'package:flutter/cupertino.dart';

class ShowAppAboutOverlayBody extends StatefulWidget {
  final double overlayWidth;
  final double overlayHeight;
  final MoreScreenViewModel viewModel;

  const ShowAppAboutOverlayBody({
    super.key,
    required this.overlayWidth,
    required this.overlayHeight,
    required this.viewModel
  });

  @override
  State<ShowAppAboutOverlayBody> createState() => _ShowAppAboutOverlayBody();
}

class _ShowAppAboutOverlayBody extends State<ShowAppAboutOverlayBody> {

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          SizedBox(height: widget.overlayHeight * 0.01,),
          Align(
            alignment: Alignment.center,
            child: Text(AppStrings.privacyPolicyTitle, style: TextStyle(color: AppColor.mainTextColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,),),
          ),
          SizedBox(height: widget.overlayHeight * 0.01,),
          Text(
            AppStrings.privacyPolicy,
            style: TextStyle(color: AppColor.mainTextColor,
            fontSize: 12),),
        ]
    );
  }
}