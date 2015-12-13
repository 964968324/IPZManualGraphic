//
//  IPZSemaphoreTest.h
//  
//
//  Created by 刘宁 on 15/9/10.
//
//

#import <Foundation/Foundation.h>

@protocol IPZCallBackProtocol <NSObject>

-(void) returnValue:(NSString *)value;

@end

@interface IPZSemaphoreTest : NSObject<IPZCallBackProtocol>

-(NSString *) getValueByExcute;

@end
