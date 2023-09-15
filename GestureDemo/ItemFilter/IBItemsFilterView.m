//
//  IBItemsFilterView.m
//  GestureDemo
//
//  Created by xmly on 2023/2/15.
//  Copyright © 2023 Abner_G. All rights reserved.
//

#import "IBItemsFilterView.h"

#import "IBFilterModel.h"
#import <Masonry/Masonry.h>

#import <YYCategories/YYCategories.h>

#define IBBottomSafeMargin [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom
#define IBKC01_3B3B3B [UIColor colorWithHexString:@"#3B3B3B"] // 引导页大文字
#define IBKC02_9F9F9F [UIColor colorWithHexString:@"#9F9F9F"] // 引导页小文字
#define IBKC03_B773FF [UIColor colorWithHexString:@"#B773FF"] // 主色 紫
#define IBKC04_FFFFFF [UIColor colorWithHexString:@"#FFFFFF"] // 白色
#define IBKC05_F8EDFF [UIColor colorWithHexString:@"#F8EDFF"] // 主色3
#define IBKC06_333333 [UIColor colorWithHexString:@"#333333"] // 标准标题、正文
#define IBKC07_999999 [UIColor colorWithHexString:@"#999999"] // 辅助文字3、底tab色
#define IBKC08_F8F8FA [UIColor colorWithHexString:@"#F8F8FA"] // 模块浅灰底
#define IBKC09_EEEEEE [UIColor colorWithHexString:@"#EEEEEE"] // 常用分割线
#define IBKC10_8F8F8F [UIColor colorWithHexString:@"#8F8F8F"] // 辅助文字2
#define IBKC11_F6F7F8 [UIColor colorWithHexString:@"#F6F7F8"] // 背景色
#define IBKC12_B6B6B6 [UIColor colorWithHexString:@"#B6B6B6"] // 背景色


#define IBKC13_0098EB [UIColor colorWithHexString:@"#0098EB"] // 蓝色
#define IBKC14_E6FAFF [UIColor colorWithHexString:@"#E6FAFF"] // 标题淡蓝色

#define IBMainColor IBKC13_0098EB

#define KNC01_F6F6F6 [UIColor colorWithHexString:@"#F6F6F6"]    // 背景色
#define KNC02_222222 [UIColor colorWithHexString:@"#222222"]    // 文字颜色-黑
#define KNC03_2582FF [UIColor colorWithHexString:@"#2582FF"]    // 蓝色
#define KNC04_BBBBBB [UIColor colorWithHexString:@"#BBBBBB"]    // 二级文字颜色-灰
#define KNC05_F4F4F4 [UIColor colorWithHexString:@"#F4F4F4"]    // 部分灰色按钮的背景颜色
#define KNC06_999999 [UIColor colorWithHexString:@"#999999"]    // 部分灰色文字
#define KNC07_2884FE [UIColor colorWithHexString:@"#2884FE"]    // 白色背景，蓝色文字按钮的蓝色
#define KNC08_FA5A5A [UIColor colorWithHexString:@"#FA5A5A"]    // 部分按钮的红色文字
#define KNC09_F3F3F3 [UIColor colorWithHexString:@"#f3f3f3"]    // 灵感,搭配分类cell的背景色

#define     IB_PingFangFont(v) ([UIFont fontWithName:@"PingFangSC-Regular" size:v] ? [UIFont fontWithName:@"PingFangSC-Regular" size:v] : [UIFont systemFontOfSize:v])

#define     IB_PingFangLightFont(v) ([UIFont fontWithName:@"PingFangSC-Light" size:v] ? [UIFont fontWithName:@"PingFangSC-Light" size:v] : [UIFont systemFontOfSize:v])

#define     IB_PingFangSemiBoldFont(v) ([UIFont fontWithName:@"PingFangSC-Semibold" size:v] ? [UIFont fontWithName:@"PingFangSC-Semibold" size:v] : [UIFont boldSystemFontOfSize:v])

#define     IB_PingFangMediumFont(v) ([UIFont fontWithName:@"PingFangSC-Medium" size:v] ? [UIFont fontWithName:@"PingFangSC-Medium" size:v] : [UIFont boldSystemFontOfSize:v])


@interface IBItemsFilterView()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, assign) IBFilterViewType filterViewType;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *resetButton;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation IBItemsFilterView
#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame filterType:(IBFilterViewType)filterType {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRGB:0x000 alpha:0.5];
        self.dataArray = [NSMutableArray array];
        self.filterViewType = filterType;
        [self setupSubviews];
        [self requestTableData];
    }
    return self;
}

- (void)setupSubviews {
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *superView = self.contentView;
    
    CGFloat leftMargin = 100;
    [superView addSubview:self.leftView];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(superView);
        make.width.mas_equalTo(leftMargin);
    }];
    
    CGFloat bottomButtonHeight = 36;
    CGFloat bottomViewTop = 5;
    CGFloat bottomHeight = IBBottomSafeMargin + bottomButtonHeight + bottomViewTop;
    [superView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftView.mas_right);
        make.right.bottom.equalTo(superView);
        make.height.mas_equalTo(bottomHeight);
    }];
    
    
    [self.bottomView addSubview:self.resetButton];
    [self.bottomView addSubview:self.confirmButton];
    [self.bottomView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:15 tailSpacing:15];
    [self.bottomView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_top).mas_offset(bottomViewTop);
        make.height.mas_equalTo(bottomButtonHeight);
    }];
    
    
//    [superView addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(superView).mas_offset(leftMargin);
//        make.top.right.equalTo(superView);
//        make.bottom.equalTo(self.bottomView.mas_top);
//    }];
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}

- (UIView *)leftView {
    if (!_leftView) {
        _leftView = [UIView new];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideFilterView)];
        [_leftView addGestureRecognizer:tap];
    }
    return _leftView;
}



- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = IBKC04_FFFFFF;
    }
    return _bottomView;
}

- (UIButton *)resetButton {
    if (!_resetButton) {
        _resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _resetButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _resetButton.titleLabel.font = IB_PingFangFont(12);
        [_resetButton setTitleColor:KNC02_222222 forState:UIControlStateNormal];
        [_resetButton setTitle:@"重置" forState:UIControlStateNormal];
        _resetButton.backgroundColor = KNC01_F6F6F6;
        _resetButton.layer.cornerRadius = 6;
        _resetButton.layer.masksToBounds = YES;
        [_resetButton addTarget:self action:@selector(resetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetButton;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _confirmButton.titleLabel.font = IB_PingFangFont(12);
        [_confirmButton setTitleColor:IBKC04_FFFFFF forState:UIControlStateNormal];
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        _confirmButton.backgroundColor = IBMainColor;
        _confirmButton.layer.cornerRadius = 6;
        _confirmButton.layer.masksToBounds = YES;
        [_confirmButton addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (void)resetBtnClick {
    
}

- (void)confirmBtnClick {
    
}

- (void)hideFilterView {
    
}

- (void)requestTableData {
    [self.dataArray removeAllObjects];
    
    IBFilterViewType viewType = self.filterViewType;
    if (viewType == IBFilterViewTypeClothing) {
        NSString *categoryHeader = @"分类";
        IBFilterHeaderModel *headerModel = [IBFilterHeaderModel new];
        headerModel.headerTitle = categoryHeader;
        headerModel.items = @[];
        [self.dataArray addObject:headerModel];
        
        NSString *seasonHeader = @"季节";
        NSArray *seasons = @[@"春季", @"夏季", @"秋季", @"冬季"];
        NSMutableArray *seasonArray = [NSMutableArray array];
        [seasons enumerateObjectsUsingBlock:^(id  _Nonnull seasonStr, NSUInteger idx, BOOL * _Nonnull stop) {
            IBFilterModel *filterModel = [IBFilterModel new];
            filterModel.name = seasonStr;
            filterModel.modeType = IBFilterModelTypeSeason;
            filterModel.modeId = idx + 1;
            filterModel.attachModel = seasonStr;
            [seasonArray addObject:filterModel];
        }];
        
        IBFilterHeaderModel *seasonHeaderModel = [IBFilterHeaderModel new];
        seasonHeaderModel.headerTitle = seasonHeader;
        seasonHeaderModel.items = seasonArray;
        [self.dataArray addObject:seasonHeaderModel];
        
        
        NSArray *colors = [[LJWCDBManager shareInstance] getColorsAllObjects];
        if (colors.count) {
            NSString *colorHeader = @"颜色";
            NSMutableArray *colorArray = [NSMutableArray array];
            [colors enumerateObjectsUsingBlock:^(ColorModel *colorModel, NSUInteger idx, BOOL * _Nonnull stop) {
                IBFilterModel *filterModel = [IBFilterModel new];
                filterModel.name = colorModel.colorName;
                filterModel.modeType = IBFilterModelTypeColor;
                filterModel.modeId = colorModel.rowid;
                filterModel.attachModel = colorModel;
                [colorArray addObject:filterModel];
            }];
            
            IBFilterHeaderModel *headerModel = [IBFilterHeaderModel new];
            headerModel.headerTitle = colorHeader;
            headerModel.items = colorArray;
            [self.dataArray addObject:headerModel];
        }
        
        
        
        NSArray *locations = [[LJWCDBManager shareInstance] getClothingPositionAllObjects];
        if (locations.count) {
            NSString *positionHeader = @"收纳位置";
            NSMutableArray *positionArray = [NSMutableArray array];
            [locations enumerateObjectsUsingBlock:^(ClothingLocation *location, NSUInteger idx, BOOL * _Nonnull stop) {
                IBFilterModel *filterModel = [IBFilterModel new];
                filterModel.name = location.name;
                filterModel.modeType = IBFilterModelTypeDefault;
                filterModel.modeId = location.rowid;
                filterModel.attachModel = location;
                [positionArray addObject:filterModel];
            }];
//            [self.dataDic setValue:positionArray forKey:positionHeader];
            
//            [self.headerArray addObject:positionHeader];
            IBFilterHeaderModel *headerModel = [IBFilterHeaderModel new];
            headerModel.headerTitle = positionHeader;
            headerModel.items = positionArray;
            
            
            [self.dataArray addObject:headerModel];
        }
        
        // TODO
//        NSArray *sortBrands = [[[LJWCDBManager shareInstance] getBrandModelAllObjects] arrayWithPinYinFirstLetterFormat];
        NSArray *sortBrands = [[LJWCDBManager shareInstance] getBrandModelAllObjects];
        if (sortBrands.count) {
            NSString *brandHeader = @"品牌";
            NSMutableArray *brandArray = [NSMutableArray array];
            [sortBrands enumerateObjectsUsingBlock:^(BrandModel *brand, NSUInteger idx, BOOL * _Nonnull stop) {
                IBFilterModel *filterModel = [IBFilterModel new];
                filterModel.name = brand.name;
                filterModel.modeType = IBFilterModelTypeDefault;
                filterModel.modeId = brand.rowid;
                filterModel.attachModel = brand;
                [brandArray addObject:filterModel];
            }];
//            [self.dataDic setValue:brandArray forKey:brandHeader];
            
//            [self.headerArray addObject:brandHeader];
            IBFilterHeaderModel *headerModel = [IBFilterHeaderModel new];
            headerModel.headerTitle = brandHeader;
            headerModel.items = brandArray;
            
            [self.dataArray addObject:headerModel];
        }
        
        NSArray *sizeGroups = [[LJWCDBManager shareInstance] getClothingSizeGroupsAllObjects];
        if (sizeGroups.count) {
            [sizeGroups enumerateObjectsUsingBlock:^(ClothingSizeGroup *sizeGroup, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *sizeGroupHeader = [NSString stringWithFormat:@"%@尺码", sizeGroup.sizeGroupName];
                NSArray *sizes = [[LJWCDBManager shareInstance] getClothingSizeWithGroup:sizeGroup];
                NSMutableArray *sizeArray = [NSMutableArray array];
                if (sizes.count) {
                    [sizes enumerateObjectsUsingBlock:^(ClothingSize *sizeModel, NSUInteger idx, BOOL * _Nonnull stop) {
                        IBFilterModel *filterModel = [IBFilterModel new];
                        filterModel.name = sizeModel.name;
                        filterModel.modeType = IBFilterModelTypeDefault;
                        filterModel.modeId = sizeModel.rowid;
                        filterModel.attachModel = sizeModel;
                        [sizeArray addObject:filterModel];
                    }];
//                    [self.dataDic setValue:sizeArray forKey:sizeGroupHeader];
                    
//                    [self.headerArray addObject:sizeGroupHeader];
                    IBFilterHeaderModel *headerModel = [IBFilterHeaderModel new];
                    headerModel.headerTitle = sizeGroupHeader;
                    headerModel.items = sizeArray;
                    [self.dataArray addObject:headerModel];
                }
            }];
        }
        
        NSArray *states = [[LJWCDBManager shareInstance] getStateAllObjects];
        if (states.count) {
            NSString *statusHeader = @"状态";
            NSMutableArray *stateArray = [NSMutableArray array];
            [locations enumerateObjectsUsingBlock:^(State *state, NSUInteger idx, BOOL * _Nonnull stop) {
                IBFilterModel *filterModel = [IBFilterModel new];
                filterModel.name = state.stateStr;
                filterModel.modeType = IBFilterModelTypeDefault;
                filterModel.modeId = state.rowid;
                filterModel.attachModel = state;
                [stateArray addObject:filterModel];
            }];
//            [self.dataDic setValue:stateArray forKey:statusHeader];
            
//            [self.headerArray addObject:statusHeader];
            IBFilterHeaderModel *headerModel = [IBFilterHeaderModel new];
            headerModel.headerTitle = statusHeader;
            headerModel.items = stateArray;
            [self.dataArray addObject:headerModel];
        }
        
        NSArray *fabrics = [[LJWCDBManager shareInstance] getFabricAllObjects];
        if (fabrics.count) {
            NSString *fabricHeader = @"材质";
            NSMutableArray *fabricArray = [NSMutableArray array];
            [locations enumerateObjectsUsingBlock:^(Fabric *fabric, NSUInteger idx, BOOL * _Nonnull stop) {
                IBFilterModel *filterModel = [IBFilterModel new];
                filterModel.name = fabric.name;
                filterModel.modeType = IBFilterModelTypeDefault;
                filterModel.modeId = fabric.rowid;
                filterModel.attachModel = fabric;
                [fabricArray addObject:filterModel];
            }];
//            [self.dataDic setValue:fabricArray forKey:fabricHeader];
            
//            [self.headerArray addObject:fabricHeader];
            IBFilterHeaderModel *headerModel = [IBFilterHeaderModel new];
            headerModel.headerTitle = fabricHeader;
            headerModel.items = fabricArray;
            [self.dataArray addObject:headerModel];
        }
        
        NSArray *tagTypes = [[LJWCDBManager shareInstance] getTagTypesAllObjectsWithTagBelong:2];
        if (tagTypes.count) {
            [tagTypes enumerateObjectsUsingBlock:^(TagsType *tagType, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *tagTypeHeader = [NSString stringWithFormat:@"%@标签", tagType.tagTypeName];
                NSArray *tags = [[LJWCDBManager shareInstance] getTagsAllObjectsWithTagType:tagType];
                NSMutableArray *tagArray = [NSMutableArray array];
                if (tags.count) {
                    [tags enumerateObjectsUsingBlock:^(Tags *tag, NSUInteger idx, BOOL * _Nonnull stop) {
                        IBFilterModel *filterModel = [IBFilterModel new];
                        filterModel.name = tag.tagName;
                        filterModel.modeType = IBFilterModelTypeDefault;
                        filterModel.modeId = tag.rowid;
                        filterModel.attachModel = tag;
                        [tagArray addObject:filterModel];
                    }];
//                    [self.dataDic setValue:tagArray forKey:tagTypeHeader];
                    
//                    [self.headerArray addObject:tagTypeHeader];
                    IBFilterHeaderModel *headerModel = [IBFilterHeaderModel new];
                    headerModel.headerTitle = tagTypeHeader;
                    headerModel.items = tagArray;
                    [self.dataArray addObject:headerModel];
                }
            }];
        }
    }
    else if (viewType == IBFilterViewTypeOutfit) {
        
    }
    else if (viewType == IBFilterViewTypeInspiration) {
        
    }
    NSLog(@"1");
}
@end
