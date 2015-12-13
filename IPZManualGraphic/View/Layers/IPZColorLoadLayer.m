//
//  IPZColorLoadLayer.m
//  IPZManualGraphic
//
//  Created by 刘宁 on 15/9/2.
//  Copyright (c) 2015年 ipaynow. All rights reserved.
//

#import "IPZColorLoadLayer.h"

@implementation IPZColorLoadLayer

@dynamic loadTime;

+(BOOL)needsDisplayForKey:(NSString *)key{
    if ([@"loadTime" isEqualToString:key]) {
        return  true;
    }
    return [super needsDisplayForKey:key];
}

-(id<CAAction>)actionForKey:(NSString *)event{
    if ([self presentationLayer]!=nil) {
        if ([@"loadTime" isEqualToString:event]) {
            CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"loadTime"];
            animation.fromValue=[[self presentationLayer] valueForKey:@"loadTime"];
            return animation;
        }
    }
    return [super actionForKey:event];
}

-(void)drawInContext:(CGContextRef)ctx{
    CGGradientRef myGradient;
    CGColorSpaceRef myColorspace;
    size_t num_locations = 5;
    CGFloat locations[5] = { 0.0,0.25,0.5,0.75, 1.0 };
    CGFloat components[20] =
        {[self getColor:0.6], [self getColor:1.0], 0.0, 1.0, // Start color
        [self getColor:0.7], [self getColor:0.9], 0.0, 1.0,  // Second color
        [self getColor:0.8], [self getColor:0.8], 0.0, 1.0,  // Third color
        [self getColor:0.9], [self getColor:0.7], 0.0, 1.0,  // Fourth color
        [self getColor:1.0], [self getColor:0.6], 0.0, 1.0,  // End color

};
    
    myColorspace = CGColorSpaceCreateDeviceRGB();
    myGradient = CGGradientCreateWithColorComponents (myColorspace, components,
                                                      locations, num_locations);
    
    CGPoint myStartPoint, myEndPoint;
    CGRect frame=self.bounds;
    myStartPoint.x = 0.0;
    myStartPoint.y = frame.origin.y;
    myEndPoint.x = frame.size.width;
    myEndPoint.y = frame.origin.y;
    CGContextDrawLinearGradient (ctx, myGradient, myStartPoint, myEndPoint, 0);
}


- (CGFloat)getColor:(CGFloat)originValue{
    int offset=self.loadTime % 8 ;
    int value=originValue*10+offset;
    if (value>10) {
        value=10-value%10;
    }
    
    if (value<6) {
        int origin=originValue *10;
        value=6+(value -(10-origin))%4;
    }
    
    NSLog(@"origin=%f,offset=%d,value=%d",originValue,offset,value);
    
    return value/10.0f;
}


@end
