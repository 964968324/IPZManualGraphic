//
//  IPNLoadingCheckmarkLayer.m
//  IPZManualGraphic
//
//  Created by 刘宁 on 15/12/11.
//  Copyright © 2015年 ipaynow. All rights reserved.
//

#import "IPNLoadingCheckmarkLayer.h"

#define IPZOriginAngle     -M_PI+ M_PI*2/21
#define IPZCellDistance   50/sqrtf(2)/12

@implementation IPNLoadingCheckmarkLayer


@dynamic time;


+(BOOL)needsDisplayForKey:(NSString *)key{
    if ([@"time" isEqualToString:key]) {
        return true;
    }
    return [super needsDisplayForKey:key];
}

- (id<CAAction>)actionForKey:(NSString *)key {
    if ([key isEqualToString:@"time"]) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:key];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.fromValue = @([[self presentationLayer] time]);
        return animation;
    }
    return [super actionForKey:key];
}

-(void)drawInContext:(CGContextRef)ctx{
    
    CGContextSetRGBFillColor(ctx, 0/255.0, 165/255.0, 221/255.0, 1);
    CGContextSetRGBStrokeColor(ctx, 0/255.0, 165/255.0, 221/255.0, 1);
    CGContextSetLineWidth(ctx, 3);
    CGContextBeginPath(ctx);
    
    CGFloat time = [[self presentationLayer] time];
    if (time>7) {
        CGContextAddArc(ctx, CGRectGetMidX(self.bounds) , CGRectGetMidY(self.bounds) , 50, IPZOriginAngle-2*M_PI,IPZOriginAngle , 0);
        
        CGFloat leftX=CGRectGetMidX(self.bounds)+50*cos(13 *2*M_PI/24);
        CGFloat leftY=CGRectGetMidY(self.bounds)+50*sin(13 *2*M_PI/24);
        CGContextMoveToPoint(ctx, leftX+IPZCellDistance*7, leftY+IPZCellDistance*7);
        
        CGFloat centerX=leftX  +IPZCellDistance*12;
        CGFloat centerY=leftY  +IPZCellDistance*12;
        CGContextAddLineToPoint(ctx,centerX ,centerY);
        
        CGFloat rightX=centerX+IPZCellDistance*(12);
        CGFloat rightY=centerY-IPZCellDistance*(12);
        CGContextAddLineToPoint(ctx,rightX , rightY );
        
        CGContextStrokePath(ctx);
        return;
    }
    time=[self getYushuByA:time andB:14];
    

    CGFloat period=(1+time)*(time)/2;  //匀加速
//        period=[self getYushuByA:time andB:24];
    period=time*4;                     //匀速

    CGFloat  endAngle=IPZOriginAngle;
    CGFloat  startAngle=IPZOriginAngle-2*M_PI;
    CGContextAddArc(ctx, CGRectGetMidX(self.bounds) , CGRectGetMidY(self.bounds) , 50, startAngle,endAngle , 0);
    
    if (period<12) {
        CGFloat leftX=CGRectGetMidX(self.bounds)+50*cos(13 *2*M_PI/24);
        CGFloat leftY=CGRectGetMidY(self.bounds)+50*sin(13 *2*M_PI/24);
        CGContextMoveToPoint(ctx, leftX, leftY);
        
        CGFloat rightX=leftX+IPZCellDistance*period;
        CGFloat rightY=leftY+IPZCellDistance*period;
        CGContextAddLineToPoint(ctx,rightX , rightY);
    }else if (period<17){
        period=[self getYushuByA:period andB:12];
        CGFloat leftX=CGRectGetMidX(self.bounds)+50*cos(13 *2*M_PI/24);
        CGFloat leftY=CGRectGetMidY(self.bounds)+50*sin(13 *2*M_PI/24);
        CGContextMoveToPoint(ctx, leftX, leftY);
        
        CGFloat centerX=leftX  +IPZCellDistance*12;
        CGFloat centerY=leftY  +IPZCellDistance*12;
        CGContextAddLineToPoint(ctx,centerX ,centerY );
        
        CGFloat rightX=centerX+IPZCellDistance*period;
        CGFloat rightY=centerY-IPZCellDistance*period;
        CGContextAddLineToPoint(ctx,rightX , rightY );
    }else{
        period=period-12;

        CGFloat leftX=CGRectGetMidX(self.bounds)+50*cos(13 *2*M_PI/24);
        CGFloat leftY=CGRectGetMidY(self.bounds)+50*sin(13 *2*M_PI/24);
        CGContextMoveToPoint(ctx, leftX+IPZCellDistance*(period-5), leftY+IPZCellDistance*(period-5));
        
        CGFloat centerX=leftX  +IPZCellDistance*12;
        CGFloat centerY=leftY  +IPZCellDistance*12;
        CGContextAddLineToPoint(ctx,centerX ,centerY );
        
        CGFloat rightX=centerX+IPZCellDistance*(period);
        CGFloat rightY=centerY-IPZCellDistance*(period);
        CGContextAddLineToPoint(ctx,rightX , rightY );
    }
    CGContextStrokePath(ctx);
}

- (CGFloat)getYushuByA:(CGFloat)beichushu andB:(int)chushu{
    int bs=(int)(beichushu)/chushu;
    CGFloat yushu=beichushu-bs*chushu;
    return yushu;
}

@end
