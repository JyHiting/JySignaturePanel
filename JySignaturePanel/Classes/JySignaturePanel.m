//
//  JySignaturePanel.m
//  JySignaturePanel
//
//  Created by flying on 2019/7/1.
//

#import "JySignaturePanel.h"


@interface JySignaturePanel()

@property (nonatomic, strong) NSMutableArray *drawPaths;
@property (nonatomic, strong) UIBezierPath *strokePath;
@property (nonatomic, assign) CGPoint prePoint;

@end

@implementation JySignaturePanel


-(instancetype)init{
    if (self = [super init]) {
        
        [self defaultConfig];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

    if (self.jy_bgImage) {
        [self.jy_bgImage drawInRect:rect];
    }
    [self.jy_strokeColor setStroke];
    [self.drawPaths enumerateObjectsUsingBlock:^(UIBezierPath *path, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [path stroke];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    _strokePath = [UIBezierPath bezierPath];
    //setting strokePath
    _strokePath.lineWidth = _jy_lineWidth;
    _strokePath.lineCapStyle = _jy_lineCapStyle;
    _strokePath.miterLimit = _jy_miterLimit;
    _strokePath.flatness = _jy_flatness;
    
    [self.drawPaths addObject:_strokePath];
    [_strokePath moveToPoint:currentPoint];
    self.prePoint = currentPoint;
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    [_strokePath addQuadCurveToPoint:currentPoint controlPoint:self.prePoint];
    self.prePoint = currentPoint;
    [self setNeedsDisplay];
}
-(void)jy_clear{

    [self.drawPaths removeAllObjects];
    [self.undoManager removeAllActions];
    self.jy_bgImage = nil;
    self.prePoint = CGPointZero;
    [self setNeedsDisplay];
}

-(BOOL)jy_isEmpty{
    if ([self.drawPaths count] == 0) {
        return true;
    }
    return false;
}

#pragma mark--默认配置
-(void)defaultConfig{
    
    self.backgroundColor = [UIColor whiteColor];
    self.jy_strokeColor = [UIColor blackColor];
    self.jy_lineWidth = 1.8;
    self.jy_lineCapStyle = kCGLineCapRound;
    self.jy_lineJoinStyle = kCGLineJoinRound;
    self.jy_flatness = 0.6;
}

-(void)setJy_bgColor:(UIColor *)jy_bgColor{
    
    self.backgroundColor = jy_bgColor;
}

-(void)setJy_lineWidth:(CGFloat)jy_lineWidth{
    
    _jy_lineWidth = jy_lineWidth;
    [self setNeedsDisplay];
}

-(void)setJy_strokeColor:(UIColor *)jy_strokeColor{
    _jy_strokeColor = jy_strokeColor;
    [self setNeedsDisplay];
}

-(void)setJy_bgImage:(UIImage *)jy_bgImage{
    _jy_bgImage = jy_bgImage;
    [self setNeedsDisplay];
}

-(void)setJy_lineCapStyle:(CGLineCap)jy_lineCapStyle{
    _jy_lineCapStyle = jy_lineCapStyle;
    [self setNeedsDisplay];
}

-(void)setJy_lineJoinStyle:(CGLineJoin)jy_lineJoinStyle{
    _jy_lineJoinStyle = jy_lineJoinStyle;
    [self setNeedsDisplay];
}

-(void)setJy_miterLimit:(CGFloat)jy_miterLimit{
    _jy_miterLimit = jy_miterLimit;
    [self setNeedsDisplay];
}

-(void)setJy_flatness:(CGFloat)jy_flatness{
    _jy_flatness = jy_flatness;
    [self setNeedsDisplay];
}

-(void)jy_undo{
    
    if (self.undoManager.canRedo) {
        [self.undoManager redo];
    }else{
        UIBezierPath *lastPath = [self.drawPaths lastObject];
        if (lastPath) {
            [self _jy_undo:lastPath];
        }
    }
}

-(void)_jy_undo:(UIBezierPath *)path{
    
    if (self.undoManager.undoing) {
        [self.drawPaths addObject:path];
    }else if (self.undoManager.redoing){
        [self.drawPaths removeObject:path];
    }else{
        [self.drawPaths removeObject:path];
    }
    [self setNeedsDisplay];
    [[self.undoManager prepareWithInvocationTarget:self] _jy_undo:path];
}
-(void)jy_redo{
    if (self.undoManager.canUndo) {
        [self.undoManager undo];
    }
}

-(void)jy_fetchImage:(ResultBlock)result{
    if (result) {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size,NO, [UIScreen mainScreen].scale);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        [self.layer drawInContext:ctx];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        result(image);
    }
}

-(NSMutableArray *)drawPaths{
    if (!_drawPaths) {
        _drawPaths = [NSMutableArray array];
    }
    return _drawPaths;
}

@end
