//
//  IPZPointLayer.m
//  
//
//  Created by 刘宁 on 15/9/1.
//
//

#import "IPZPointLayer.h"
#import <UIKit/UIKit.h>

@implementation IPZPointLayer

-(instancetype)init{
    self=[super init];
    if (self) {
        self.bounds = CGRectMake(0, 0, 3, 3);
        self.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
        self.fillColor = [UIColor blackColor].CGColor;
    }
    return self;
}

@end
