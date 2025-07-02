import 'package:core/util/util.dart';
import 'package:core/values/app_assets.dart';
import 'package:core/values/app_color.dart';
import 'package:domain/model/models.dart';
import 'package:flutter/cupertino.dart';

class CollectionWidget extends StatefulWidget {
  final List<String> items;

  const CollectionWidget({super.key, required this.items});

  @override
  State<CollectionWidget> createState() => _CollectionBackgroundWidget();
}

class _CollectionBackgroundWidget extends State<CollectionWidget> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final maxScroll = _controller.hasClients ? _controller.position.maxScrollExtent : 0.0;
    final scrollFraction = maxScroll > 0 ? (_controller.offset.clamp(0.0, maxScroll) / maxScroll) : 0.0;
    final yAlignment = scrollFraction * 2 - 1;


    return Stack(
      children: [
        Align(
          alignment: Alignment(0, yAlignment),
          child: Image.asset(
            AppAssets.imgCollectionBackground,
            width: screenWidth*0.9,
            height: screenHeight,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth*0.1, vertical: screenHeight*0.03),
          child: _collectionGridView(widget.items),)
      ],
    );
  }

  Widget _collectionGridView(List<String> list) {
    final test = CollectionData(type: CookieType.fromCode(1), no: 14, date: createTodayDate());
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(12),
            child: _itemCollectionData(test)
          );
        });
  }

  Widget _itemCollectionData(CollectionData data){
    final openCookieImg = AppAssets.imgTypeOpenCookie(data.type.code);

    return AspectRatio(aspectRatio: 1 / 1.3,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(flex: 8, child: Image.asset(
            openCookieImg
        )),

        Expanded(flex:2,child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(AppAssets.imgCollectionNo,fit: BoxFit.contain,),
            Text('No.${data.no}',
            style: TextStyle(
              fontSize: 12, color: AppColor.mainButtonBorder, fontWeight: FontWeight.w800
            ),)
          ],)
        )
      ],
    ));
  }
}
