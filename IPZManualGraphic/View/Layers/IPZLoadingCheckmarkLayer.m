//
//  IPZLoadingCheckmarkLayer.m
//  IPZManualGraphic
//
//  Created by 刘宁 on 15/12/11.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "IPZLoadingCheckmarkLayer.h"
#import <UIKit/UIKit.h>

#define kActiveColor  [UIColor colorWithRed:209.0/255 green:17.0/255 blue:29.0/255 alpha:1.0]
#define IPZRadius             30
#define IPZCellCountPerRound    21
#define IPZOriginAngle     -M_PI+M_PI*2/24
#define IPZLeftVerticalCellDistance   30*sin(45.0/180*M_PI)/12
#define IPZLeftHorizonCellDistance   30*cos(45.0/180*M_PI)/12

@implementation IPZLoadingCheckmarkLayer


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
    if (time<6) {
        CGFloat period=(1+time)*time/2;
        CGFloat startAngle=IPZOriginAngle;
        CGFloat endAngle=IPZOriginAngle-period*2*M_PI/IPZCellCountPerRound;
        CGContextAddArc(ctx, CGRectGetMidX(self.bounds) , CGRectGetMidY(self.bounds) , IPZRadius, startAngle,endAngle , 1);
        CGContextStrokePath(ctx);
        return;
    }
    
    
//    time=[self getYushuByA:time andB:14];
    time=time-6;
    CGFloat period=(1+time)*(time)/2;  //匀加速
//        period=[self getYushuByA:time andB:24];
    period=time*4;                     //匀速

    CGFloat  endAngle=IPZOriginAngle;
    CGFloat  startAngle=IPZOriginAngle-2*M_PI;
    CGContextAddArc(ctx, CGRectGetMidX(self.bounds) , CGRectGetMidY(self.bounds) , IPZRadius, startAngle,endAngle , 0);
    
    if (period<12) {
        CGFloat leftX=CGRectGetMidX(self.bounds)+IPZRadius*cos(13 *2*M_PI/24);
        CGFloat leftY=CGRectGetMidY(self.bounds)+IPZRadius*sin(13 *2*M_PI/24);
        CGContextMoveToPoint(ctx, leftX, leftY);
        
        CGFloat rightX=leftX+IPZLeftHorizonCellDistance*period;
        CGFloat rightY=leftY+IPZLeftVerticalCellDistance*period;
        CGContextAddLineToPoint(ctx,rightX , rightY);
    }else if (period<17){
        period=[self getYushuByA:period andB:12];
        CGFloat leftX=CGRectGetMidX(self.bounds)+IPZRadius*cos(13 *2*M_PI/24);
        CGFloat leftY=CGRectGetMidY(self.bounds)+IPZRadius*sin(13 *2*M_PI/24);
        CGContextMoveToPoint(ctx, leftX, leftY);
        
        CGFloat centerX=leftX  +IPZLeftHorizonCellDistance*12;
        CGFloat centerY=leftY  +IPZLeftVerticalCellDistance*12;
        CGContextAddLineToPoint(ctx,centerX ,centerY );
        
        CGFloat rightX=centerX+IPZLeftVerticalCellDistance*period;
        CGFloat rightY=centerY-IPZLeftHorizonCellDistance*period;
        CGContextAddLineToPoint(ctx,rightX , rightY );
    }else{
        period=period-12;

        CGFloat leftX=CGRectGetMidX(self.bounds)+IPZRadius*cos(13 *2*M_PI/24);
        CGFloat leftY=CGRectGetMidY(self.bounds)+IPZRadius*sin(13 *2*M_PI/24);
        CGContextMoveToPoint(ctx, leftX+IPZLeftHorizonCellDistance*(period-5), leftY+IPZLeftVerticalCellDistance*(period-5));
        
        CGFloat centerX=leftX  +IPZLeftHorizonCellDistance*12;
        CGFloat centerY=leftY  +IPZLeftVerticalCellDistance*12;
        CGContextAddLineToPoint(ctx,centerX ,centerY );
        
        CGFloat rightX=centerX+IPZLeftVerticalCellDistance*(period);
        CGFloat rightY=centerY-IPZLeftHorizonCellDistance*(period);
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
