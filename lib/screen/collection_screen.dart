import 'package:cookie/di/injection.dart';
import 'package:cookie/main.dart';
import 'package:cookie/viewmodel/collection_view_model.dart';
import 'package:cookie/widgets/collection_background_widget.dart';
import 'package:cookie/widgets/open_collection_ui.dart';
import 'package:core/util/pair.dart';
import 'package:core/values/app_assets.dart';
import 'package:core/values/app_color.dart';
import 'package:core/values/app_string.dart';
import 'package:core/widgets/custom_img_button.dart';
import 'package:core/widgets/spinner_widget.dart';
import 'package:domain/model/models.dart';
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

class _CollectionBodyState extends State<_CollectionBody> with SingleTickerProviderStateMixin, RouteAware {
  late final CollectionViewModel viewModel;
  bool _isChecked = false;
  final ScrollController _controller = ScrollController();

  final GlobalKey _bodyKey = GlobalKey();

  CollectionData? _openedData;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<CollectionViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.setCollectionList(CookieType.fromCode(1));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final modalRoute = ModalRoute.of(context);
    if (modalRoute != null) {
      routeObserver.subscribe(this, modalRoute);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScrollController(
        controller: _controller,
        child: Scaffold(
          backgroundColor: AppColor.mainBackground,
          appBar: _buildAppBar(),
          body: SafeArea(
              child: Consumer<CollectionViewModel>(builder: (_, vm, _) {
                if (vm.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return _buildBody(vm);
                }
              })),
        ));
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

  Widget _buildBody(CollectionViewModel vm) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      key: _bodyKey,
      children: [
        Positioned(
            top: 10,
            left: screenWidth * 0.1,
            child: _collectionViewTypeSpinner(screenWidth, screenHeight)),
        Positioned(
            top: 10,
            left: screenWidth * 0.4,
            child: _viewCollectionCheckBox(screenHeight)),
        Positioned(
            top: screenHeight * 0.06,
            left: 0,
            right: 0,
            bottom: screenHeight * 0.1,
            child: CollectionWidget(items: vm.collectionList,
                screenWidth: screenWidth,
                screenHeight: screenHeight * 0.84,
                isCollected: _isChecked,
                onTap: (data) {
                  setState(() {
                    _openedData = data;
                  });
                })),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: screenHeight * 0.1,
            child: _cookieTypeListView(AppAssets.cookieTypeAssetsList, screenWidth * 0.2)),

        if (_openedData != null)
          OpenCollectionUI(
            collectionData: _openedData!,
            onClose: () => setState(() => _openedData = null),
          ),
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
              onChanged: (newValue,) {
                setState(() {_isChecked = newValue!;});
                WidgetsBinding.instance.addPostFrameCallback((_) {_scrollToTop();});
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
      onSelected: (selected) {
        viewModel.setCollectionViewType(CollectionViewType.fromCode(selected+1));

        WidgetsBinding.instance.addPostFrameCallback((_) {
          viewModel.sortByList();
          _scrollToTop();
        });
      },
    );
  }

  Widget _cookieTypeListView(List<String> items, double itemWidth) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      decoration: BoxDecoration(
          color: AppColor.collectionCookieButton,
          border: Border.all(color: AppColor.bottomNavigationBarBorder, width: 6),
          borderRadius: BorderRadius.circular(16)
      ),
      child: ListView.builder(
          itemCount: items.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final item = items[index];
            return Container(
                width: itemWidth,
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.mainBackground,
                  border: Border.all(
                      color: AppColor.bottomNavigationBarBorder, width: 3),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                alignment: Alignment.center,
                child: CustomImageButton(
                  imgAssets: item, width: itemWidth * 0.5, height: itemWidth * 0.5,
                  onPressed: () async {
                    await viewModel.setCollectionList(CookieType.fromCode(index + 1));

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      viewModel.sortByList();
                      _scrollToTop();
                    });
                  },
                )
            );
          }),
    );
  }

  void _scrollToTop() {
    if (_controller.hasClients) {
      _controller.jumpTo(0);
    }
  }
}