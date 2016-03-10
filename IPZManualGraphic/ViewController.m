//
//  ViewController.m
//  IPZManualGraphic
//
//  Created by 刘宁 on 15/8/24.
//  Copyright (c) 2015年 刘宁. All rights reserved.
//

#import "ViewController.h"
#import "IPZDynamicArcView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet IPZDynamicArcView *loadingView;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;

- (IBAction)btnSuccessClick:(id)sender;
- (IBAction)btnFailClick:(id)sender;

@end

@implementation ViewController


- (void)viewDidLoad {
    // Do any additional setup after loading the view, typically from a nib.
    
    __weak ViewController *weakSelf=self;
    _loadingView.callBack=^(){
        NSString *strResult;
        if(_loadingView.status==IPZLoadStatusSuccess) {
            strResult=@"加载成功";
        }else{
            strResult=@"加载失败";
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.lblDesc.text=strResult;
        });
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSuccessClick:(id)sender {
    _loadingView.status=IPZLoadStatusSuccess;
}

- (IBAction)btnFailClick:(id)sender {
    _loadingView.status=IPZLoadStatusFail;
}
@end
