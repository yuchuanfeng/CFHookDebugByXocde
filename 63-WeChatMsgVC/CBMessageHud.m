//
//  CBMessageHud.m
//  64-dynamicDemo
//
//  Created by 于传峰 on 2016/12/19.
//
//

#import "CBMessageHud.h"

static UIButton* contentView;



@implementation CBMessageHud

+ (UIButton *)showHUDInView:(UIView *)view text:(NSString *)text target:(id)target action:(SEL)selector
{
    NSLog(@"showHuD === %@", text);
    
    [contentView removeFromSuperview];
    contentView = nil;
    
    contentView = [[UIButton alloc] init];
    contentView.backgroundColor = [UIColor grayColor];
    contentView.layer.cornerRadius = 10;
    contentView.clipsToBounds = YES;
    
    [view addSubview:contentView];
    
    [contentView setTitle:text forState:UIControlStateNormal];
    [contentView sizeToFit];

    [contentView addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    contentView.frame = CGRectMake((view.frame.size.width - contentView.bounds.size.width)*0.5, 74, contentView.bounds.size.width, contentView.bounds.size.height);
    return contentView;
    
}

+ (BOOL)showed
{
    return contentView && contentView.superview;
}


@end
