import 'package:core/util/pair.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  final List<String> dropdownList;
  final Pair<double, double> dropdownBoxPadding;
  final Color dropdownBoxColor;
  final Color dropdownBoxBorderColor;
  final double dropdownBoxBorderWidth;
  final double dropdownBoxBorderRadius;
  final double dropdownBoxHeight;
  final double dropdownBoxWidth;
  final double dropdownBoxTextSize;
  final Color dropdownBoxTextColor;
  final FontWeight dropdownBoxTextWeight;
  final bool isIcon;
  final IconData iconData;
  final Color iconColor;
  final Color itemBackgroundColor;
  final Color itemBorderColor;
  final double itemBorderWidth;
  final double dropdownListMaxHeight;
  final double dropdownItemWidth;
  final double dropdownItemHeight;
  final double dropdownListRadius;
  final double dropdownItemTextSize;
  final Color dropdownItemTextColor;
  final FontWeight dropdownItemTextWeight;
  final Color selectItemIconColor;
  final IconData selectItemIcon;
  final double selectItemIconSize;

  const DropDownWidget({
    super.key,
    required this.dropdownList,
    this.dropdownBoxPadding = const Pair(12.0, 4.0),
    this.dropdownBoxColor = const Color(0xFFFFFFFF),
    this.dropdownBoxBorderColor = const Color(0xFFFFFFFF),
    this.dropdownBoxBorderWidth = 4.0,
    this.dropdownBoxBorderRadius = 12.0,
    this.dropdownBoxHeight = 40.0,
    this.dropdownBoxWidth = 100.0,
    this.isIcon = false,
    this.iconData = Icons.keyboard_arrow_down,
    this.iconColor = const Color(0xFF000000),
    this.itemBackgroundColor = const Color(0xFFFFFFFF),
    this.itemBorderColor = const Color(0xFF000000),
    this.itemBorderWidth = 4.0,
    this.dropdownBoxTextSize = 14.0,
    this.dropdownBoxTextColor = const Color(0xFF000000),
    this.dropdownBoxTextWeight = FontWeight.bold,
    this.dropdownListMaxHeight = 200,
    this.dropdownItemWidth = 80,
    this.dropdownItemHeight = 40,
    this.dropdownListRadius = 12.0,
    this.dropdownItemTextSize = 14.0,
    this.dropdownItemTextColor = const Color(0xFF000000),
    this.dropdownItemTextWeight = FontWeight.bold,
    this.selectItemIconColor = const Color(0xFF000000),
    this.selectItemIcon = Icons.check,
    this.selectItemIconSize = 14,
  });

  @override
  State<DropDownWidget> createState() => _SpinnerWidget();
}

class _SpinnerWidget extends State<DropDownWidget> {
  final GlobalKey _buttonKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.dropdownList.first;
  }

  @override
  Widget build(BuildContext context) {
    return _buildDropdown();
  }

  Widget _buildDropdown() {
    return SizedBox(
        width: widget.dropdownBoxWidth,
        height: widget.dropdownBoxHeight,
        child: GestureDetector(
            key: _buttonKey,
            child: _dropdownBox(),
            onTap: () {
              _showOverlay();
            }
        )
    );
  }

  Widget _dropdownBox() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: widget.dropdownBoxPadding.first,
        vertical: widget.dropdownBoxPadding.second,
      ),
      decoration: BoxDecoration(
        color: widget.dropdownBoxColor,
        border: Border.all(color: widget.dropdownBoxBorderColor, width: widget.dropdownBoxBorderWidth),
        borderRadius: BorderRadius.circular(widget.dropdownBoxBorderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _selectedValue,
            style: TextStyle(
              fontSize: widget.dropdownBoxTextSize,
              color: widget.dropdownBoxTextColor,
              fontWeight: widget.dropdownBoxTextWeight,
            ),
          ),
          if (widget.isIcon) ...[
            const SizedBox(width: 4),
            Icon(widget.iconData, color: widget.iconColor),
          ],
        ],
      ),
    );
  }

  void _showOverlay() {
    final RenderBox button = _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final Size size = button.size;
    final Offset offset = button.localToGlobal(Offset.zero);

    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      return;
    }

    _overlayEntry = OverlayEntry(builder: (context) {
      return Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                _overlayEntry?.remove();
                _overlayEntry = null;
              },
            ),
          ),
          _dropdownList(offset, size)
        ],
      );
    });
    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget _dropdownList(Offset offset, Size size) {
    return Positioned(left: offset.dx,
      top: offset.dy + size.height,
      width: widget.dropdownItemWidth,
      child: Material(
        elevation: 4,
        color: Colors.transparent,
        child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: widget.dropdownListMaxHeight),
            child: _drawListView()
        )
      )
    );
  }

  BoxDecoration _setDropdownListDecoration(){
    return BoxDecoration(
      color: widget.itemBackgroundColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: widget.itemBorderColor,
          width: widget.itemBorderWidth),
    );
  }

  Widget _drawListView(){
    return Container(
      decoration: _setDropdownListDecoration(),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: widget.dropdownList.length,
        itemBuilder: (context, index) {
          final item = widget.dropdownList[index];
          final bool isSelected = item == _selectedValue;
          return InkWell(
            onTap: () {
              setState(() => _selectedValue = item);
              _overlayEntry?.remove();
              _overlayEntry = null;
            },
            child: _drawItem(isSelected, item)
          );
        },
      ),
    );
  }

  Widget _drawItem(bool isSelected, String itemString){
    return SizedBox(
      width: widget.dropdownItemWidth,
      height: widget.dropdownItemHeight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final iconOffsetX = getIconOffsetX(constraints, itemString);
          return Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  itemString,
                  style: TextStyle(
                    fontSize: widget.dropdownItemTextSize,
                    color: widget.dropdownItemTextColor,
                    fontWeight: widget.dropdownItemTextWeight,
                  ),
                ),
              ),

              if (isSelected)
                Align(
                  alignment: FractionalOffset(iconOffsetX, 0.5),
                  child: Icon(
                    widget.selectItemIcon,
                    size: widget.selectItemIconSize,
                    color: widget.selectItemIconColor,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  double getIconOffsetX(BoxConstraints constraints, String itemString) {
    final totalWidth = constraints.maxWidth;
    final textPainter = TextPainter(
      text: TextSpan(
        text: itemString,
        style: TextStyle(
          fontSize: widget.dropdownItemTextSize,
          color: widget.dropdownItemTextColor,
          fontWeight: widget.dropdownItemTextWeight,
        ),
      ),
      textDirection: TextDirection.ltr,
    )
      ..layout(minWidth: 0, maxWidth: totalWidth);
    final textWidth = textPainter.width;
    final margin = 12.0;
    final iconX = (totalWidth - textWidth) / 2 - margin - widget.selectItemIconSize;
    return (iconX / totalWidth).clamp(0.0, 1.0);
  }
}