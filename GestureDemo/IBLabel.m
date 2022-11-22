//
//  IBLabel.m
//  GestureDemo
//
//  Created by xmly on 2022/11/19.
//  Copyright © 2022 Abner_G. All rights reserved.
//

#import "IBLabel.h"

@implementation IBLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        if ([self.layer isKindOfClass:[CATiledLayer class]]) {
            CATiledLayer *tiLayer = (CATiledLayer *)self.layer;
            tiLayer.levelsOfDetail = 10;
            tiLayer.levelsOfDetailBias = 10;
        }
    }
    return self;
}

@end
