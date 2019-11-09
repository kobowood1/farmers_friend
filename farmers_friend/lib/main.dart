import 'package:farmers_friend/src/app.dart';
import 'package:farmers_friend/src/provider/crop_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(
  ScopedModel<CropModel>(
    model: CropModel(),
    child: App()
    )
  );

