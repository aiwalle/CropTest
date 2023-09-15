//
//  IBFilterModel.h
//  IBCloset
//
//  Created by xmly on 2023/2/8.
//  Copyright © 2023 liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBItemsFilterView.h"
NS_ASSUME_NONNULL_BEGIN

@interface IBFilterModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) id attachModel;
@property (nonatomic, assign) IBFilterModelType modeType;

@property (nonatomic, assign) NSInteger modeId;
@end

@interface IBFilterHeaderModel : NSObject
@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSArray *items;
@end

NS_ASSUME_NONNULL_END
