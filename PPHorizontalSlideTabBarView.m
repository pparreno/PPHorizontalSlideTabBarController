//
//  PPHorizontalSlideTabBarView.m
//  PPHorizontalSlideTabBarController
//
//  Created by pparreno on 9/17/12.
//  Copyright (c) 2012 pparreno. All rights reserved.
//

#import "PPHorizontalSlideTabBarView.h"

#define kButtonBaseTag 1000

@interface PPHorizontalSlideTabBarView()
{
    BOOL isFirstTimeLoaded;
    int activeIndex;
}

@end


@implementation PPHorizontalSlideTabBarView

@synthesize tabItems;
@synthesize datasource;
@synthesize horizTabBarDelegate;
@synthesize leftIndicatorView;
@synthesize rightIndicatorView;

-(id)initWithFrame:(CGRect)frame{
    
    if (!self) {
        self = [super initWithFrame:frame];
       
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(-160, 0, self.contentSize.width+320, self.contentSize.height);
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor yellowColor] CGColor], (id)[[UIColor orangeColor] CGColor], nil];
    [self.layer insertSublayer:gradient atIndex:0];
    [super drawRect:rect];
}

-(void) awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"inside awakeFromNib");
    self.bounces = NO;
    self.scrollEnabled = YES;
    self.alwaysBounceHorizontal = NO;
    self.alwaysBounceVertical = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    isFirstTimeLoaded = YES;
    activeIndex = 0;
    
    [self loadItemsToView];
}

-(void) loadItemsToView
{
    CGSize maximumSize = CGSizeMake(300, 9999);
    UIFont *myFont = [UIFont fontWithName:@"Helvetica" size:14];
    
    CGFloat rightEndPoint = 10.0f;
    
    int max = [datasource numberOfItemsForMenu:self];
    int tag = kButtonBaseTag;
    
    for (int x = 0; x < max; x++) {
        NSString *title = [datasource tabBarView:self titleForItemAtIndex:x];
        CGSize myStringSize = [title sizeWithFont:myFont
                                constrainedToSize:maximumSize
                                    lineBreakMode:UILineBreakModeWordWrap];
        CGRect buttonFrame = CGRectMake(rightEndPoint, 10, myStringSize.width+50, myStringSize.height+10);
        rightEndPoint = (rightEndPoint + buttonFrame.size.width + 10);
        
        UIButton *tabButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tabButton.frame = buttonFrame;
                
        if (isFirstTimeLoaded && x==0) {
            activeIndex = 0;
            [self setButtonToSelectedAppearance:tabButton];
        }else{
            [self setButtonToNormalAppearance:tabButton];
        }
        
        [tabButton setTag:tag++];
        
        [tabButton setTitle:title forState:UIControlStateNormal];
        [tabButton addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        //        [tabButton setBackgroundImage:[[UIImage imageNamed:@"HorizontalScrollTabButton"] stretchableImageWithLeftCapWidth:16 topCapHeight:0] forState:UIControlStateSelected];
        
        tabButton.backgroundColor = [UIColor clearColor];
        tabButton.layer.borderWidth = 0.5f;
        tabButton.layer.cornerRadius = 10.0f;
        
        [tabButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [tabButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [tabButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14.0f]];
        

        
        
        [self addSubview:tabButton];
    }
    
    [self setContentSize:CGSizeMake(rightEndPoint, 49.0f)];
    
    if (self.contentSize.width > self.frame.size.width) {
        [self.rightIndicatorView setHidden:NO];
    }else{
        [self.rightIndicatorView setHidden:YES];
    }
    
    [self layoutSubviews];
}

-(void)tabButtonPressed:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)sender;
        
        if (button.tag != activeIndex+kButtonBaseTag) {
            UIButton *activeButton = (UIButton *)[self viewWithTag:kButtonBaseTag+activeIndex];
            
            
            [self setButtonToNormalAppearance:activeButton];
            [self setButtonToSelectedAppearance:button];
            
            activeIndex = button.tag - kButtonBaseTag;
            
            [horizTabBarDelegate tabBarView:self itemSelectedAtIndex:activeIndex];
        }
    }
}

-(void) setButtonToNormalAppearance:(UIButton *) button
{

    [button setSelected:NO];
    button.layer.borderColor = [UIColor clearColor].CGColor;

    if ([button.layer.sublayers objectAtIndex:1] ) {
        CALayer *tempLayer = [button.layer.sublayers objectAtIndex:1];
        [[button.layer.sublayers objectAtIndex:0] removeFromSuperlayer];
        [[button.layer.sublayers objectAtIndex:1] removeFromSuperlayer];
        [button.layer insertSublayer:tempLayer atIndex:0];
    }
    
}

-(void) setButtonToSelectedAppearance:(UIButton *) button
{
    [button setSelected:YES];
    button.layer.borderColor = [UIColor redColor].CGColor;
    
    CALayer *tempLayer = [button.layer.sublayers objectAtIndex:0];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, button.frame.size.width, button.frame.size.height);
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor orangeColor] CGColor], (id)[[UIColor redColor] CGColor], nil];
    gradient.cornerRadius = 10.0f;
    [button.layer insertSublayer:gradient atIndex:0];
    [button.layer insertSublayer:tempLayer atIndex:1];
}


@end
