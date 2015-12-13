//
//  ViewController.m
//  IPZManualGraphic
//
//  Created by 刘宁 on 15/8/24.
//  Copyright (c) 2015年 ipaynow. All rights reserved.
//

#import "ViewController.h"
#import "IPZTransform3DView.h"
#import "IPZSemaphoreTest.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet IPZTransform3DView *threeDview;
- (IBAction)btnRotateClick:(id)sender;
- (IBAction)btnSignal:(id)sender;

@end

@implementation ViewController
{
    dispatch_semaphore_t _sem;
    dispatch_queue_t _queue;
}

- (void)viewDidLoad {

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnRotateClick:(id)sender {
    if (_sem==nil) {
        _sem=dispatch_semaphore_create(0);
        _queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    }
    dispatch_async(_queue, ^{
        dispatch_semaphore_wait(_sem, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            [_threeDview rotate3D];
        });
    });
    
    
}

- (IBAction)btnSignal:(id)sender {
    _queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
//    dispatch_async(_queue, ^{
        IPZSemaphoreTest *sem=[IPZSemaphoreTest new];
        NSString *value= [sem getValueByExcute];
//    });
}
@end
