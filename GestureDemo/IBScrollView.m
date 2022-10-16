//
//  IBScrollView.m
//  GestureDemo
//
//  Created by xmly on 2022/10/12.
//  Copyright © 2022 Abner_G. All rights reserved.
//

#import "IBScrollView.h"
#import "IBImageView.h"
#import "IBCropScrollView.h"

#define kEnableMove 1
#define KEnableNewScale 1

@interface IBScrollView()<UIScrollViewDelegate>
@property (nonatomic, strong) IBCropScrollView *pScrollView;
@property (nonatomic, strong) IBImageView *imageView;
@property (nonatomic) CGPoint startImageCenter;
// 手势初始中心点
@property (nonatomic) CGPoint startGCenter;

@property (nonatomic) CGPoint offsetCenterBeforeZoom;
@end

@implementation IBScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSubviews];
    }
    return self;
}

- (IBCropScrollView *)pScrollView {
    if (!_pScrollView) {
        _pScrollView = [[IBCropScrollView alloc] init];
        _pScrollView.bouncesZoom = YES;
        _pScrollView.maximumZoomScale = 2.5;
        _pScrollView.minimumZoomScale = 1.0;
        _pScrollView.multipleTouchEnabled = YES;
        _pScrollView.delegate = self;
        _pScrollView.scrollsToTop = NO;
        _pScrollView.showsHorizontalScrollIndicator = NO;
        _pScrollView.showsVerticalScrollIndicator = NO;
        _pScrollView.delaysContentTouches = NO;
        _pScrollView.canCancelContentTouches = YES;
        _pScrollView.alwaysBounceVertical = NO;
        _pScrollView.alwaysBounceHorizontal = NO;
        _pScrollView.panGestureRecognizer.cancelsTouchesInView = NO;
    }
    return _pScrollView;
}

- (IBImageView *)imageView {
    if (!_imageView) {
        _imageView = [[IBImageView alloc] init];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _imageView;
}

- (void)setupSubviews {
    [self addSubview:self.pScrollView];
    [self.pScrollView addSubview:self.imageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    self.pScrollView.frame = self.bounds;
}

- (void)setOriginImg:(UIImage *)originImg {
    _originImg = originImg;
    self.pScrollView.frame = self.bounds;
    CGRect imageViewRect = [self getImgFrameInImageViewRect:self.bounds contentImg:originImg];
    self.imageView.frame = imageViewRect;
    self.imageView.image = originImg;
    self.pScrollView.contentSize = imageViewRect.size;
}
- (BOOL)touchesShouldBegin:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event inContentView:(UIView *)view {
    NSLog(@"liang touchesShouldBegin count %lu", (unsigned long)touches.count);
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"liang touchesBegan count %lu", (unsigned long)touches.count);
    [super touchesBegan:touches withEvent:event];
    if (!kEnableMove) {
        return;
    }
    
    if (touches.count == 1) {
//        CGPoint pointInImageView = [touches.anyObject locationInView:self];
//        if (pointInImageView.x > 0 && pointInImageView.y > 0) {
            self.startImageCenter = self.imageView.center;
            self.startGCenter = [touches.anyObject locationInView:self];
//        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"liang touchesMoved count %lu draging %d", (unsigned long)touches.count, self.isDragging);
    [super touchesMoved:touches withEvent:event];
    if (!kEnableMove) {
        return;
    }
    if (touches.count == 1) {
//        CGPoint pointInImageView = [touches.anyObject locationInView:self];
//        if (pointInImageView.x > 0 && pointInImageView.y > 0) {
//            CGPoint nowGCenter = [touches.anyObject locationInView:self];
//            float x = nowGCenter.x * self.pScrollView.zoomScale - self.startGCenter.x;
//            float y = nowGCenter.y * self.pScrollView.zoomScale - self.startGCenter.y;
            //计算imageview的相对位移
//            self.imageView.center = CGPointMake(self.startImageCenter.x+x, self.startImageCenter.y+y);
//        }
        
        [self updateImageVie:touches];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"liang touchesEnded count %lu", (unsigned long)touches.count);
    [super touchesEnded:touches withEvent:event];
    if (!kEnableMove) {
        return;
    }
    if (touches.count == 1) {
//        CGPoint pointInImageView = [touches.anyObject locationInView:self];
//        if (pointInImageView.x > 0 && pointInImageView.y > 0) {
//            CGPoint nowGCenter = [touches.anyObject locationInView:self];
//            float x = nowGCenter.x - self.startGCenter.x;
//            float y = nowGCenter.y - self.startGCenter.y;
            //计算imageview的相对位移
//            self.imageView.center = CGPointMake(self.startImageCenter.x+x, self.startImageCenter.y+y);
//        }
        
        [self updateImageVie:touches];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"liang touchesCancelled count %lu", (unsigned long)touches.count);
    [super touchesCancelled:touches withEvent:event];
//    NSLog(@"liang touchesEnded count %lu", (unsigned long)touches.count);
//    if (touches.count == 1) {
//        CGPoint pointInImageView = [touches.anyObject locationInView:self.imageView];
//        if (pointInImageView.x > 0 && pointInImageView.y > 0) {
//            CGPoint nowGCenter = [touches.anyObject locationInView:self];
//            float x = nowGCenter.x - self.startGCenter.x;
//            float y = nowGCenter.y - self.startGCenter.y;
//            //计算imageview的相对位移
//            self.imageView.center = CGPointMake(self.startImageCenter.x+x, self.startImageCenter.y+y);
//        }
//    }
}

- (void)updateImageVie:(NSSet<UITouch *> *)touches {
    CGPoint nowGCenter = [touches.anyObject locationInView:self];
    float x = nowGCenter.x - self.startGCenter.x;
    float y = nowGCenter.y - self.startGCenter.y;
    //计算imageview的相对位移
    self.imageView.center = CGPointMake(self.startImageCenter.x+x, self.startImageCenter.y+y);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    CGPoint imageCenter = [self.imageView.superview convertPoint:self.imageView.center toView:scrollView];
    
    
    CGFloat originOffsetX = imageCenter.x - scrollView.frame.size.width * 0.5;
    CGFloat originOffsetY = imageCenter.y - scrollView.frame.size.height * 0.5;
    
    self.offsetCenterBeforeZoom = CGPointMake(originOffsetX, originOffsetY);
    
    NSLog(@"Liang scrollView scrollViewWillBeginZooming ✅✅✅ view %@ centerbefore %@", view, NSStringFromCGPoint(self.offsetCenterBeforeZoom));
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    NSLog(@"Liang scrollView scrollViewDidEndZooming ❌❌❌ scale %f view %@", scale, view);
    if (scale == scrollView.minimumZoomScale) {
        view.center = CGPointMake(scrollView.frame.size.width * 0.5, scrollView.frame.size.height * 0.5);
    }
}

// 图片视图原始大小 375 235
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    NSLog(@"Liang scrollView scrollViewDidZoom 🚩🚩🚩🚩 begin contensize %@ scale %f", NSStringFromCGSize(scrollView.contentSize), scrollView.zoomScale);
    [self refreshImageContainerViewCenter];
//    NSLog(@"Liang scrollView scrollViewDidZoom end imageviewCenter %@", NSStringFromCGPoint(self.imageView.center));
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    NSLog(@"Liang scrollView scrollViewWillBeginDragging");
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView.isDragging) {
//        CGPoint nowGCenter = [pan locationInView:self.imageView];
//        float x = nowGCenter.x - self.startGCenter.x;
//        float y = nowGCenter.y - self.startGCenter.y;
//
//        //计算imageview的相对位移
//        imageView.center = CGPointMake(self.startImageCenter.x+x, self.startImageCenter.y+y);
//    }
    NSLog(@"Liang scrollView scrollViewDidScroll 是否为拖拽 %d ", scrollView.isDragging);
}

#pragma mark - Private
- (void)refreshImageContainerViewCenter {
    if (KEnableNewScale) {
        CGFloat offsetX = (self.pScrollView.frame.size.width > self.pScrollView.contentSize.width) ? ((self.pScrollView.frame.size.width - self.pScrollView.contentSize.width) * 0.5) : 0.0;
        CGFloat offsetY = (self.pScrollView.frame.size.height > self.pScrollView.contentSize.height) ? ((self.pScrollView.frame.size.height - self.pScrollView.contentSize.height) * 0.5) : 0.0;
        self.imageView.center = CGPointMake(self.pScrollView.contentSize.width * 0.5 + offsetX + self.offsetCenterBeforeZoom.x, self.pScrollView.contentSize.height * 0.5 + offsetY + self.offsetCenterBeforeZoom.y);
        
    } else {
        CGFloat offsetX = (self.pScrollView.frame.size.width > self.pScrollView.contentSize.width) ? ((self.pScrollView.frame.size.width - self.pScrollView.contentSize.width) * 0.5) : 0.0;
        CGFloat offsetY = (self.pScrollView.frame.size.height > self.pScrollView.contentSize.height) ? ((self.pScrollView.frame.size.height - self.pScrollView.contentSize.height) * 0.5) : 0.0;
        self.imageView.center = CGPointMake(self.pScrollView.contentSize.width * 0.5 + offsetX, self.pScrollView.contentSize.height * 0.5 + offsetY);
    }
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
    
//    x = 0;
//    y = 0;
//    return CGRectMake(x, y, width, height);
}
@end
