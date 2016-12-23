//
//  CFPreRevokeMsg.m
//  63-WeChatMsgVC
//
//  Created by 于传峰 on 2016/12/21.
//
//
#import <Foundation/Foundation.h>
#import "CaptainHook/CaptainHook.h"

CHDeclareClass(CMessageMgr);

#pragma mark - 防撤回
CHMethod(1, void, CMessageMgr, onRevokeMsg, id, arg1)
{
    
    NSLog(@"\n>>>>>> onRevokeMsg <<<<<< \n arg1:[%@]%@ ", [arg1 class], arg1);
}


__attribute__((constructor)) static void entry()
{
    CHLoadLateClass(CMessageMgr);
    CHClassHook(1, CMessageMgr, onRevokeMsg);
    
}
