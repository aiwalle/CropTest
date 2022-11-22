//
//  TestTwoController.m
//  GestureDemo
//
//  Created by xmly on 2022/10/31.
//  Copyright © 2022 Abner_G. All rights reserved.
//

#import "TestTwoController.h"

@interface TestTwoController ()

@end

@implementation TestTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIView *smallView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 300, 300)];
    smallView.backgroundColor = UIColor.blueColor;
    [self.view addSubview:smallView];
    
    UIView *bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 400)];
    bigView.backgroundColor = UIColor.redColor;
    [smallView addSubview:bigView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"c001"]];
    imageView.frame = CGRectMake(0, 100, 250, 350);
    [bigView addSubview:imageView];
    
}



@end
