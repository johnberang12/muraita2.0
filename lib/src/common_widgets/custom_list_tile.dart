import 'package:flutter/material.dart';
import 'package:muraita_2_0/src/constants/app_sizes.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    this.thumbnail,
    this.title,
    this.subTitle,
    this.caption,
    this.trailing1,
    this.trailing2,
    this.expansionTile,
    this.onTap,
  }) : super(key: key);

  final Widget? thumbnail;
  final Widget? title;
  final Widget? subTitle;
  final Widget? caption;
  final List<Widget>? trailing1;
  final List<Widget>? trailing2;
  final ExpansionTile? expansionTile;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .14,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: thumbnail ?? const SizedBox(),
            ),
            Expanded(
              flex: 4,
              child: _ProductDescription(
                title: title,
                subTitle: subTitle,
                caption: caption,
                trailing1: trailing1,
                trailing2: trailing2,
              ),
            ),
            const FittedBox(
              fit: BoxFit.scaleDown,
              child: Icon(
                Icons.more_vert,
                size: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductDescription extends StatelessWidget {
  const _ProductDescription(
      {Key? key,
      this.title,
      this.subTitle,
      this.caption,
      this.trailing1,
      this.trailing2})
      : super(key: key);

  final Widget? title;
  final Widget? subTitle;
  final Widget? caption;
  final List<Widget>? trailing1;
  final List<Widget>? trailing2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Sizes.p12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  title ?? const SizedBox(),
                  gapH4,
                  subTitle ?? const SizedBox(),
                  gapH8,
                  caption ?? const SizedBox(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: double.infinity,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: trailing1 ?? const [],
                      ),
                      gapW8,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: trailing2 ?? const [],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
