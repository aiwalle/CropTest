//
//  PanViewController.m
//  GestureDemo
//
//  Created by 郭人豪 on 2017/5/21.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import "PanViewController.h"

@interface PanViewController ()
// 图片初始缩放系数
@property (nonatomic, assign) float startScale;
// 图片初始中心点
@property (nonatomic) CGPoint startImageCenter;
// 手势初始中心点
@property (nonatomic) CGPoint startGCenter;

@end

@implementation PanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test];
}

- (void)test {
    self.startScale = 1.0;
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 80, self.view.frame.size.width, 200)];
    imageView.center = self.view.center;
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:@"c001"];
    [self.view addSubview:imageView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panImage:)];
    [imageView addGestureRecognizer:pan];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchImage:)];
    [imageView addGestureRecognizer:pinch];
}

- (void)panImage:(UIPanGestureRecognizer *)pan {
    
    UIImageView * imageView = (UIImageView *)pan.view;
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        //记录中心位置
        self.startImageCenter = imageView.center;
        self.startGCenter = [pan locationInView:self.view];
        return;
    }
    
    //非开始阶段
    //获得手势移动的距离 现在的位置
    CGPoint nowGCenter = [pan locationInView:self.view];
    float x = nowGCenter.x - self.startGCenter.x;
    float y = nowGCenter.y - self.startGCenter.y;
    
//    CGFloat leftX = imageView.frame.origin.x;
//    CGFloat rightX = imageView.frame.origin.x + imageView.frame.size.width;
//
//    CGFloat topY = imageView.frame.origin.y;
//    CGFloat bottomY = imageView.frame.origin.y + imageView.frame.size.height;
//
//    CGFloat leftXMax = self.view.frame.size.width * 0.5;
//    CGFloat rightXMin = self.view.frame.size.width * 0.5;
//
//    CGFloat topYMax = self.view.frame.size.height * 0.5;
//    CGFloat bottomYMin = self.view.frame.size.height * 0.5;
//
//    if (leftX > leftXMax && x > 0) return;
//    if (rightX < rightXMin && x < 0) return;
//    if (topY > topYMax && y > 0) return;
//    if (bottomY < bottomYMin && y < 0) return;
    
    //计算imageview的相对位移
    imageView.center = CGPointMake(self.startImageCenter.x+x, self.startImageCenter.y+y);
    
//    if (pan.state == UIGestureRecognizerStateEnded) {
//        
//        imageView.center = self.startImageCenter;
//    }
    
}

-(void)pinchImage:(UIPinchGestureRecognizer *)pinch{
    
    UIImageView * imageView = (UIImageView *)pinch.view;
    
    // 缩放图片
    imageView.transform = CGAffineTransformMakeScale(pinch.scale * self.startScale, pinch.scale * self.startScale);
    
    if (pinch.state == UIGestureRecognizerStateEnded) {
        
        self.startScale *= pinch.scale;
        if (self.startScale >= 2.0) {
            
            self.startScale = 2.0;
            [UIView animateWithDuration:0.3 animations:^{
                
                imageView.transform = CGAffineTransformMakeScale(self.startScale, self.startScale);
            }];
        } else if (self.startScale <= 1) {
            
            self.startScale = 1;
            [UIView animateWithDuration:0.3 animations:^{
                imageView.center = self.view.center;
                imageView.transform = CGAffineTransformMakeScale(self.startScale, self.startScale);
            }];
        }
    }
    
}
@end
