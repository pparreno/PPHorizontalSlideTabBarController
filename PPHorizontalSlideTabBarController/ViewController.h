//
//  ViewController.h
//  PPHorizontalSlideTabBarController
//
//  Created by pparreno on 9/17/12.
//  Copyright (c) 2012 pparreno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPHorizontalSlideTabBarView.h"

@interface ViewController : UIViewController <PPHorizontalSlideTabBarDatasource, PPHorizontalSlideTabBarDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet PPHorizontalSlideTabBarView *tabBar;
@property (nonatomic, strong) IBOutlet UILabel *textLabel;
@property (nonatomic, strong) NSMutableArray *items;


@end
