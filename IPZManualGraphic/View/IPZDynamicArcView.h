//
//  IPZDynamicArcView.h
//  IPZManualGraphic
//
//  Created by 刘宁 on 15/11/3.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, IPZLoadStatus) {
    IPZLoadStatusLoading   ,  //加载中
    IPZLoadStatusSuccess   ,  //成功
    IPZLoadStatusFail         //失败
};

typedef void(^IPZLoadingFinishCallback)() ;

@interface IPZDynamicArcView : UIView

@property (nonatomic,assign) IPZLoadStatus status;
@property (nonatomic,copy) IPZLoadingFinishCallback callBack;

@end
