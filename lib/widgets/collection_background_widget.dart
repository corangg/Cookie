import 'package:core/values/app_assets.dart';
import 'package:core/values/app_string.dart';
import 'package:domain/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:core/util/util.dart';

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
    final test = CollectionData(type: CookieType.fromCode(1), no: 14, date: createTodayDate());

    return Stack(
      children: [
        Align(
          alignment: Alignment(0, yAlignment),
          child: Image.asset(
            AppAssets.imgCollectionBackground,
            width: screenWidth * 0.9,
            height: screenHeight,
            fit: BoxFit.fill,
          ),
        ),
        ListView.builder(
          controller: _controller,
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: _itemCollectionData(test, screenWidth*0.3)
            );
          },
        ),
      ],
    );
  }

  Widget _collectionGridView(List<String> list) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Image.asset(
              AppAssets.imgCookieCheering1,
              width: 124,
              height: 124,
            ),
          );
        });
  }

  Widget _itemCollectionData(CollectionData data, double width){
    final openCookieImg = AppAssets.imgTypeOpenCookie(data.type.code);
    return SizedBox(width: width,child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          openCookieImg,
          fit: BoxFit.fitWidth,
        ),
        Stack(
          children: [
            Image.asset(AppAssets.imgCollectionNo, fit:BoxFit.fitWidth),
            Text('${data.no}')
          ],
        )
      ],

    ),
    );
  }
}
