//
//  IBItemsFilterView.h
//  GestureDemo
//
//  Created by xmly on 2023/2/15.
//  Copyright © 2023 Abner_G. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IBFilterViewType){
    IBFilterViewTypeNone = 0,
    IBFilterViewTypeClothing = 1,
    IBFilterViewTypeOutfit = 2,
    IBFilterViewTypeInspiration = 3
};

NS_ASSUME_NONNULL_BEGIN

@interface IBItemsFilterView : UIView
- (instancetype)initWithFrame:(CGRect)frame filterType:(IBFilterViewType)filterType;
@end

NS_ASSUME_NONNULL_END
