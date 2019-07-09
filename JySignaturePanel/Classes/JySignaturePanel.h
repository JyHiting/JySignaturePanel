//
//  JySignaturePanel.h
//  JySignaturePanel
//
//  Created by flying on 2019/7/1.
//

#import <UIKit/UIKit.h>

typedef void(^ResultBlock)(UIImage *img);

@interface JySignaturePanel : UIView

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

//撤销
-(void)jy_undo;
//回滚
-(void)jy_redo;
//清除签名
-(void)jy_clear;
//是否有签名
-(BOOL)jy_isEmpty;
//获取签名图片
-(void)jy_fetchImage:(ResultBlock)result;




@end
