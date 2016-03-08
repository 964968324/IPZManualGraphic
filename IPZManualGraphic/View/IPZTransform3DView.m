//
//  IPZTransform3DView.m
//  
//
//  Created by 刘宁 on 15/8/24.
//
//

#import "IPZTransform3DView.h"

@implementation IPZTransform3DView


-(void)rotate3D{
    CATransform3D transform = self.layer.transform;
    transform.m34 = 0.0005; // 透视效果
    transform = CATransform3DRotate(transform,(M_PI/180*40), 0, 1, 0);
    [self.layer setTransform:transform];
}

- (void)animationCubeRotatewithDuration:(float)duration{
//    [CATransaction flush];
    CGFloat height = self.bounds.size.height;
    CABasicAnimation *rotation;
    // CABasicAnimation *translationX;	// 如果沿X轴翻转,则用不到这个变量.
    CABasicAnimation *translationY;	// 如果沿Y轴翻转,则用不到这个变量.
    CABasicAnimation *translationZ;
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.delegate = self;
    animationGroup.duration = duration;
    
    // 创建(某方向)关键帧动画.
    translationY = [CABasicAnimation animationWithKeyPath:
                    @"transform.translation.y"];
    translationY.toValue = [NSNumber numberWithFloat:-(height / 2)];
    rotation = [CABasicAnimation animationWithKeyPath:
                @"transform.rotation.x"];
    rotation.toValue = [NSNumber numberWithFloat:D2R(-60.0f)];
    rotation.duration=duration;

    
    // 处理Z轴
    translationZ = [CABasicAnimation animationWithKeyPath:
                    @"transform.translation.z"];
    translationZ.toValue = [NSNumber numberWithFloat:height / 2];
    animationGroup.animations =
    [NSArray arrayWithObjects: rotation,  nil];
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    animationGroup.duration=duration;
    [self.layer addAnimation:animationGroup forKey:@"kAnimation3D"];
}

double D2R(double degree){
    return degree *M_PI /180;
}


@end
