//
//  CBNewestMsgManager.m
//  64-dynamicDemo
//
//  Created by 于传峰 on 2016/12/19.
//
//

#import "CBNewestMsgManager.h"

static CBNewestMsgManager* instance;

@implementation CBNewestMsgManager


+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [CBNewestMsgManager new];
    });
    
    return instance;
}

@end
