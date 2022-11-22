//
//  TestController.m
//  GestureDemo
//
//  Created by xmly on 2022/10/12.
//  Copyright © 2022 Abner_G. All rights reserved.
//

#import "TestController.h"
//#import "IBScrollView.h"
#import "IBCropScrollView.h"
@interface TestController ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIImage *originImg;
@property (nonatomic, strong) UIView *imageContainerView;
@property (nonatomic, strong) IBCropScrollView *scrollView;

@property (nonatomic, strong) UIImageView *imageView;

// 图片初始缩放系数
@property (nonatomic, assign) float startScale;
// 图片初始中心点
@property (nonatomic) CGPoint startImageCenter;
// 手势初始中心点
@property (nonatomic) CGPoint startGCenter;

@property (nonatomic) CGPoint testBeginCenter;

@end

@implementation TestController
static float testValue = 200;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.startScale = 1.0;
    self.originImg = [UIImage imageNamed:@"c001"];
    
    
    
    
    [self.view addSubview:self.imageContainerView];
    CGFloat navHeight = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat scrollX = 0;
    CGFloat scrollY = navHeight;
    CGFloat scrollH = self.view.frame.size.height - navHeight;
    CGFloat scrollW = self.view.frame.size.width;
    self.imageContainerView.frame = CGRectMake(scrollX, scrollY, scrollW, scrollH);
    
    
    [self.imageContainerView addSubview:self.scrollView];
    self.scrollView.frame = self.imageContainerView.bounds;
    
    
//    UIView *redView = [UIView new];
//    redView.backgroundColor = UIColor.redColor;
//    [self.view addSubview:redView];
//    CGFloat redWidth = self.scrollView.frame.size.width * 0.5;
//    CGFloat redHeigh = self.scrollView.frame.size.height * 0.5;
//    redView.frame = CGRectMake(0, redHeigh + navHeight, redWidth, redHeigh);
    
    
    //    CGRect imageViewRect = [self getImgFrameInImageViewRect:self.scrollView.bounds contentImg:self.originImg];
    //    self.imageContainerView.frame = imageViewRect;
    //    self.imageView.frame = self.imageContainerView.bounds;
    //    [self.scrollView addSubview:self.imageContainerView];
    //    [self.imageContainerView addSubview:self.imageView];
    
    CGRect imageViewRect = [self getImgFrameInImageViewRect:self.scrollView.bounds contentImg:self.originImg];
    self.imageView.frame = imageViewRect;
    [self.scrollView addSubview:self.imageView];
    
    self.imageView.image = self.originImg;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    
    //    UIPinchGestureRecognizer * pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchImage:)];
    //    [imageView addGestureRecognizer:pinch];
    
    
    //    self.scrollView.pinchGestureRecognizer
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panImageView:)];
    pan.delegate = self;
    pan.maximumNumberOfTouches = 1;
    pan.cancelsTouchesInView = NO;
    [self.imageView addGestureRecognizer:pan];
    self.imageView.userInteractionEnabled = YES;
    
    
//    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchImage:)];
//
//    [self.imageView addGestureRecognizer:pinch];
    
    
    //    CGFloat testValue = 200;
    //    self.scrollView.contentSize = CGSizeMake(imageViewRect.size.width + testValue, self.scrollView.frame.size.height + testValue);
    ////    self.scrollView.contentOffset = CGPointMake(100, 100);
    //    self.scrollView.contentInset = UIEdgeInsetsMake(testValue, testValue, testValue, testValue);
    
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return <#expression#>;
//}

//-(void)pinchImage:(UIPinchGestureRecognizer *)pinch{
//
//    UIImageView * imageView = (UIImageView *)pinch.view;
//
//    // 缩放图片
//    imageView.transform = CGAffineTransformMakeScale(pinch.scale * self.startScale, pinch.scale * self.startScale);
//
//    if (pinch.state == UIGestureRecognizerStateEnded) {
//
//        self.startScale *= pinch.scale;
//        if (self.startScale >= 2.0) {
//
//            self.startScale = 2.0;
//            [UIView animateWithDuration:0.3 animations:^{
//
//                imageView.transform = CGAffineTransformMakeScale(self.startScale, self.startScale);
//            }];
//        } else if (self.startScale <= 0.5) {
//
//            self.startScale = 0.5;
//            [UIView animateWithDuration:0.3 animations:^{
//
//                imageView.transform = CGAffineTransformMakeScale(self.startScale, self.startScale);
//            }];
//        }
//    }
//
//}



//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"liang touchesBegan count %lu", (unsigned long)touches.count);
//}
//
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"liang touchesMoved count %lu", (unsigned long)touches.count);
//}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"liang touchesEnded count %lu", (unsigned long)touches.count);
//}
//
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"liang touchesCancelled count %lu", (unsigned long)touches.count);
//}

- (IBCropScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[IBCropScrollView alloc] init];
        _scrollView.bouncesZoom = YES;
        _scrollView.maximumZoomScale = 2.0;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.multipleTouchEnabled = YES;
//        _scrollView.adjustedContentInset = NO;
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
//            _scrollView.automaticallyAdjustsScrollViewInsets = NO;
        }
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
    self.testBeginCenter = [self.imageView.superview convertPoint:self.imageView.center toView:self.imageContainerView];
    NSLog(@"Liang newTest beginZoom %@", NSStringFromCGPoint(self.imageView.center));
    NSLog(@"Liang newTest 当前偏移量 00000 %@", NSStringFromCGPoint(self.testBeginCenter));
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"Liang scale scrollViewWillBeginDragging");
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    //    CGFloat contentWidth = scrollView.frame.size.width + testValue;
    //    CGFloat contentHeight = scrollView.frame.size.height + testValue;
    //    if (scrollView.contentSize.width > contentWidth) {
    //        contentWidth = scrollView.contentSize.width + testValue;
    //    }
    //
    //    if (scrollView.contentSize.height > contentHeight) {
    //        contentHeight = scrollView.contentSize.height + testValue;
    //    }
    //
    //    scrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
    
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
    
    //    NSLog(@"Liang scale scrollViewDidEndZooming  %f contentsize %@ contentinset %@", scale, NSStringFromCGSize(scrollView.contentSize), NSStringFromUIEdgeInsets(scrollView.contentInset));
    NSLog(@"Liang scale scrollViewDidEndZooming");
    
    if (scale <= scrollView.minimumZoomScale) {
        CGFloat offsetX = (_scrollView.frame.size.width > _scrollView.contentSize.width) ? ((_scrollView.frame.size.width - _scrollView.contentSize.width) * 0.5) : 0.0;
        CGFloat offsetY = (_scrollView.frame.size.height > _scrollView.contentSize.height) ? ((_scrollView.frame.size.height - _scrollView.contentSize.height) * 0.5) : 0.0;
        
        [UIView animateWithDuration:0.2 animations:^{
            self.imageView.center = CGPointMake(_scrollView.contentSize.width * 0.5 + offsetX, _scrollView.contentSize.height * 0.5 + offsetY);
        }];
        
       
    }
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    NSLog(@"Liang scale scrollViewDidScroll contentsize %@ contentinset %@", NSStringFromCGSize(scrollView.contentSize), NSStringFromUIEdgeInsets(scrollView.contentInset));
    //    scrollView.isMultipleTouchEnabled;
    NSLog(@"Liang scale scrollViewDidScroll 是否为拖拽 %d 是否多点触控 %d", scrollView.isDragging, scrollView.isMultipleTouchEnabled);
}



// Liang scale  5.042634 contentsize {3781.9756327529831, 2370.0380631918692}
// Liang scale  5.040959 contentsize {1890.3597468273874, 1184.6254413451629}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self refreshImageContainerViewCenter];
}
#pragma mark - Private
- (void)panImageView:(UIPanGestureRecognizer *)pan {
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

    //计算imageview的相对位移
    imageView.center = CGPointMake(self.startImageCenter.x+x, self.startImageCenter.y+y);
}

// beginZoom {214, 417.5}
- (void)refreshImageContainerViewCenter {
    // 获取imageview的center
//    CGPoint imageviewCenter = self.imageView.center;
    
    
//    CGFloat offsetX = (_scrollView.frame.size.width > _scrollView.contentSize.width) ? ((_scrollView.frame.size.width - _scrollView.contentSize.width) * 0.5) : 0.0;
//    CGFloat offsetY = (_scrollView.frame.size.height > _scrollView.contentSize.height) ? ((_scrollView.frame.size.height - _scrollView.contentSize.height) * 0.5) : 0.0;
//    self.imageView.center = CGPointMake(_scrollView.contentSize.width * 0.5 + offsetX, _scrollView.contentSize.height * 0.5 + offsetY);
    
    
    CGFloat newCenterX = _scrollView.contentSize.width * 0.5;
    if (_scrollView.contentSize.width > _scrollView.frame.size.width) {
        newCenterX = (_scrollView.contentSize.width - _scrollView.frame.size.width) * 0.5 + self.testBeginCenter.x;
        self.imageView.center = CGPointMake(newCenterX, self.testBeginCenter.y);
    } else {
//        NSLog(@"123");
//        CGFloat offsetX = (_scrollView.frame.size.width > _scrollView.contentSize.width) ? ((_scrollView.frame.size.width - _scrollView.contentSize.width) * 0.5) : 0.0;
//        CGFloat offsetY = (_scrollView.frame.size.height > _scrollView.contentSize.height) ? ((_scrollView.frame.size.height - _scrollView.contentSize.height) * 0.5) : 0.0;
//        self.imageView.center = CGPointMake(_scrollView.contentSize.width * 0.5 + offsetX, _scrollView.contentSize.height * 0.5 + offsetY);
    }
    
    
    NSLog(@"Liang newTest 当前偏移量 00000 %@", NSStringFromCGPoint([self.imageView.superview convertPoint:self.imageView.center toView:self.imageContainerView]));
    
//    NSLog(@"Liang zommView 0 offsetX %f offsetY %f", offsetX, offsetY);
//    NSLog(@"Liang zommView 1 center %@", NSStringFromCGPoint(self.imageContainerView.center));
//
//    NSLog(@"Liang zommView 2 frame %@ contentsize %@", NSStringFromCGRect(_scrollView.frame), NSStringFromCGSize(_scrollView.contentSize));
    
    NSLog(@"Liang newTest center %@ scaleValue %f", NSStringFromCGPoint(self.imageView.center), self.scrollView.zoomScale);
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
