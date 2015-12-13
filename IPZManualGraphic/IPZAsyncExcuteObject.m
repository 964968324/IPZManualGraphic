//
//  IPZExcuteObject.m
//  
//
//  Created by 刘宁 on 15/9/10.
//
//

#import "IPZAsyncExcuteObject.h"

@implementation IPZAsyncExcuteObject

-(void)excute{
    sleep(3);
    [self.delegate returnValue:@"111"];
}

@end
