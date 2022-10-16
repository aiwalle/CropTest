//
//  IBImageView.m
//  GestureDemo
//
//  Created by xmly on 2022/10/14.
//  Copyright © 2022 Abner_G. All rights reserved.
//

#import "IBImageView.h"

@implementation IBImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
static float maxY = 0;
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    CGFloat tempMaxY = CGRectGetMaxY(frame);
    if (tempMaxY >= maxY) {
        maxY = tempMaxY;
    } else {
        NSLog(@"123");
    }
}

@end
