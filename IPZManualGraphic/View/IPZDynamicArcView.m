//
//  IPZDynamicArcView.m
//  IPZManualGraphic
//
//  Created by 刘宁 on 15/11/3.
//  Copyright © 2015年 ipaynow. All rights reserved.
//

#import "IPZDynamicArcView.h"
#import "IPZArcLayer.h"
#import "IPNLoadingCheckmarkLayer.h"
#import "IPNLoadingLayer.h"

#define IPNTimePerRound         6
#define IPNFullTime             13

@implementation IPZDynamicArcView
{
    __weak IPNLoadingLayer *_loadingLayer;
    int _loadingTime;
    int _finishTime;
    
    BOOL _hasFinish;
    __weak IPNLoadingCheckmarkLayer *_checkmarkLayer;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    _finishTime=INT32_MAX;
    IPNLoadingLayer *layer=[IPNLoadingLayer new];
    layer.frame=CGRectMake(0, 0, 200, 200);
    [self.layer addSublayer:layer];
    _loadingLayer=layer;
    [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(updateColor:) userInfo:nil repeats:true];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.status=IPNLoadStatusSuccess;
    });
}

-(void)setStatus:(IPNLoadStatus)status{
    if (status==IPNLoadStatusSuccess) {
        int round=_loadingTime/IPNFullTime;
        int currentValue=round%IPNFullTime;
        if (currentValue<=IPNTimePerRound) {
            _finishTime=round*IPNFullTime+IPNTimePerRound;
        }else{
            _finishTime=(round+1)*IPNFullTime+IPNTimePerRound;
        }
    }
}

- (void)updateColor:(id)sender{
    _loadingTime++;
    if(_loadingTime==_finishTime){
        _hasFinish=true;
        _loadingTime=0;
        
        IPNLoadingCheckmarkLayer *layer=[IPNLoadingCheckmarkLayer new];
        layer.frame=CGRectMake(0, 0, 200, 200);
        [self.layer addSublayer:layer];
        _checkmarkLayer=layer;
    }
    
    if (!_hasFinish) {
        _loadingLayer.time=_loadingTime;
    }else{
        if (_loadingTime>6) {
            NSTimer *timer=sender;
            [timer invalidate];
            return;
            
            
        }
        _checkmarkLayer.time=_loadingTime;
    }
}

@end
