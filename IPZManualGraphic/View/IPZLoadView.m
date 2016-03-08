//
//  IPZLoadView.m
//  
//
//  Created by 刘宁 on 15/9/1.
//
//

#import "IPZLoadView.h"
#import "IPZPointLayer.h"

@implementation IPZLoadView

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initAnimationByPtCount:5 andMaxDuration:50];
}

-(void)drawRect:(CGRect)rect{
    self.layer.masksToBounds=true;
}

-(void)initAnimationByPtCount:(int)ptCount andMaxDuration:(int)duration{
    double width=self.bounds.size.width;
    double height=self.bounds.size.height;
    int posCount=2*(ptCount -1 ) +ceil(width/duration)+1;
    int center=floor(width/2/duration)+1;
    
    NSMutableArray *positions;
    for (int i=0; i<ptCount; i++) {
        positions=[NSMutableArray arrayWithCapacity:posCount];
        for (int j=1; j<=posCount; j++) {
            int pos=j-i;
            if (pos<=1) {
                [positions addObject:@(-1)];
                continue;
            }
            
            int offset=pos-center;
            if (offset<0) {//中点往左
                pos =(pos-1) *duration;
                [positions addObject:@(pos)];
            }else if (offset>=0 && offset <ptCount) {  //中点
                if (offset<floor(ptCount/2)+1) {
                    pos=(center-1) *duration +5*(  offset-floor(ptCount/2)-1);
                    [positions addObject:@(pos)];
                }else{
                    pos=(center-1) *duration +5*(  offset-floor(ptCount/2)-1);
                    [positions addObject:@(pos)];
                }
                
            }else{
                pos=pos-ptCount;
                pos *= duration;
                [positions addObject:@(pos)];
            }
            
        }
        
        IPZPointLayer *firPT=[[IPZPointLayer alloc]init];
        firPT.position=CGPointMake(-1, height/2);
        [self.layer addSublayer:firPT];
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"position.x";
        animation.values = positions;      //各级值
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.duration = 3;
        animation.repeatCount= HUGE_VALF;
        animation.additive = YES;  //添加动画到所有子视图
        [firPT addAnimation:animation forKey:@"shake"];
    }
}


@end
