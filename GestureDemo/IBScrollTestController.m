//
//  IBScrollTestController.m
//  GestureDemo
//
//  Created by xmly on 2022/12/6.
//  Copyright © 2022 Abner_G. All rights reserved.
//

#import "IBScrollTestController.h"

@interface IBView : UIView

@end
@implementation IBView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"Liang Scrollview touchesBegan");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"Liang Scrollview touchesMoved");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"Liang Scrollview touchesCancelled");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"Liang Scrollview touchesEnded");
}

@end

@interface IBScrollTestController ()

@end

@implementation IBScrollTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(100, 100, 250, 250)];
    sc.contentSize = CGSizeMake(250, 400);
    sc.bounces = YES;
    sc.backgroundColor = UIColor.greenColor;
    [self.view addSubview:sc];
    
    
    sc.delaysContentTouches = NO;
    sc.canCancelContentTouches = NO;
    
    IBView *redView = [[IBView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    redView.backgroundColor = UIColor.redColor;
    [sc addSubview:redView];
    redView.center = CGPointMake(sc.frame.size.width * 0.5, sc.frame.size.height * 0.5);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
