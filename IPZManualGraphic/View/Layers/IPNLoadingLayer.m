//
//  IPNLoadingLayer.m
//  IPZManualGraphic
//
//  Created by 刘宁 on 15/12/13.
//  Copyright © 2015年 ipaynow. All rights reserved.
//

#import "IPNLoadingLayer.h"

#define IPNCellCountPerRound    21
#define IPZOriginAngle          -M_PI+M_PI*2/IPNCellCountPerRound
#define IPNTimePerRound         6
#define IPNDelayPerRound        0.5
#define IPNTimePerFullRound     6.5
#define IPNFullTime             13

@implementation IPNLoadingLayer


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
    time=[self getYushuByA:time andB:IPNFullTime];
    
    CGFloat originAngle=IPZOriginAngle;
    CGFloat startAngle=0;
    CGFloat endAngle=0;
    if (time <=IPNTimePerFullRound ) {//弧长度
        if (time>IPNTimePerRound) {
            time=IPNTimePerRound;
        }
        CGFloat period=(1+time)*time/2;
        startAngle=originAngle;
        endAngle=originAngle-period*2*M_PI/IPNCellCountPerRound;
        CGContextAddArc(ctx, CGRectGetMidX(self.bounds) , CGRectGetMidY(self.bounds) , 50, startAngle,endAngle , 1);
    }else{
        if (time>(IPNTimePerRound+IPNTimePerFullRound)) {
            time=IPNTimePerRound+IPNTimePerFullRound;
        }
        CGFloat period=(1+time-IPNTimePerFullRound)*(time-IPNTimePerFullRound)/2;  //匀加速
        if (period>=IPNCellCountPerRound) {
            period=0;
        }
        
        startAngle=originAngle-period*2*M_PI/IPNCellCountPerRound;
        endAngle=originAngle;
        CGContextAddArc(ctx, CGRectGetMidX(self.bounds) , CGRectGetMidY(self.bounds) , 50, startAngle,endAngle , 1);
    }
    
    CGContextStrokePath(ctx);
}

- (CGFloat)getYushuByA:(CGFloat)beichushu andB:(int)chushu{
    int bs=(int)(beichushu)/chushu;
    CGFloat yushu=beichushu-bs*chushu;
    return yushu;
}


@end
