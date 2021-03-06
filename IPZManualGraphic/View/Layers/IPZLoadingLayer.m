//
//  IPZLoadingLayer.m
//  IPZManualGraphic
//
//  Created by 刘宁 on 15/12/13.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "IPZLoadingLayer.h"
#import <UIKit/UIKit.h>

#define kActiveColor  [UIColor colorWithRed:209.0/255 green:17.0/255 blue:29.0/255 alpha:1.0]
#define IPZRadius             30
#define IPZCellCountPerRound    21
#define IPZOriginAngle          -M_PI+M_PI*2/24
#define IPZTimePerRound         6
#define IPZDelayPerRound        0.5
#define IPZTimePerFullRound     6.5
#define IPZFullTime             13

@implementation IPZLoadingLayer


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
    CGContextSetStrokeColorWithColor(ctx, kActiveColor.CGColor);
    CGContextSetLineWidth(ctx, 2);
    CGContextBeginPath(ctx);
    
    CGFloat time = [[self presentationLayer] time];
    time=[self getYushuByA:time andB:IPZFullTime];
    
    CGFloat originAngle=IPZOriginAngle;
    CGFloat startAngle=0;
    CGFloat endAngle=0;
    if (time <=IPZTimePerFullRound ) {//弧长度
        if (time>IPZTimePerRound) {
            time=IPZTimePerRound;
        }
        CGFloat period=(1+time)*time/2;
        startAngle=originAngle;
        endAngle=originAngle-period*2*M_PI/IPZCellCountPerRound;
        CGContextAddArc(ctx, CGRectGetMidX(self.bounds) , CGRectGetMidY(self.bounds) , IPZRadius, startAngle,endAngle , 1);
    }else{
        if (time>(IPZTimePerRound+IPZTimePerFullRound)) {
            time=IPZTimePerRound+IPZTimePerFullRound;
        }
        CGFloat period=(1+time-IPZTimePerFullRound)*(time-IPZTimePerFullRound)/2;  //匀加速
        if (period>=IPZCellCountPerRound) {
            period=0;
        }
        
        startAngle=originAngle-period*2*M_PI/IPZCellCountPerRound;
        endAngle=originAngle;
        CGContextAddArc(ctx, CGRectGetMidX(self.bounds) , CGRectGetMidY(self.bounds) , IPZRadius, startAngle,endAngle , 1);
    }
    
    CGContextStrokePath(ctx);
}

- (CGFloat)getYushuByA:(CGFloat)beichushu andB:(int)chushu{
    int bs=(int)(beichushu)/chushu;
    CGFloat yushu=beichushu-bs*chushu;
    return yushu;
}


@end
