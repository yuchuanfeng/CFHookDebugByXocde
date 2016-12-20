//
//  CBMessageHud.h
//  64-dynamicDemo
//
//  Created by 于传峰 on 2016/12/19.
//
//

#import <UIKit/UIKit.h>

@interface CBMessageHud : NSObject

+ (void)showHUDInView:(UIView *)view text:(NSString *)text target:(id)target action:(SEL)selector;

@end
