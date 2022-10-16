//
//  IBCropScrollView.m
//  GestureDemo
//
//  Created by xmly on 2022/10/13.
//  Copyright © 2022 Abner_G. All rights reserved.
//

#import "IBCropScrollView.h"

@implementation IBCropScrollView

- (BOOL)touchesShouldBegin:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event inContentView:(UIView *)view {
//    NSLog(@"liang touchesShouldBegin count %lu contentview %@", (unsigned long)touches.count, view);
    return YES;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"liang touchesBegan count %lu", (unsigned long)touches.count);
    
    [[self nextResponder] touchesBegan:touches withEvent:event];
    NSInteger touchCount = touches.count;
    UIView *view = touches.anyObject.view;
    if (touchCount) {
        
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
//    NSLog(@"liang touchesMoved count %lu", (unsigned long)touches.count);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesEnded:touches withEvent:event];
//    NSLog(@"liang touchesEnded count %lu", (unsigned long)touches.count);
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesCancelled:touches withEvent:event];
//    NSLog(@"liang touchesCancelled count %lu", (unsigned long)touches.count);
}

@end
