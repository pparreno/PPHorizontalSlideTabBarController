//
//  PPHorizontalSlideTabBarView.h
//  PPHorizontalSlideTabBarController
//
//  Created by pparreno on 9/17/12.
//  Copyright (c) 2012 pparreno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class PPHorizontalSlideTabBarView;

@protocol PPHorizontalSlideTabBarDatasource <NSObject>
@required
- (int) numberOfItemsForMenu:(PPHorizontalSlideTabBarView *) tabBarView;
- (NSString*) tabBarView:(PPHorizontalSlideTabBarView*) tabBarView titleForItemAtIndex:(NSUInteger) index;
@end

@protocol PPHorizontalSlideTabBarDelegate <NSObject>
@required
- (void)tabBarView:(PPHorizontalSlideTabBarView*) horizMenu itemSelectedAtIndex:(NSUInteger) index;
@end

@interface PPHorizontalSlideTabBarView : UIScrollView
{

}

@property (nonatomic, strong) IBOutlet id<PPHorizontalSlideTabBarDatasource> datasource;
@property (nonatomic, weak) IBOutlet id<PPHorizontalSlideTabBarDelegate> horizTabBarDelegate;
@property (nonatomic, strong) NSMutableArray *tabItems;
@property (nonatomic, strong) IBOutlet UIImageView *leftIndicatorView;
@property (nonatomic, strong) IBOutlet UIImageView *rightIndicatorView;

-(void) loadItemsToView;
-(void) tabButtonPressed:(id)sender;

@end
