//
//  IPZDynamicArcView.m
//  IPZManualGraphic
//
//  Created by 刘宁 on 15/11/3.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "IPZDynamicArcView.h"
#import "IPZArcLayer.h"
#import "IPZLoadingCheckmarkLayer.h"
#import "IPZLoadingLayer.h"
#import "IPZLoadingFailLayer.h"

#define IPZTimePerRound         6
#define IPZFullTime             13

@implementation IPZDynamicArcView
{
    __weak IPZLoadingLayer *_loadingLayer;
    int _loadingTime;
    int _finishTime;
    
    BOOL _hasFinish;
    __weak IPZLoadingCheckmarkLayer *_checkmarkLayer;
    __weak IPZLoadingFailLayer      *_failLayer;
    
    __weak NSTimer *_timer;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    _finishTime=INT32_MAX;
    
    IPZLoadingLayer *layer=[IPZLoadingLayer new];
    layer.frame=self.bounds;
    layer.shouldRasterize=true;
    [self.layer addSublayer:layer];
    _loadingLayer=layer;
    _timer=[NSTimer scheduledTimerWithTimeInterval:0.11 target:self selector:@selector(updateProgress:) userInfo:nil repeats:true];
}

-(void)setStatus:(IPZLoadStatus)status{
    if (_status!=IPZLoadStatusLoading) {
        return;
    }
    
    _status=status;
    if (status==IPZLoadStatusSuccess || status==IPZLoadStatusFail) {
        int round=_loadingTime/IPZFullTime;
        _finishTime=(round+1)*IPZFullTime;
    }
}

- (void)updateProgress:(id)sender{
    _loadingTime++;
    if(!_hasFinish && _loadingTime>_finishTime){
        _hasFinish=true;
        _loadingTime=0;
        if (_status==IPZLoadStatusSuccess) {
            _callBack();
            IPZLoadingCheckmarkLayer *layer=[IPZLoadingCheckmarkLayer new];
            layer.frame=self.bounds;
            layer.shouldRasterize=true;
            layer.time=0;
            [self.layer addSublayer:layer];
            _checkmarkLayer=layer;
        }else{
            _callBack();
            IPZLoadingFailLayer *layer=[IPZLoadingFailLayer new];
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
