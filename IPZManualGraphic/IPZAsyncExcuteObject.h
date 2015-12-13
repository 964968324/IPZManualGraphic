//
//  IPZExcuteObject.h
//  
//
//  Created by 刘宁 on 15/9/10.
//
//

#import <Foundation/Foundation.h>
#import "IPZSemaphoreTest.h"

@interface IPZAsyncExcuteObject : NSObject

@property id<IPZCallBackProtocol> delegate;

- (void)excute;

@end
