import 'package:cookie/di/injection.dart';
import 'package:cookie/viewmodel/collection_view_model.dart';
import 'package:cookie/widgets/collection_background_widget.dart';
import 'package:core/util/pair.dart';
import 'package:core/values/app_color.dart';
import 'package:core/values/app_string.dart';
import 'package:core/widgets/spinner_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CollectionViewModel>(
      create: (_) => sl<CollectionViewModel>(),
      child: const _CollectionBody(),
    );
  }
}

class _CollectionBody extends StatefulWidget {
  const _CollectionBody({super.key});

  @override
  State<_CollectionBody> createState() => _CollectionBodyState();
}

class _CollectionBodyState extends State<_CollectionBody> with SingleTickerProviderStateMixin {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainBackground,
      appBar: _buildAppBar(),
      body: SafeArea(child: Consumer<CollectionViewModel>(builder: (_, vm, _) {
        if (vm.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return _buildBody();
        }
      })),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.mainBackground,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Collection',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildBody() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
          top: 0,
            left: screenWidth*0.1,
            child: Container(
              child: _collectionViewTypeSpinner(screenWidth,screenHeight),
            )),
        Positioned(
            top: 0,
            left: screenWidth * 0.4,
            child: Container(
              //color: Colors.red,
              child: _viewCollectionCheckBox(screenHeight),)
        ),
        Positioned(
            top: screenHeight * 0.07,
            left: 0,
            right: 0,
            bottom: 0,
            child: CollectionWidget(items: AppStrings.cheeringCollectionList))
      ],
    );
  }
  
  Widget _viewCollectionCheckBox(double screenHeight) {
    return SizedBox(
      height: screenHeight * 0.04,
      child: Row(
        children: [
          Checkbox(
              value: _isChecked,
              checkColor: AppColor.bottomNavigationBarBorder,
              activeColor: AppColor.checkboxCheck,
              visualDensity: const VisualDensity(horizontal: -4,),
              side: WidgetStateBorderSide.resolveWith((states) {
                return const BorderSide(
                    color: AppColor.bottomNavigationBarBorder, width: 3);
              }),
              onChanged: (bool? newValue,) {
                setState(() {
                  _isChecked = newValue!;
                });
              }),
          Text(
            AppStrings.textShowCollectionCookie,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16, color: AppColor.bottomNavigationBarBorder)),
        ],
      ),
    );
  }


  Widget _collectionViewTypeSpinner(double screenWidth,double screenHeight) {
    return DropDownWidget(
      dropdownList: AppStrings.viewTypeList,
      dropdownBoxPadding: Pair(12, 4),
      dropdownBoxColor: AppColor.spinnerBackground,
      dropdownBoxBorderColor: AppColor.bottomNavigationBarBorder,
      dropdownBoxBorderWidth: 4,
      dropdownBoxBorderRadius: 12,
      dropdownBoxWidth: screenWidth * 0.3,
      dropdownBoxHeight: screenHeight * 0.04,
      isIcon: false,
      itemBackgroundColor: AppColor.spinnerBackground,
      itemBorderColor: AppColor.bottomNavigationBarBorder,
      dropdownBoxTextSize: 14,
      dropdownBoxTextColor: AppColor.bottomNavigationBarBorder,
      dropdownBoxTextWeight: FontWeight.w900,
      dropdownListMaxHeight: 200,
      dropdownListRadius: 12,
      dropdownItemWidth: screenWidth * 0.3,
      dropdownItemHeight: 40,
      dropdownItemTextSize: 14,
      dropdownItemTextColor: AppColor.bottomNavigationBarBorder,
      dropdownItemTextWeight: FontWeight.w900,
      selectItemIconColor: AppColor.bottomNavigationBarBorder,
      selectItemIconSize: 14,
    );
  }
}