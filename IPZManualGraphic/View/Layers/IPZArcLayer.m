            //
//  IPZArcLayer.m
//  IPZManualGraphic
//
//  Created by 刘宁 on 15/11/3.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "IPZArcLayer.h"

#define IPZOriginAngle -M_PI_2

@implementation IPZArcLayer

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
    CGFloat time = [[self presentationLayer] time];
    CGFloat originAngle=IPZOriginAngle+ (int)(time/21)*M_PI*2/12;
    
    CGFloat startAngle=0;
    CGFloat endAngle=0;
    CGFloat period=[self getYushuByA:time andB:21];
    if (period <8 ) {//弧长度
        startAngle=originAngle;
        endAngle=originAngle+period*2*M_PI/12;
    }else if (period<13){//伸展长度
        startAngle=originAngle+[self getYushuByA:period andB:8]*2*M_PI/12;
        endAngle=originAngle+period*2*M_PI/12;
    }else{
         startAngle=originAngle+([self getYushuByA:period andB:13]+5)*2*M_PI/12;
         endAngle=originAngle+M_PI*2/12;
    }
    
    CGContextSetRGBFillColor(ctx, 0/255.0, 165/255.0, 221/255.0, 1);
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, CGRectGetMidX(self.bounds) , CGRectGetMidY(self.bounds));
    
    CGContextAddArc(ctx, CGRectGetMidX(self.bounds) , CGRectGetMidY(self.bounds) , 50, startAngle,endAngle , 0);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
}

- (CGFloat)getYushuByA:(CGFloat)beichushu andB:(int)chushu{
    int bs=(int)(beichushu)/chushu;
    CGFloat yushu=beichushu-bs*chushu;
    return yushu;
}

@end
