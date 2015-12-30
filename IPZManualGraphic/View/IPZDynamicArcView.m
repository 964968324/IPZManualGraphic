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
#import "IPNLoadingFailLayer.h"

#define IPNTimePerRound         6
#define IPNFullTime             13

@implementation IPZDynamicArcView
{
    __weak IPNLoadingLayer *_loadingLayer;
    int _loadingTime;
    int _finishTime;
    
    BOOL _hasFinish;
    __weak IPNLoadingCheckmarkLayer *_checkmarkLayer;
    __weak IPNLoadingFailLayer              *_failLayer;
    
    __weak NSTimer *_timer;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    _finishTime=INT32_MAX;
    
    IPNLoadingLayer *layer=[IPNLoadingLayer new];
    layer.frame=self.bounds;
    layer.shouldRasterize=true;
    [self.layer addSublayer:layer];
    _loadingLayer=layer;
    _timer=[NSTimer scheduledTimerWithTimeInterval:0.11 target:self selector:@selector(updateProgress:) userInfo:nil repeats:true];
}

-(void)setStatus:(IPNLoadStatus)status{
    _status=status;
    if (status==IPNLoadStatusSuccess || status==IPNLoadStatusFail) {
        int round=_loadingTime/IPNFullTime;
        _finishTime=(round+1)*IPNFullTime;
    }
}

- (void)updateProgress:(id)sender{
    _loadingTime++;
    if(!_hasFinish && _loadingTime>_finishTime){
        _hasFinish=true;
        _loadingTime=0;
        if (_status==IPNLoadStatusSuccess) {
            _callBack(true);
            IPNLoadingCheckmarkLayer *layer=[IPNLoadingCheckmarkLayer new];
            layer.frame=self.bounds;
            layer.shouldRasterize=true;
            layer.time=0;
            [self.layer addSublayer:layer];
            _checkmarkLayer=layer;
        }else{
            _callBack(false);
            IPNLoadingFailLayer *layer=[IPNLoadingFailLayer new];
            layer.frame=self.bounds;
            layer.shouldRasterize=true;
            layer.time=0;
            [self.layer addSublayer:layer];
            _failLayer=layer;
        }
    }
    
    if (!_hasFinish) {
        _loadingLayer.time=_loadingTime;
    }else{
        if (_loadingTime>12) {
            [_loadingLayer removeFromSuperlayer];
            NSTimer *timer=sender;
            [timer invalidate];
            return;
        }
        _checkmarkLayer.time=_loadingTime;
        _failLayer.time=_loadingTime;
    }
}

-(void)dealloc{
    [_timer invalidate];
    _timer=nil;
}

@end
