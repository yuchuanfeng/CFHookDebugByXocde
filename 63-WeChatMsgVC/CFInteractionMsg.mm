//
//  _3_WeChatMsgVC.mm
//  63-WeChatMsgVC
//
//  Created by 于传峰 on 2016/12/19.
//  Copyright (c) 2016年 __MyCompanyName__. All rights reserved.
//

// CaptainHook by Ryan Petrich
// see https://github.com/rpetrich/CaptainHook/

#import <Foundation/Foundation.h>
#import "CaptainHook/CaptainHook.h"
#include <notify.h> // not required; for examples only
#import <UIKit/UIKit.h>
#import "CMessageWrap.h"
#import "CContactMgr.h"
#import "MMServiceCenter.h"
#import "CContact.h"
#import "CBNewestMsgManager.h"
#import <objc/runtime.h>
#import <objc/objc.h>
#import "MMMsgLogicManager.h"
#import "CBMessageHud.h"
#import "CMessageMgr.h"
#import "MMWebViewController.h"
#import "BaseMsgContentViewController.h"
#import "CAppViewControllerManager.h"


#define CBWeChatNewMessageNotification @"newCBMessageNotiKey"



CHDeclareClass(CMessageMgr)
CHDeclareClass(CMessageWrap)
CHDeclareClass(BaseMsgContentViewController)
CHDeclareClass(MMWebViewController)

void backToWebViewController(id self, SEL _cmd);
void didReceiveNewMessage(id self, SEL _cmd);
void backToMsgContentViewController(id self, SEL _cmd, id button);
void addNewMethod();


#pragma mark - 消息
CHMethod(2, void, CMessageMgr, AsyncOnAddMsg, NSString*, msg, MsgWrap, CMessageWrap*, wrap)
{
    CHSuper(2,  CMessageMgr, AsyncOnAddMsg, msg, MsgWrap, wrap);
    [CBNewestMsgManager sharedInstance].username = msg;
    [CBNewestMsgManager sharedInstance].content = wrap.m_nsPushContent;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CBWeChatNewMessageNotification object:nil];
}

CHMethod(1, void, BaseMsgContentViewController, viewWillAppear, BOOL, animated)
{
    CHSuper(1, BaseMsgContentViewController, viewWillAppear, animated);
   
    NSArray *webViewViewControllers = [CBNewestMsgManager sharedInstance].webViewViewControllers;
    if (webViewViewControllers) {
        UIViewController* currentVC = (UIViewController *)self;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(currentVC.view.frame.size.width - 50, 84, 40, 40)];
        button.backgroundColor = [UIColor greenColor];
        
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Icon@2x" ofType:@"png"]];
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backToWebViewController) forControlEvents:UIControlEventTouchUpInside];
        [currentVC.view addSubview:button];
    }
}

CHMethod(0, void, MMWebViewController, viewDidLoad)
{
    CHSuper(0, MMWebViewController, viewDidLoad);
    NSLog(@"MMWebViewController didload");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cb_didReceiveNewMessage) name:CBWeChatNewMessageNotification object:nil];
    
}


void backToWebViewController(id self, SEL _cmd){
    NSArray *webViewViewControllers = [CBNewestMsgManager sharedInstance].webViewViewControllers;
    if (webViewViewControllers) {
        [[objc_getClass("CAppViewControllerManager") getCurrentNavigationController] setViewControllers:webViewViewControllers animated:YES];
        [CBNewestMsgManager sharedInstance].webViewViewControllers = nil;
    }
}

void didReceiveNewMessage(id self, SEL _cmd){
    UIViewController* currentVC = [objc_getClass("CAppViewControllerManager") topViewControllerOfWindow:[UIApplication sharedApplication].keyWindow];
    if (![currentVC isKindOfClass:objc_getClass("MMWebViewController")])
    {
        return;
    }
    NSString *content = [CBNewestMsgManager sharedInstance].content;
    //    CContactMgr *contactMgr = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("CContactMgr") class]];
    //    CContact *contact = [contactMgr getContactByName:username];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *text = [NSString stringWithFormat:@"%@", content];
        UIButton* hud = [CBMessageHud showHUDInView:currentVC.view text:text target:self action:@selector(backToMsgContentViewController:)];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud removeFromSuperview];
        });
    });
}

void backToMsgContentViewController(id self, SEL _cmd, id button){
    
    [(UIButton*)button removeFromSuperview];
    UIViewController* currentVC = (UIViewController *)self;;
    if (![currentVC isKindOfClass:objc_getClass("MMWebViewController")])
    {
        NSLog(@"current is  msg");
        return ;
    }

    // 返回聊天界面 ViewController 前记录当前 navigationController 的 VC 堆栈，以便快速返回
    NSArray *webViewViewControllers = [(UINavigationController *)[objc_getClass("CAppViewControllerManager") getCurrentNavigationController] viewControllers];
    [CBNewestMsgManager sharedInstance].webViewViewControllers = webViewViewControllers;
    
    // 返回 rootViewController
    UINavigationController *navVC = [objc_getClass("CAppViewControllerManager") getCurrentNavigationController];
    [navVC popToRootViewControllerAnimated:NO];
    

    // 进入聊天界面 ViewController
    NSString *username = [CBNewestMsgManager sharedInstance].username;
    CContactMgr *contactMgr = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("CContactMgr") class]];
    CContact *contact = [contactMgr getContactByName:username];
    MMMsgLogicManager *logicMgr = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("MMMsgLogicManager") class]];

    NSLog(@"push to msg");
    [logicMgr PushOtherBaseMsgControllerByContact:contact navigationController:navVC animated:YES];
}

void addNewMethod(){
    class_addMethod(objc_getClass("BaseMsgContentViewController"), @selector(backToWebViewController), (IMP)backToWebViewController, "v@:");
    class_addMethod(objc_getClass("MMWebViewController"), @selector(cb_didReceiveNewMessage), (IMP)didReceiveNewMessage, "v@:");
    class_addMethod(objc_getClass("MMWebViewController"), @selector(backToMsgContentViewController:), (IMP)backToMsgContentViewController, "v@:@");

}


__attribute__((constructor)) static void entry()
{
    CHLoadLateClass(CMessageMgr);
    CHLoadLateClass(CMessageWrap);
    CHLoadLateClass(BaseMsgContentViewController);
    CHLoadLateClass(MMWebViewController);
    
    CHClassHook(2, CMessageMgr, AsyncOnAddMsg, MsgWrap);
    CHClassHook(1, BaseMsgContentViewController, viewWillAppear);
    CHClassHook(0, MMWebViewController, viewDidLoad);
    
    addNewMethod();
}
