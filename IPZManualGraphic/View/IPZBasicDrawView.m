//
//  IPZBasicDrawView.m
//  
//
//  Created by 刘宁 on 15/8/25.
//
//

#import "IPZBasicDrawView.h"

@implementation IPZBasicDrawView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
//    float size=self.bounds.size.width<self.bounds.size.height ?self.bounds.size.width:self.bounds.size.height ;
//    float radius=size/2;
//    CGContextRef ctx=UIGraphicsGetCurrentContext();
//    CGContextSetRGBFillColor(ctx, 245/255.0, 247/255.0, 249/255.0, 1);
//    CGContextAddArc(ctx, radius, radius, radius-10, 0, 2*M_PI, 0);
//    CGContextAddArc(ctx, radius, radius, radius-50, 0, 2*M_PI, 1);
//        CGContextAddArc(ctx, radius, radius, radius-80, 0, 2*M_PI, 0);
//    CGContextFillPath(ctx);
//    
//    CGContextSetLineWidth(ctx, 5);
//    CGContextSetRGBStrokeColor(ctx,  0, 165/255.0, 221/255.0, 1);
//    CGContextAddArc(ctx, radius, radius, radius-10, 0, 2*M_PI, 0);
//    CGContextStrokePath(ctx);
//    
//    CGContextSetLineWidth(ctx, 0);
//    CGContextAddEllipseInRect(ctx, self.bounds);
//    CGContextStrokePath(ctx);
//    
//    CGContextSetRenderingIntent(ctx, kCGRenderingIntentPerceptual);

    [[UIColor whiteColor] setFill];
    [[UIColor blueColor] setStroke];
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addQuadCurveToPoint:CGPointMake(CGRectGetMaxX(rect), 0) controlPoint:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))];
    [path closePath];
    [path stroke];
    [path fill];
}


//-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
//    
//}


@end
