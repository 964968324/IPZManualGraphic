//
//  IPZCoreTextView.m
//  IPZManualGraphic
//
//  Created by 刘宁 on 16/3/19.
//  Copyright © 2016年 ipaynow. All rights reserved.
//

#import "IPZCoreTextView.h"
#import <CoreText/CoreText.h>
#import "IPZMarkupParser.h"

@implementation IPZCoreTextView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    
    IPZMarkupParser* p = [[IPZMarkupParser alloc] init];
    NSAttributedString* attrString = [p attrStringFromMarkup: @"These are <font color=\"red\">red<font color=\"black\"> and <font color=\"blue\">blue <font color=\"black\">words"];
    CTFramesetterRef frameSetter=
        CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);
    int originIndex=0,i=2;
    CGFloat maxY=CGRectGetMaxY(rect);
    while (originIndex<attrString.length) {
        int random=arc4random()%50;
        CGMutablePathRef path=CGPathCreateMutable();
        CGPathAddRect(path, NULL, CGRectMake(random, maxY-40*i++, 100, 40));
        
        CTFrameRef frame=CTFramesetterCreateFrame(frameSetter, CFRangeMake(originIndex, 0), path, NULL);
        CFRange frameRange = CTFrameGetVisibleStringRange(frame); //所给frame下可见文本范围
        originIndex+=frameRange.length;
        
        CTFrameDraw(frame, context);
        CFRelease(path);
        CFRelease(frame);
    }
    

    CFRelease(frameSetter);
    
    
    UIImage *image=[UIImage imageNamed:@"Twitter.jpg"];
    CGContextDrawImage(context, CGRectMake(CGRectGetMidX(rect)-50, CGRectGetMidY(rect)-50, 100, 100), image.CGImage);
}



@end
