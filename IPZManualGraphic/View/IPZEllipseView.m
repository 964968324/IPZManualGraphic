//
//  IPZEllipseView.m
//  IPZManualGraphic
//
//  Created by 刘宁 on 16/3/20.
//  Copyright © 2016年 ipaynow. All rights reserved.
//

#import "IPZEllipseView.h"

@implementation IPZEllipseView

-(void)awakeFromNib{
    CGRect rect=self.bounds;
    
    CAShapeLayer *shape=[CAShapeLayer layer];
    shape.fillColor=[UIColor greenColor].CGColor;
    
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path  addQuadCurveToPoint:CGPointMake(CGRectGetMaxX(rect), 0) controlPoint:CGPointMake(CGRectGetMidX(rect), -30)];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect))];
    [path addLineToPoint:CGPointMake(0, CGRectGetMaxY(rect))];
    [path closePath];
    shape.path=path.CGPath;
    
    [self.layer addSublayer:shape];
}



@end
