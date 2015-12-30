//
//  IPZDynamicArcView.h
//  IPZManualGraphic
//
//  Created by 刘宁 on 15/11/3.
//  Copyright © 2015年 ipaynow. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, IPNLoadStatus) {
    IPNLoadStatusLoading   ,  //加载中
    IPNLoadStatusSuccess   ,  //成功
    IPNLoadStatusFail         //失败
};

typedef void(^IPNLoadingFinishCallback)(BOOL finish) ;

@interface IPZDynamicArcView : UIView

@property (nonatomic,assign) IPNLoadStatus status;
@property (nonatomic,strong) IPNLoadingFinishCallback callBack;

@end
