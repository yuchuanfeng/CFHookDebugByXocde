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


#define CBWeChatNewMessageNotification @"newCBMessageNotiKey"

//#define CurrentVC\
//    UITabBarController* tabbarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;\
//    UINavigationController* navVC = [tabbarVC selectedViewController];\
//    UIViewController* currentVC = [navVC topViewController];


CHDeclareClass(CMessageMgr)
CHDeclareClass(CMessageWrap)
CHDeclareClass(BaseMsgContentViewController)
CHDeclareClass(MMWebViewController)

UIViewController* getCurrentVC(){
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    result.view.backgroundColor = [UIColor redColor];
    NSLog(@"childViewControllers = %@", result.navigationController.childViewControllers);
    return result;
}

void backToWebViewController(id self, SEL _cmd){
    NSArray *webViewViewControllers = [CBNewestMsgManager sharedInstance].webViewViewControllers;
    if (webViewViewControllers) {
        [[objc_getClass("CAppViewControllerManager") getCurrentNavigationController] setViewControllers:webViewViewControllers animated:YES];
    }
}

void didReceiveNewMessage(id self, SEL _cmd){
    UIViewController* currentVC = getCurrentVC();
    NSString *username = [CBNewestMsgManager sharedInstance].username;
    NSString *content = [CBNewestMsgManager sharedInstance].content;
    CContactMgr *contactMgr = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("CContactMgr") class]];
    CContact *contact = [contactMgr getContactByName:username];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *text = [NSString stringWithFormat:@"%@:\n %@", contact.m_nsFBNickName ?: username, content];
        [CBMessageHud showHUDInView:currentVC.view text:text target:self action:@selector(backToMsgContentViewController)];
    });
}

void backToMsgContentViewController(id self, SEL _cmd){
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
        [logicMgr PushOtherBaseMsgControllerByContact:contact navigationController:navVC animated:YES];
}


#pragma mark - 消息
CHMethod(2, void, CMessageMgr, AsyncOnAddMsg, NSString*, msg, MsgWrap, CMessageWrap*, wrap)
{
    CHSuper(2,  CMessageMgr, AsyncOnAddMsg, msg, MsgWrap, wrap);
    NSLog(@"msg = %@", msg);
    [CBNewestMsgManager sharedInstance].username = msg;
    [CBNewestMsgManager sharedInstance].content = wrap.m_nsContent;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CBWeChatNewMessageNotification object:nil];
}

CHMethod(0, void, BaseMsgContentViewController, viewDidLoad)
{
    CHSuper(0, BaseMsgContentViewController, viewDidLoad);
    UIViewController* currentVC = getCurrentVC();
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(currentVC.view.frame.size.width - 50, 84, 40, 40)];
    button.backgroundColor = [UIColor greenColor];
    
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Icon@2x" ofType:@"png"]];
    [button setImage:[UIImage imageNamed:@"Icon"]?:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backToWebViewController) forControlEvents:UIControlEventTouchUpInside];
    [currentVC.view addSubview:button];
    class_addMethod(objc_getClass("BaseMsgContentViewController"), @selector(backToWebViewController), (IMP)backToWebViewController, "v@:");
}

CHMethod(0, void, MMWebViewController, viewDidLoad)
{
    CHSuper(0, MMWebViewController, viewDidLoad);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cb_didReceiveNewMessage) name:CBWeChatNewMessageNotification object:nil];
    class_addMethod(objc_getClass("MMWebViewController"), @selector(cb_didReceiveNewMessage), (IMP)didReceiveNewMessage, "v@:");
    class_addMethod(objc_getClass("MMWebViewController"), @selector(backToMsgContentViewController), (IMP)backToMsgContentViewController, "v@:");
}


__attribute__((constructor)) static void entry()
{
    CHLoadLateClass(CMessageMgr);
    CHLoadLateClass(CMessageWrap);
    CHLoadLateClass(BaseMsgContentViewController);
    CHLoadLateClass(MMWebViewController);
    
    CHClassHook(2, CMessageMgr, AsyncOnAddMsg, MsgWrap);
    CHClassHook(0, BaseMsgContentViewController, viewDidLoad);
    CHClassHook(0, MMWebViewController, viewDidLoad);
    
    
}
