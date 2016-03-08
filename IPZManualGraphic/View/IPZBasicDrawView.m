//
//  IPZBasicDrawView.m
//  
//
//  Created by 刘宁 on 15/8/25.
//
//

#import "IPZBasicDrawView.h"

@implementation IPZBasicDrawView
{
    __weak UIImageView *_imgView;
}

-(void)layoutSubviews{
    if (_imgView==nil) {
        CGRect rect=self.bounds;
        
        UIGraphicsBeginImageContext(rect.size);
        [[UIColor whiteColor] setFill];
        [[UIColor blueColor] setStroke];
        UIBezierPath *path=[UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, 1)];
        [path addQuadCurveToPoint:CGPointMake(CGRectGetMaxX(rect), 1) controlPoint:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))];
        [path closePath];
        [path stroke];
        [path fill];
        UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:rect];
        imgView.image=image;
        [self insertSubview:imgView atIndex:0];
        _imgView=imgView;
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    float size=self.bounds.size.width<self.bounds.size.height ?self.bounds.size.width:self.bounds.size.height ;
    float radius=size/2;
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(ctx, 240/255.0, 242/255.0, 244/255.0, 1);
    CGContextAddArc(ctx, radius, radius, radius-10, 0, 2*M_PI, 0);
    CGContextFillPath(ctx);
    
    CGContextSetLineWidth(ctx, 5);
    CGContextSetRGBStrokeColor(ctx,  0, 165/255.0, 221/255.0, 1);
    CGContextAddArc(ctx, radius, radius, radius-50, 0, 2*M_PI, 0);
    CGContextStrokePath(ctx);
    
    CGContextSetLineWidth(ctx, 1);
    CGContextAddEllipseInRect(ctx, self.bounds);
    CGContextStrokePath(ctx);
    
    CGContextSetRenderingIntent(ctx, kCGRenderingIntentPerceptual);


}


@end
