import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/core.dart';
import 'shimmer.dart';

class KCachedImg extends StatelessWidget {
  const KCachedImg(
    this.url, {
    super.key,
    this.color,
    this.fit = BoxFit.contain,
    this.height = 150,
    this.padding = const EdgeInsets.all(3),
    this.radius = 10,
    this.width,
    this.showPreview = false,
  });

  final Color? color;
  final BoxFit fit;
  final double height;
  final EdgeInsetsGeometry padding;
  final double radius;
  final bool showPreview;
  final String url;
  final double? width;

  ImageProvider get provider => CachedNetworkImageProvider(
        url,
        maxHeight: height.toInt(),
        maxWidth: width?.toInt(),
      );

  _onTap(BuildContext context) =>
      showDialog(context: context, builder: (context) => ImageDialog(url: url));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: showPreview ? () => _onTap(context) : null,
          child: CachedNetworkImage(
            color: color,
            height: height,
            width: width,
            imageUrl: url,
            fit: fit,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                KShimmer(
              child: SizedBox(
                height: height,
                width: width ?? 150,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PlatformImgViewer extends StatelessWidget {
  const PlatformImgViewer(
    this.url, {
    super.key,
    this.color,
    this.fit = BoxFit.contain,
    this.height = 150,
    this.padding = const EdgeInsets.all(3),
    this.radius = 10,
    this.width,
    this.showPreview = false,
  });

  final String url;
  final Color? color;
  final BoxFit fit;
  final double height;
  final double? width;
  final EdgeInsetsGeometry padding;
  final double radius;
  final bool showPreview;

  ImageProvider<Object> get provider {
    if (url.isValidURL || url.isWebFile) {
      return CachedNetworkImageProvider(
        url,
        maxHeight: height.toInt(),
        maxWidth: width?.toInt(),
      );
    }

    return FileImage(File(url));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: url.isValidURL || url.isWebFile
            ? KCachedImg(
                url,
                color: color,
                fit: fit,
                height: height,
                width: width,
                padding: padding,
                radius: radius,
                showPreview: showPreview,
              )
            : Padding(
                padding: padding,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child: Image.file(
                    File(url),
                    color: color,
                    fit: fit,
                    height: height,
                    width: width,
                  ),
                ),
              ),
      ),
    );
  }
}

class ImageDialog extends StatefulWidget {
  const ImageDialog({
    super.key,
    required this.url,
    this.isAsset = false,
  });

  final String url;
  final bool isAsset;

  @override
  State<ImageDialog> createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton.outlined(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.close),
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          maxScale: 5,
          child: widget.isAsset
              ? Image.asset(
                  widget.url,
                  width: context.width,
                  height: context.height,
                  fit: BoxFit.contain,
                )
              : KCachedImg(
                  widget.url,
                  width: context.width,
                  height: context.height,
                  fit: BoxFit.contain,
                ),
        ),
      ),
    );
  }
}
