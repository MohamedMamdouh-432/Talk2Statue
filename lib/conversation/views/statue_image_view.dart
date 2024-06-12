import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatueImageView extends StatelessWidget {
	final String statueFileImage;
	
	const StatueImageView({
		super.key,
		required this.statueFileImage,
	});

	@override
	Widget build(BuildContext context) {
		final File statueImageFile = File(statueFileImage);
		return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: Image.file(
            statueImageFile,
            fit: BoxFit.fitWidth,
            width: double.infinity,
            height: context.height * 0.6,
            filterQuality: FilterQuality.high,
          ),
        );
	}
}
