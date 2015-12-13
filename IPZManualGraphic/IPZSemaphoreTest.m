//
//  IPZSemaphoreTest.m
//  
//
//  Created by 刘宁 on 15/9/10.
//
//

#import "IPZSemaphoreTest.h"
#import "IPZAsyncExcuteObject.h"

@implementation IPZSemaphoreTest
{
    dispatch_semaphore_t _sem;
    dispatch_queue_t _queue;
    
    NSString *_value;
}

-(NSString *)getValueByExcute{
    if (_sem==nil) {
        _sem=dispatch_semaphore_create(0);
        _queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    }
    
    dispatch_async(_queue, ^{
        IPZAsyncExcuteObject *excuteObject=[IPZAsyncExcuteObject new];
        excuteObject.delegate=self;
        [excuteObject excute];
    });

    dispatch_semaphore_wait(_sem, DISPATCH_TIME_NOW);
    return _value;
}

-(void)returnValue:(NSString *)value{
    _value=value;
    dispatch_semaphore_signal(_sem);
}

@end
