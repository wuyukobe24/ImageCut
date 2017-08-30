//
//  ViewController.m
//  CAShaperLayer画图
//
//  Created by WangXueqi on 17/7/6.
//  Copyright © 2017年 JingBei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,copy)UIView * demoView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self creatCAShaperLayerView];
    [self creatCircleLayer];
}

- (void)creatCAShaperLayerView {
    //原图
    UIImageView * originalImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    originalImageView.image = [UIImage imageNamed:@"project_list_word"];
    originalImageView.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/4);
    [self.view addSubview:originalImageView];
    //裁剪之后的图片
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.image = [UIImage imageNamed:@"project_list_word"];
    imageView.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2);
    [self.view addSubview:imageView];
    
    CAShapeLayer *layer = [self createMaskLayerWithView:imageView];
    imageView.layer.mask = layer;
    
    //进度条
    _demoView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    _demoView.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)*3/4);
    [self.view addSubview:_demoView];
}

//裁剪图片带尖角
- (CAShapeLayer *)createMaskLayerWithView : (UIView *)view{
    
    CGFloat viewWidth = CGRectGetWidth(view.frame);
    CGFloat viewHeight = CGRectGetHeight(view.frame);
    CGFloat rightSpace = 10.;
    CGFloat topSpace = 15.;
    
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(viewWidth-rightSpace, 0);
    CGPoint point3 = CGPointMake(viewWidth-rightSpace, topSpace);
    CGPoint point4 = CGPointMake(viewWidth, topSpace+5);
    CGPoint point5 = CGPointMake(viewWidth-rightSpace, topSpace+10.);
    CGPoint point6 = CGPointMake(viewWidth-rightSpace, viewHeight-topSpace);
    CGPoint point7 = CGPointMake(viewWidth-rightSpace*2, viewHeight-topSpace);
    CGPoint point8 = CGPointMake(viewWidth-rightSpace*2, viewHeight);
    CGPoint point9 = CGPointMake(rightSpace, viewHeight);
    CGPoint point10 = CGPointMake(rightSpace, viewHeight-topSpace);
    CGPoint point11 = CGPointMake(0, viewHeight-topSpace);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path addLineToPoint:point6];
    [path addLineToPoint:point7];
    [path addLineToPoint:point8];
    [path addLineToPoint:point9];
    [path addLineToPoint:point10];
    [path addLineToPoint:point11];
    [path closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    
    return layer;
}

//圆形进度条的实现代码
- (void)creatCircleLayer {

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = _demoView.bounds;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:_demoView.bounds];
    
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 20.0f;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    [_demoView.layer addSublayer:shapeLayer];
    
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 3.0f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [shapeLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
