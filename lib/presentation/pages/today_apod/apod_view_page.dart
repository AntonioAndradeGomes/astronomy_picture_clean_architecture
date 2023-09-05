import 'package:astronomy_picture/core/constants/custom_colors.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:flutter/material.dart';

class ApodViewPage extends StatelessWidget {
  final Apod apod;
  const ApodViewPage({
    super.key,
    required this.apod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: CustomColors.white.withOpacity(0),
        elevation: 0,
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                CustomColors.spaceBlue,
                CustomColors.black,
              ],
            ),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  ClipRRect(
                    child: Container(
                      height: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            apod.url ?? "",
                          ),
                          fit: BoxFit.fitHeight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        border: Border.all(
                          color: CustomColors.white.withOpacity(
                            0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
