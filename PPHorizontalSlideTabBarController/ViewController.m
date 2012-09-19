//
//  ViewController.m
//  PPHorizontalSlideTabBarController
//
//  Created by pparreno on 9/17/12.
//  Copyright (c) 2012 pparreno. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
}
@end

@implementation ViewController

@synthesize tabBar;
@synthesize items;


-(id)initWithCoder:(NSCoder *)aDecoder{

       NSLog(@"init with coder");
    if (!self) {
        self = [super initWithCoder:aDecoder];
    }

    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"init with nib");
    if(!self){
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    
    if (!tabBar) {
        NSLog(@"TabBar is nil;");
    }
    [tabBar setDatasource:self];
    return self;
}

- (void)viewDidLoad
{
    if (!tabBar) {
        NSLog(@"TabBar is nil ~ viewDidLoad");
    }else{
        NSLog(@"TabBar is not nil ~ viewDidLoad");
    }
    
    self.items = [NSMutableArray arrayWithObjects:@"New Videos", @"Tool Bags", @"Screwdrivers & Nuts Drivers", @"Drill Bits and Hole Saws", @"Fish tapes & Benders", @"Electrical Testers", @"Fish Tapes & Benders", @"Voice/Data/Video", @"General Videos", @"Customer Submitted Videos", nil];
    NSLog(@"items count: %d", [items count]);
    [self.tabBar loadItemsToView];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - PPHorizontalSlideTabBarDataSource

-(int)numberOfItemsForMenu:(PPHorizontalSlideTabBarView *)tabView
{
    return [self.items count];
}

- (NSString *)tabBarView:(PPHorizontalSlideTabBarView *)tabBarView titleForItemAtIndex:(NSUInteger)index
{
    return [items objectAtIndex:index];
}

#pragma mark - PPHorizontalSlideTabBarDelegate

- (void)tabBarView:(PPHorizontalSlideTabBarView *)horizMenu itemSelectedAtIndex:(NSUInteger)index
{
    NSLog(@"selected itemIndex: %d", index);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if ([scrollView isKindOfClass:[PPHorizontalSlideTabBarView class]]) {
        PPHorizontalSlideTabBarView *horizontalTabBar = (PPHorizontalSlideTabBarView *) scrollView;
        
        CGFloat x = horizontalTabBar.contentOffset.x;
        CGFloat y = horizontalTabBar.contentSize.width - 320;
        
        if (x == y || x == 0) {
            if (x >= y) {
                if (!horizontalTabBar.rightIndicatorView.isHidden) {
                    [horizontalTabBar.rightIndicatorView setHidden:YES];
                }
                [horizontalTabBar.leftIndicatorView setHidden:NO];
            }
            if (x <= 0) {
                if (!horizontalTabBar.leftIndicatorView.isHidden) {
                    [horizontalTabBar.leftIndicatorView setHidden:YES];
                }
                [horizontalTabBar.rightIndicatorView setHidden:NO];
            }
        }else {
            [horizontalTabBar.leftIndicatorView setHidden:NO];
            [horizontalTabBar.rightIndicatorView setHidden:NO];
        }

    }
    
}

@end
