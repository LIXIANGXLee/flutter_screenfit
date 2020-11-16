import 'dart:ui';

/// 屏幕适配类
class FlutterScreenFit {

  /// 类似单列模式
  static FlutterScreenFit _instance;

  /// 私有属性定义
  static double _physicalWidth;
  static double _physicalHeight;
  static double _screenWidth;
  static double _screenHeight;
  static double _dpr;
  static double _statusHeight;
  static double _bottomBarHeight;
  static double _rpx;
  static double _px;

  /// 创建一个私有的构造函数
  FlutterScreenFit._();

  ///工厂方法 在此地方使用 类似iOS里的单例模式
  factory FlutterScreenFit() {
     return  _instance ??= FlutterScreenFit._();
  }

  /// 默认是按照按照iphone6 375屏幕尺寸计算 需要修改可设置此参数
  void initialize({double standardSize = 750}) {

    /// 获取手机的物理分辨率
    _physicalWidth = window.physicalSize.width;
    _physicalHeight = window.physicalSize.height;

    /// 获取手机的dpr
    _dpr = window.devicePixelRatio;

    /// 根据屏幕物理尺寸和dpr计算出真正的屏幕尺寸 宽度和高度
    _screenWidth = _physicalWidth / _dpr;
    _screenHeight = _physicalHeight / _dpr;

    /// 获取设备状态栏高度
    _statusHeight = window.padding.top / _dpr;
    /// 获取设备底部安全区域高度
    _bottomBarHeight = window.padding.bottom / _dpr;

    /// 计算rpx的大小 和计算 px大小
    _rpx = _screenWidth / standardSize;
    _px = _screenWidth / standardSize * 2;

  }

  /// 设置rpx尺寸进行适配
  double setRpx(double size) => _rpx * size;

  /// 设置px尺寸进行适配
  double setPx(double size) => _px * size;

  /// 获取当前设备的PixelRatio
  double get dpr =>  _dpr;

  /// 当前设备宽度 dp
  double get screenWidth => _screenWidth;

  ///当前设备高度 dp
  double get screenHeight => _screenHeight;

  /// 当前设备宽度 物理宽度 px
  double get screenWidthPx => _physicalWidth;

  /// 当前设备高度 物理宽度 px
  double get screenHeightPx => _physicalHeight;

  /// 状态栏高度 dp 如果设备带刘海，则会加上刘海的高度
  double get statusBarHeight => _statusHeight;

  /// 底部安全区距离 dp
  double get bottomBarHeight => _bottomBarHeight;

}

/// 为屏幕适配 扩展后缀调用方法
extension SizeExtension on num {

  /// 按照rps适配  例如：iphone 750的设计稿 则用此方法
  double get rpx => FlutterScreenFit().setRpx(this.toDouble());

  /// 按照ps适配 iphone 375的设计稿 则用此方法
  double get px => FlutterScreenFit().setPx(this.toDouble());

}