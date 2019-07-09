# JySignaturePanel
![演示图片](https://github.com/JyHiting/JySignaturePanel/blob/master/Example/jy_address_picker.gif)
## 简单的签名组件
# 安装
`pod 'JySignaturePanel'`
# 使用
## 创建实例
```
_panel = JySignaturePanel.new;
_panel.jy_bgColor = [UIColor yellowColor];
[self.view addSubview:_panel];
```
## 常见可设置属性和系统一样
```
//画板背景色
@property (nonatomic, strong) UIColor *jy_bgColor;
//画笔颜色
@property (nonatomic, strong) UIColor *jy_strokeColor;
//背景图片
@property (nonatomic, strong) UIImage *jy_bgImage;
//如下属性同系统属性
@property (nonatomic, assign) CGFloat jy_lineWidth;
@property (nonatomic, assign) CGLineCap jy_lineCapStyle;
@property (nonatomic, assign) CGLineJoin jy_lineJoinStyle;
@property (nonatomic, assign) CGFloat jy_miterLimit;
@property (nonatomic, assign) CGFloat jy_flatness;
```
## 以笔画为单位撤销和回滚签名
```
[self.panel jy_undo];
[self.panel jy_redo];
```
## 清除签名
```
[_panel jy_clear];
```
## 设置背景图片
```
_panel.jy_bgImage = [UIImage imageNamed:@"cat.jpg"];
```
## 判断是否有签名
```
_panel.jy_isEmpty
```
## 获取签名图片
```
[_panel jy_fetchImage:^(UIImage * _Nonnull img) {
        
}];
```

