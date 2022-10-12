//
//  TestController.m
//  GestureDemo
//
//  Created by xmly on 2022/10/12.
//  Copyright © 2022 Abner_G. All rights reserved.
//

#import "TestController.h"

@interface TestController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIImage *originImg;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *imageContainerView;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation TestController
static float testValue = 200;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.originImg = [UIImage imageNamed:@"c001"];
    
    [self.view addSubview:self.scrollView];
    CGFloat navHeight = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat scrollX = 0;
    CGFloat scrollY = navHeight;
    CGFloat scrollH = self.view.frame.size.height - navHeight;
    CGFloat scrollW = self.view.frame.size.width;
    self.scrollView.frame = CGRectMake(scrollX, scrollY, scrollW, scrollH);
    
//    CGRect imageViewRect = [self getImgFrameInImageViewRect:self.scrollView.bounds contentImg:self.originImg];
//    self.imageContainerView.frame = imageViewRect;
//    self.imageView.frame = self.imageContainerView.bounds;
//    [self.scrollView addSubview:self.imageContainerView];
//    [self.imageContainerView addSubview:self.imageView];
    
    CGRect imageViewRect = [self getImgFrameInImageViewRect:self.scrollView.bounds contentImg:self.originImg];
    self.imageView.frame = imageViewRect;
    [self.scrollView addSubview:self.imageView];
    
    self.imageView.image = self.originImg;
//    CGFloat testValue = 200;
    self.scrollView.contentSize = CGSizeMake(imageViewRect.size.width + testValue, self.scrollView.frame.size.height + testValue);
//    self.scrollView.contentOffset = CGPointMake(100, 100);
    self.scrollView.contentInset = UIEdgeInsetsMake(testValue, testValue, testValue, testValue);
//    self.scrollView.contentOffset = CGPointZero;
//    CGFloat testValue = 200;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width + testValue, self.scrollView.contentSize.height + testValue);
//        self.scrollView.contentInset = UIEdgeInsetsMake(testValue, testValue, testValue, testValue);
//    });
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.bouncesZoom = YES;
        _scrollView.maximumZoomScale = 5.5;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.multipleTouchEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.scrollsToTop = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
//        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollView.delaysContentTouches = NO;
        _scrollView.canCancelContentTouches = YES;
        _scrollView.alwaysBounceVertical = NO;
//        _scrollView.contentOffset = CGPointMake(-100, -100)
//        _scrollView.contentInset = UIEdgeInsetsMake(200, 200, 200, 200);
    }
    return _scrollView;
}

- (UIView *)imageContainerView {
    if (!_imageContainerView) {
        _imageContainerView = [[UIView alloc] init];
    }
    return _imageContainerView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _imageView;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
//    scrollView.contentInset = UIEdgeInsetsZero;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    CGFloat contentWidth = scrollView.frame.size.width + testValue;
    CGFloat contentHeight = scrollView.frame.size.height + testValue;
    if (scrollView.contentSize.width > contentWidth) {
        contentWidth = scrollView.contentSize.width + testValue;
    }
    
    if (scrollView.contentSize.height > contentHeight) {
        contentHeight = scrollView.contentSize.height + testValue;
    }
    
    scrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
    
//    if (scale > 2) {
//        CGFloat width = scrollView.contentSize.width;
//        CGFloat height = scrollView.contentSize.height;
//        CGSize contentsize = CGSizeMake(width * 2, height *2);
////        scrollView.contentSize = contentsize;
//        scrollView.contentInset = UIEdgeInsetsMake(200, 200, 200, 200);
////        NSLog(@"Liang scale  %f contentsize %@ contentinset %@", scale, NSStringFromCGSize(scrollView.contentSize), NSStringFromUIEdgeInsets(scrollView.contentInset));
//    } else if (scale <= 1) {
//        scrollView.contentInset = UIEdgeInsetsZero;
//    }
    
    NSLog(@"Liang scale  %f contentsize %@ contentinset %@", scale, NSStringFromCGSize(scrollView.contentSize), NSStringFromUIEdgeInsets(scrollView.contentInset));
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"Liang scale contentsize %@ contentinset %@", NSStringFromCGSize(scrollView.contentSize), NSStringFromUIEdgeInsets(scrollView.contentInset));
}

// Liang scale  5.042634 contentsize {3781.9756327529831, 2370.0380631918692}
// Liang scale  5.040959 contentsize {1890.3597468273874, 1184.6254413451629}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self refreshImageContainerViewCenter];
}
#pragma mark - Private

- (void)refreshImageContainerViewCenter {
    CGFloat offsetX = (_scrollView.frame.size.width > _scrollView.contentSize.width) ? ((_scrollView.frame.size.width - _scrollView.contentSize.width) * 0.5) : 0.0;
    CGFloat offsetY = (_scrollView.frame.size.height > _scrollView.contentSize.height) ? ((_scrollView.frame.size.height - _scrollView.contentSize.height) * 0.5) : 0.0;
    self.imageView.center = CGPointMake(_scrollView.contentSize.width * 0.5 + offsetX, _scrollView.contentSize.height * 0.5 + offsetY);
    
    NSLog(@"Liang zommView 0 offsetX %f offsetY %f", offsetX, offsetY);
    NSLog(@"Liang zommView 1 center %@", NSStringFromCGPoint(self.imageContainerView.center));
    
    NSLog(@"Liang zommView 2 frame %@ contentsize %@", NSStringFromCGRect(_scrollView.frame), NSStringFromCGSize(_scrollView.contentSize));
}

- (CGRect)getImgFrameInImageViewRect:(CGRect)imageViewRect contentImg:(UIImage *)contentImg {
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 0;
    CGFloat height = 0;
    
    // imageView的宽高
    CGFloat imageViewWidth = imageViewRect.size.width;
    CGFloat imageViewHeight = imageViewRect.size.height;
    
    // 内容图片的原始宽高
    CGFloat contentImgWidth = contentImg.size.width;
    CGFloat contentImgHeight = contentImg.size.height;
    // 图片的宽度比图片的高度要长，长幅图片
    if (contentImgWidth >= contentImgHeight) {
        width = imageViewWidth;
        height = width * contentImgHeight / contentImgWidth;
        if (height > imageViewHeight) {
            height = imageViewHeight;
            width = contentImgWidth * height / contentImgHeight;
        }
        
    } else {
        height = imageViewHeight;
        width = contentImgWidth * height / contentImgHeight;
        // height = imageViewHeight的情况下，width还是可能比imageViewWidth大
        if (width > imageViewWidth) {
            width = imageViewWidth;
            height = width * contentImgHeight / contentImgWidth;
        }
    }
    
    width = ceilf(width);
    height = ceilf(height);
    
    x = (imageViewWidth - width) * 0.5;
    y = (imageViewHeight - height ) * 0.5;
    
    return CGRectMake(x, y, width, height);
}
@end
