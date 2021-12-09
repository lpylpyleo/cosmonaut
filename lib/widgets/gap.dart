import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Make a space of [size] in flex parent.
class Gap extends LeafRenderObjectWidget {
  final double size;

  const Gap(this.size, {Key? key}) : super(key: key);

  @override
  RenderGap createRenderObject(BuildContext context) => RenderGap(size);

  @override
  void updateRenderObject(BuildContext context, RenderGap renderObject) => renderObject.gapSize = size;
}

class RenderGap extends RenderBox {
  double _gapSize;

  set gapSize(val) {
    _gapSize = val;
    markNeedsLayout();
  }

  RenderGap(double gapSize) : _gapSize = gapSize {
    assert(parent is RenderFlex?);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    switch ((parent as RenderFlex).direction) {
      case Axis.horizontal:
        return Size(_gapSize, 0);
      case Axis.vertical:
        return Size(0, _gapSize);
    }
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  double _computeSizeFor(Axis axis) => axis == (parent as RenderFlex).direction ? _gapSize : 0;

  @override
  double computeMaxIntrinsicHeight(double width) => _computeSizeFor(Axis.vertical);

  @override
  double computeMinIntrinsicHeight(double width) => _computeSizeFor(Axis.vertical);

  @override
  double computeMaxIntrinsicWidth(double height) => _computeSizeFor(Axis.horizontal);

  @override
  double computeMinIntrinsicWidth(double height) => _computeSizeFor(Axis.horizontal);
}
