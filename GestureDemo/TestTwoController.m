//
//  TestTwoController.m
//  GestureDemo
//
//  Created by xmly on 2022/10/12.
//  Copyright © 2022 Abner_G. All rights reserved.
//

#import "TestTwoController.h"
#import "IBScrollView.h"
@interface TestTwoController ()
@property (nonatomic, strong) IBScrollView *scrollView;
@end

@implementation TestTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *originImg = [UIImage imageNamed:@"c001"];
    
    CGFloat navHeight = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat scrollX = 0;
    CGFloat scrollY = navHeight;
    CGFloat scrollH = self.view.frame.size.height - navHeight;
    CGFloat scrollW = self.view.frame.size.width;
    self.scrollView.frame = CGRectMake(scrollX, scrollY, scrollW, scrollH);
    [self.view addSubview:self.scrollView];
    
    self.scrollView.originImg = originImg;
}

- (IBScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[IBScrollView alloc] init];
//        _scrollView.bouncesZoom = YES;
//        _scrollView.maximumZoomScale = 2.5;
//        _scrollView.minimumZoomScale = 1.0;
//        _scrollView.multipleTouchEnabled = YES;
//        _scrollView.delegate = self;
//        _scrollView.scrollsToTop = NO;
//        _scrollView.showsHorizontalScrollIndicator = NO;
//        _scrollView.showsVerticalScrollIndicator = NO;
////        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        _scrollView.delaysContentTouches = NO;
//        _scrollView.canCancelContentTouches = YES;
//        _scrollView.alwaysBounceVertical = NO;
//        _scrollView.contentOffset = CGPointMake(-100, -100)
//        _scrollView.contentInset = UIEdgeInsetsMake(200, 200, 200, 200);
    }
    return _scrollView;
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
