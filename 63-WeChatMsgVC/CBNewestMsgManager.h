//
//  CBNewestMsgManager.h
//  64-dynamicDemo
//
//  Created by 于传峰 on 2016/12/19.
//
//

#import <Foundation/Foundation.h>

@interface CBNewestMsgManager : NSObject

+ (instancetype)sharedInstance;


@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) NSArray *webViewViewControllers;


@end
