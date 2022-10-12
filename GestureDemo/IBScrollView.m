//
//  IBScrollView.m
//  GestureDemo
//
//  Created by xmly on 2022/10/12.
//  Copyright © 2022 Abner_G. All rights reserved.
//

#import "IBScrollView.h"

@interface IBScrollView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic) CGPoint startImageCenter;
// 手势初始中心点
@property (nonatomic) CGPoint startGCenter;
@end

@implementation IBScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.bouncesZoom = YES;
        self.maximumZoomScale = 2.5;
        self.minimumZoomScale = 1.0;
        self.multipleTouchEnabled = YES;
        self.delegate = self;
        self.scrollsToTop = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
//        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.delaysContentTouches = NO;
        self.canCancelContentTouches = YES;
        self.alwaysBounceVertical = NO;
        
        [self setupSubviews];
    }
    return self;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _imageView;
}

- (void)setupSubviews {
    [self addSubview:self.imageView];
}

- (void)setOriginImg:(UIImage *)originImg {
    _originImg = originImg;
    CGRect imageViewRect = [self getImgFrameInImageViewRect:self.bounds contentImg:originImg];
    self.imageView.frame = imageViewRect;
    self.imageView.image = originImg;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"liang touchesBegan count %lu", (unsigned long)touches.count);
    
    if (touches.count == 1) {
        CGPoint pointInImageView = [touches.anyObject locationInView:self.imageView];
        if (pointInImageView.x > 0 && pointInImageView.y > 0) {
            self.startImageCenter = self.imageView.center;
            self.startGCenter = [touches.anyObject locationInView:self];
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"liang touchesMoved count %lu", (unsigned long)touches.count);
    if (touches.count == 1) {
        CGPoint pointInImageView = [touches.anyObject locationInView:self.imageView];
        if (pointInImageView.x > 0 && pointInImageView.y > 0) {
            CGPoint nowGCenter = [touches.anyObject locationInView:self];
            float x = nowGCenter.x - self.startGCenter.x;
            float y = nowGCenter.y - self.startGCenter.y;
            //计算imageview的相对位移
            self.imageView.center = CGPointMake(self.startImageCenter.x+x, self.startImageCenter.y+y);
        }
        
        
        
    }
    
    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"liang touchesEnded count %lu", (unsigned long)touches.count);
    if (touches.count == 1) {
        CGPoint pointInImageView = [touches.anyObject locationInView:self.imageView];
        if (pointInImageView.x > 0 && pointInImageView.y > 0) {
            CGPoint nowGCenter = [touches.anyObject locationInView:self];
            float x = nowGCenter.x - self.startGCenter.x;
            float y = nowGCenter.y - self.startGCenter.y;
            //计算imageview的相对位移
            self.imageView.center = CGPointMake(self.startImageCenter.x+x, self.startImageCenter.y+y);
        }
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"liang touchesCancelled count %lu", (unsigned long)touches.count);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    scrollView.contentInset = UIEdgeInsetsZero;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self refreshImageContainerViewCenter];
}
#pragma mark - Private

- (void)refreshImageContainerViewCenter {
    CGFloat offsetX = (self.frame.size.width > self.contentSize.width) ? ((self.frame.size.width - self.contentSize.width) * 0.5) : 0.0;
    CGFloat offsetY = (self.frame.size.height > self.contentSize.height) ? ((self.frame.size.height - self.contentSize.height) * 0.5) : 0.0;
    self.imageView.center = CGPointMake(self.contentSize.width * 0.5 + offsetX, self.contentSize.height * 0.5 + offsetY);
    
//    NSLog(@"Liang zommView 0 offsetX %f offsetY %f", offsetX, offsetY);
//    NSLog(@"Liang zommView 1 center %@", NSStringFromCGPoint(self.imageContainerView.center));
//
//    NSLog(@"Liang zommView 2 frame %@ contentsize %@", NSStringFromCGRect(_scrollView.frame), NSStringFromCGSize(_scrollView.contentSize));
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
