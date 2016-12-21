//
//  CFPreJailbreakCheck.m
//  63-WeChatMsgVC
//
//  Created by 于传峰 on 2016/12/21.
//
//
#import <Foundation/Foundation.h>
#import "CaptainHook/CaptainHook.h"

CHDeclareClass(JailBreakHelper);

#pragma mark - 越狱检测
CHMethod(0, BOOL, JailBreakHelper, HasInstallJailbreakPluginInvalidIAPPurchase)
{
    return NO;
}

CHMethod(0, BOOL, JailBreakHelper, IsJailBreak)
{
    return NO;
}
CHMethod(1, BOOL, JailBreakHelper, HasInstallJailbreakPlugin, id, arg1)
{
    return NO;
}


__attribute__((constructor)) static void entry()
{
    CHLoadLateClass(JailBreakHelper);

    CHClassHook(0, JailBreakHelper, HasInstallJailbreakPluginInvalidIAPPurchase);
    CHClassHook(0, JailBreakHelper, IsJailBreak);
    CHClassHook(1, JailBreakHelper, HasInstallJailbreakPlugin);
    
}
