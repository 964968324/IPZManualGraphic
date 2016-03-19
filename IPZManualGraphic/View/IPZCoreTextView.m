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
    
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    IPZMarkupParser* p = [[IPZMarkupParser alloc] init];
    NSAttributedString* attrString = [p attrStringFromMarkup: @"These are <font color=\"red\">red<font color=\"black\"> and <font color=\"blue\">blue <font color=\"black\">words"];
    
    CTFramesetterRef frameSetter=
        CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);
    CTFrameRef frame=CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    CFRange frameRange = CTFrameGetVisibleStringRange(frame); //所给frame下可见文本范围
    CTFrameDraw(frame, context);

    CFRelease(frame);
    CFRelease(frameSetter);
    CFRelease(path);
}



@end
