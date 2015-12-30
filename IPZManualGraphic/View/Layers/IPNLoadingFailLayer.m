//
//  IPNLoadingFailLayer.m
//  IpayNowScanner
//
//  Created by 刘宁 on 15/12/17.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "IPNLoadingFailLayer.h"
#import <UIKit/UIKit.h>

#define kActiveColor  [UIColor colorWithRed:209.0/255 green:17.0/255 blue:29.0/255 alpha:1.0]
#define kNegativeColor [UIColor colorWithRed:31.0/255 green:33.0/255 blue:48.0/255 alpha:1.0]
#define IPNRadius             30
#define IPNCellCountPerRound    21
#define IPZOriginAngle          -M_PI+M_PI*2/24
#define IPZLeftVerticalCellDistance   30*sin(45.0/180*M_PI)/9
#define IPZLeftHorizonCellDistance   30*cos(45.0/180*M_PI)/9

@implementation IPNLoadingFailLayer

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
    CGContextSetLineWidth(ctx, 2);
    CGContextBeginPath(ctx);
    
    CGFloat time = [[self presentationLayer] time];
    if (time<6) {
        CGFloat red=209/6;
        CGFloat green=17/6;
        CGFloat blue=29/6;
        red=209-red * time;
        green=17-green*time;
        blue=29-blue*time;
        CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:red/255 green:green/255 blue:blue/255 alpha:1].CGColor);
        
        CGFloat period=(1+time)*time/2;
        CGFloat startAngle=IPZOriginAngle;
        CGFloat endAngle=IPZOriginAngle-period*2*M_PI/IPNCellCountPerRound;
        CGContextAddArc(ctx, CGRectGetMidX(self.bounds) , CGRectGetMidY(self.bounds) , IPNRadius, startAngle,endAngle , 1);
        CGContextStrokePath(ctx);
        return;
    }
    
    
    CGContextSetStrokeColorWithColor(ctx, kNegativeColor.CGColor);
    time=time-6;
//    time=[self getYushuByA:time andB:14];
    CGFloat period=(1+time)*(time)/2;  //匀加速
    //        period=[self getYushuByA:time andB:24];
    period=time*4;                     //匀速
    
    CGFloat  endAngle=IPZOriginAngle;
    CGFloat  startAngle=IPZOriginAngle-2*M_PI;
    CGContextAddArc(ctx, CGRectGetMidX(self.bounds) , CGRectGetMidY(self.bounds) , IPNRadius, startAngle,endAngle , 0);
    
    if (period<10) {
        CGFloat leftX=CGRectGetMidX(self.bounds)+IPNRadius*cos(15 *2*M_PI/24);
        CGFloat leftY=CGRectGetMidY(self.bounds)+IPNRadius*sin(15 *2*M_PI/24);
        CGContextMoveToPoint(ctx, leftX, leftY);
        
        CGFloat rightX=leftX+IPZLeftHorizonCellDistance*period;
        CGFloat rightY=leftY+IPZLeftVerticalCellDistance*period;
        CGContextAddLineToPoint(ctx,rightX , rightY);
    }else if (period<14){
//        period=[self getYushuByA:period andB:12];
        CGFloat leftX=CGRectGetMidX(self.bounds)+IPNRadius*cos(15 *2*M_PI/24);
        CGFloat leftY=CGRectGetMidY(self.bounds)+IPNRadius*sin(15 *2*M_PI/24);
        CGContextMoveToPoint(ctx,leftX+IPZLeftHorizonCellDistance*(period-10), leftY+IPZLeftVerticalCellDistance*(period-10));
        
        CGFloat rightX=leftX+IPZLeftVerticalCellDistance*period;
        CGFloat rightY=leftY+IPZLeftHorizonCellDistance*period;
        CGContextAddLineToPoint(ctx,rightX , rightY );
    }else{
        period=period-14;
        
        CGFloat leftX=CGRectGetMidX(self.bounds)+IPNRadius*cos(15 *2*M_PI/24);
        CGFloat leftY=CGRectGetMidY(self.bounds)+IPNRadius*sin(15 *2*M_PI/24);
        CGContextMoveToPoint(ctx,leftX+IPZLeftHorizonCellDistance*4, leftY+IPZLeftVerticalCellDistance*4);
        CGFloat rightX=leftX+IPZLeftVerticalCellDistance*14;
        CGFloat rightY=leftY+IPZLeftHorizonCellDistance*14;
        CGContextAddLineToPoint(ctx,rightX , rightY );
        
        leftX=CGRectGetMidX(self.bounds)+IPNRadius*cos(9 *2*M_PI/24);
        leftY=CGRectGetMidY(self.bounds)+IPNRadius*sin( 9 *2*M_PI/24);
        CGContextMoveToPoint(ctx, leftX+IPZLeftHorizonCellDistance*4, leftY-IPZLeftVerticalCellDistance*4);
        
        rightX=leftX+IPZLeftVerticalCellDistance*(4+period);
        rightY=leftY-IPZLeftHorizonCellDistance*(4+period);
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
