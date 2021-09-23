import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state/bottom_navigator/bottom_navigator.dart';
import '../../state/bottom_navigator/bottom_navigator_provider.dart';

class TabIconData {
  TabIconData({
    required this.type,
    required this.animationController,
  });

  final BottomNavigatorType type;
  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      type: BottomNavigatorType.home,
      animationController: null,
    ),
    TabIconData(
      type: BottomNavigatorType.setting,
      animationController: null,
    ),
  ];
}

class BottomBarView extends StatefulWidget {
  BottomBarView({
    required this.changeIndex,
    required this.addClick,
    Key? key,
  }) : super(key: key);

  final void Function(int index) changeIndex;
  final VoidCallback addClick;
  final List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  @override
  _BottomBarViewState createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    animationController?.forward();
    super.initState();
  }

  @override
  void dispose() {
    if (animationController != null) {
      animationController?.dispose();
      animationController = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const addButtonRadius = 38;

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        AnimatedBuilder(
          animation: animationController!,
          builder: (BuildContext context, Widget? child) {
            return Transform(
              transform: Matrix4.translationValues(0, 0, 0),
              child: PhysicalShape(
                color: theme.backgroundColor,
                elevation: 20,
                clipper: TabClipper(
                  radius: Tween<double>(begin: 0, end: 1)
                          .animate(CurvedAnimation(
                              parent: animationController!,
                              curve: Curves.fastOutSlowIn))
                          .value *
                      addButtonRadius,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 4),
                        child: Row(
                          children: [
                            Expanded(
                              child: TabIcons(
                                tabIconData: widget.tabIconsList[0],
                              ),
                            ),
                            SizedBox(
                              width: Tween<double>(begin: 0, end: 1)
                                      .animate(CurvedAnimation(
                                          parent: animationController!,
                                          curve: Curves.fastOutSlowIn))
                                      .value *
                                  64,
                            ),
                            Expanded(
                              child: TabIcons(
                                tabIconData: widget.tabIconsList[1],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    )
                  ],
                ),
              ),
            );
          },
        ),
        Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          child: SizedBox(
            width: addButtonRadius * 2,
            height: addButtonRadius + 60,
            child: Container(
              alignment: Alignment.topCenter,
              color: Colors.transparent,
              child: SizedBox(
                width: addButtonRadius * 2,
                height: addButtonRadius * 2,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0, end: 1).animate(
                      CurvedAnimation(
                          parent: animationController!,
                          curve: Curves.fastOutSlowIn),
                    ),
                    child: GestureDetector(
                      onTap: widget.addClick,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                theme.primaryColorDark,
                                theme.primaryColor,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          shape: BoxShape.circle,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: theme.primaryColor.withOpacity(0.4),
                              offset: const Offset(8, 16),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.white.withOpacity(0.1),
                            highlightColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            child: Icon(
                              Icons.add,
                              color: theme.backgroundColor,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TabIcons extends ConsumerStatefulWidget {
  const TabIcons({
    required this.tabIconData,
    Key? key,
  }) : super(key: key);

  final TabIconData tabIconData;

  @override
  _TabIconsState createState() => _TabIconsState();
}

class _TabIconsState extends ConsumerState<TabIcons>
    with TickerProviderStateMixin {
  @override
  void initState() {
    widget.tabIconData.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          if (!mounted) return;
          widget.tabIconData.animationController?.reverse();
        }
      });
    super.initState();
  }

  void setAnimation() {
    widget.tabIconData.animationController?.forward();
  }

  Widget _createBubble(
    ThemeData theme, {
    double? top,
    double? left,
    double? right,
    double? bottom,
    required Interval interval,
    required double radius,
  }) =>
      Positioned(
        top: top,
        left: left,
        right: right,
        bottom: bottom,
        child: ScaleTransition(
          alignment: Alignment.center,
          scale: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              parent: widget.tabIconData.animationController!,
              curve: interval,
            ),
          ),
          child: Container(
            width: radius,
            height: radius,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final currentScreenState = ref.watch(currentBottomNavigatorStateProvider);
    final notifier = ref.read(currentBottomNavigatorStateProvider.notifier);

    final theme = Theme.of(context);
    final isSelected = currentScreenState == widget.tabIconData.type;

    return AspectRatio(
      aspectRatio: 1,
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () {
          if (widget.tabIconData.type != currentScreenState) {
            notifier.setCurrentBottomNavigator(widget.tabIconData.type.index);
            setAnimation();
          }
        },
        child: Center(
          child: IgnorePointer(
            child: SizedBox(
              width: 52,
              height: 52,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.88, end: 1)
                        .animate(CurvedAnimation(
                      parent: widget.tabIconData.animationController!,
                      curve:
                          const Interval(0.1, 1, curve: Curves.fastOutSlowIn),
                    )),
                    child: Column(
                      children: [
                        Icon(
                          widget.tabIconData.type.iconData,
                          color: isSelected
                              ? theme.primaryColor
                              : theme.disabledColor,
                          size: 36,
                        ),
                        Text(
                          widget.tabIconData.type.label,
                          style: isSelected
                              ? theme.textTheme.caption
                                  ?.copyWith(color: theme.primaryColor)
                              : theme.textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  _createBubble(
                    theme,
                    right: 0,
                    top: 0,
                    left: 6,
                    interval:
                        const Interval(0.2, 1, curve: Curves.fastOutSlowIn),
                    radius: 8,
                  ),
                  _createBubble(
                    theme,
                    top: 0,
                    left: 6,
                    bottom: 8,
                    interval:
                        const Interval(0, 0.8, curve: Curves.fastOutSlowIn),
                    radius: 4,
                  ),
                  _createBubble(
                    theme,
                    top: 6,
                    right: 8,
                    bottom: 0,
                    interval:
                        const Interval(0.3, 0.6, curve: Curves.fastOutSlowIn),
                    radius: 6,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TabClipper extends CustomClipper<Path> {
  TabClipper({this.radius = 38});

  final double radius;
  @override
  Path getClip(Size size) {
    final path = Path();

    final v = radius * 2;
    path
      ..lineTo(0, 0)
      ..arcTo(
        Rect.fromLTWH(0, 0, radius, radius),
        degreeToRadians(180),
        degreeToRadians(90),
        false,
      )
      ..arcTo(
        Rect.fromLTWH((size.width / 2 - v) + v * 0.04, 0, radius, radius),
        degreeToRadians(270),
        degreeToRadians(70),
        false,
      )
      ..arcTo(
        Rect.fromLTWH(size.width / 2 - radius, -radius, v, v),
        degreeToRadians(160),
        degreeToRadians(-140),
        false,
      )
      ..arcTo(
        Rect.fromLTWH((size.width - (size.width / 2 - radius)) - v * 0.04, 0,
            radius, radius),
        degreeToRadians(200),
        degreeToRadians(70),
        false,
      )
      ..arcTo(
        Rect.fromLTWH(size.width - radius, 0, radius, radius),
        degreeToRadians(270),
        degreeToRadians(90),
        false,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(TabClipper oldClipper) => true;

  double degreeToRadians(double degree) {
    final redian = (math.pi / 180) * degree;
    return redian;
  }
}
