//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <Foundation/Foundation.h>

//#import "IAcctStorageMgrExt.h"
//#import "IBrandAttrMgrExt.h"
//#import "IContactProfileMgrExt.h"
//#import "IMMLanguageMgrExt.h"
//#import "MMService.h"
//#import "MessageObserverDelegate.h"
//#import "PBMessageObserverDelegate.h"

@class CContactDB, CContactOPLog, NSMutableDictionary, NSRecursiveLock, NSString, NewContactDB;

@interface CContactMgr : NSObject
{
    NSRecursiveLock *m_oLock;
    unsigned long m_uiLoadedType;
    CContactDB *m_oContactDB;
    NewContactDB *m_oNewContactDB;
    CContactOPLog *m_oContactOPLog;
    NSRecursiveLock *m_oMainControllerLock;
    NSMutableDictionary *m_dicRemark;
    NSMutableDictionary *m_dicLastAccessTime;
    NSMutableDictionary *m_dicContacts;
    NSMutableDictionary *m_dicEncodeContacts;
    NSMutableDictionary *m_mapLastGetTime;
    NSMutableDictionary *m_dicHardCodeUsers;
    unsigned long m_uiDBVersion;
    BOOL m_shouldContactDBMigration;
    BOOL m_bContactDBMigrationFinished;
    unsigned long m_uiMaxStrangerCache;
    BOOL m_bOpenStrangerCache;
}

//- (void).cxx_destruct;
- (id)getAllContactUserName;
- (id)getContactForSearchByName:(id)arg1;
- (BOOL)isOpenStrangerCache;
- (void)callModifyContactForCPState:(id)arg1;
- (BOOL)isHeadImgUpdated:(id)arg1 Local:(id)arg2;
- (void)onBrandContactModified:(id)arg1 withAttrChanged:(id)arg2;
- (BOOL)ChangeNotifyStatus:(id)arg1 withStatus:(BOOL)arg2 sync:(BOOL)arg3;
- (BOOL)ChangeNotifyStatusForChatRoom:(id)arg1 withStatus:(BOOL)arg2 sync:(BOOL)arg3;
- (void)main_onPushModifyContact:(id)arg1;
- (id)thread_onBatchModifyChatRoomMember:(id)arg1;
- (id)thread_onpushBatchModContact:(id)arg1;
- (void)main_onPushAddContact:(id)arg1;
- (void)main_onPushDeleteContact:(id)arg1;
- (void)setSelfContactUpdated;
- (id)getSelfContact;
- (BOOL)updateContactToCache:(id)arg1;
- (BOOL)shouldUpdateContact:(id)arg1;
- (void)MessageReturn:(id)arg1 Event:(unsigned long)arg2;
- (void)onGetContact:(id)arg1;
- (id)HandleMemContact:(id)arg1;
- (void)MainThread_ReloadMemContact:(id)arg1;
- (void)thread_ReloadMemConact:(id)arg1 ChatRoom:(id)arg2;
- (id)thread_HandleMemContact:(id)arg1;
- (void)MessageReturn:(unsigned long)arg1 MessageInfo:(id)arg2 Event:(unsigned long)arg3;
- (void)main_onPushBatchModContact:(id)arg1;
- (void)onLanguageChange;
- (void)onSettingChange;
- (void)onServiceClearData;
- (void)onServiceReloadData;
- (BOOL)onServiceMemoryWarning;
- (void)updateContactLocalData;
- (void)fixContactPluginOldData;
- (id)getGroupCardMemberList:(id)arg1;
- (BOOL)getContactsFromServer:(id)arg1 chatContact:(id)arg2 withScene:(int)arg3 withTicket:(id)arg4 usrData:(id)arg5;
- (BOOL)getInviteeContactsFromServer:(id)arg1 withTicket:(id)arg2;
- (BOOL)getContactsFromServer:(id)arg1;
- (BOOL)getContactsFromServer:(id)arg1 chatContact:(id)arg2;
- (BOOL)getContactsFromSvrForTempChat:(id)arg1;
- (BOOL)internalGetContactsFromSvr:(id)arg1 chatContact:(id)arg2 usrData:(id)arg3;
- (void)addToGetContactMap:(id)arg1;
- (BOOL)checkIfForbiddenGetContact:(id)arg1;
- (BOOL)syncAllSXContact;
- (void)tryLoadExtInfoForContact:(id)arg1;
- (void)reloadContact:(id)arg1;
- (BOOL)delayLoadAllContactInBackGround;
- (void)reportIDKey:(id)arg1 stranger:(id)arg2;
- (void)thread_saveContactImageStatus:(id)arg1 Status:(id)arg2 Image:(id)arg3 Url:(id)arg4;
- (void)reloadContactImageStatus:(id)arg1 Status:(id)arg2 Image:(id)arg3;
- (BOOL)setHDHeadUpdated:(id)arg1;
- (BOOL)setContact:(id)arg1 chatState:(unsigned long)arg2;
- (BOOL)setContact:(id)arg1 textTranslateOpen:(BOOL)arg2 sync:(BOOL)arg3;
- (BOOL)setLocalContactToUntopSession:(id)arg1;
- (BOOL)setContact:(id)arg1 sessionTop:(BOOL)arg2 sync:(BOOL)arg3;
- (BOOL)setContact:(id)arg1 notifyOpen:(BOOL)arg2 sync:(BOOL)arg3;
- (BOOL)setContact:(id)arg1 hideHashPhone:(BOOL)arg2 sync:(BOOL)arg3;
- (BOOL)setContact:(id)arg1 watchContact:(BOOL)arg2 sync:(BOOL)arg3;
- (BOOL)setContact:(id)arg1 favour:(BOOL)arg2 sync:(BOOL)arg3;
- (BOOL)setLocalContact:(id)arg1 notifyOpen:(BOOL)arg2;
- (BOOL)setContact:(id)arg1 typeBit:(unsigned long)arg2 set:(BOOL)arg3 sync:(BOOL)arg4;
- (BOOL)setContact:(id)arg1 typeBit:(unsigned long)arg2 set:(BOOL)arg3 sync:(BOOL)arg4 localSet:(BOOL)arg5;
- (BOOL)setNoBlack:(id)arg1 sync:(BOOL)arg2;
- (BOOL)setBlack:(id)arg1 sync:(BOOL)arg2;
- (BOOL)setNoBlack:(id)arg1;
- (BOOL)setBlack:(id)arg1;
- (BOOL)setBlack:(id)arg1 blackFlag:(BOOL)arg2 sync:(BOOL)arg3;
- (BOOL)setContact:(id)arg1 chatRoomAccessType:(unsigned long)arg2;
- (BOOL)setContact:(id)arg1 RoomDetail:(id)arg2;
- (BOOL)setContact:(id)arg1 chatRoomData:(id)arg2;
- (BOOL)setContact:(id)arg1 owner:(id)arg2;
- (BOOL)setContact:(id)arg1 snsBlack:(BOOL)arg2;
- (BOOL)setContact:(id)arg1 mobileIdentify:(id)arg2;
- (BOOL)setContact:(id)arg1 googleContactName:(id)arg2;
- (BOOL)setContact:(id)arg1 googleContactNickName:(id)arg2;
- (BOOL)clearDraftForContact:(id)arg1;
- (BOOL)setContact:(id)arg1 nickName:(id)arg2;
- (BOOL)setContact:(id)arg1 cardUrl:(id)arg2;
- (BOOL)setContact:(id)arg1 cardDesc:(id)arg2;
- (BOOL)setPhone:(id)arg1 Contact:(id)arg2;
- (BOOL)setContact:(id)arg1 remark:(id)arg2;
- (BOOL)setContact:(id)arg1 remark:(id)arg2 hideHashPhone:(BOOL)arg3;
- (void)modifyContactNickName:(id)arg1 nickName:(id)arg2 callMod:(BOOL)arg3;
- (BOOL)RemoveContactFromChatList:(id)arg1;
- (BOOL)deleteContact:(id)arg1 listType:(unsigned long)arg2 andScene:(unsigned long)arg3 sync:(BOOL)arg4;
- (BOOL)deleteContact:(id)arg1 listType:(unsigned long)arg2 sync:(BOOL)arg3;
- (BOOL)deleteContact:(id)arg1 listType:(unsigned long)arg2;
- (BOOL)addFromMobileContact:(id)arg1;
- (BOOL)addFromQQContact:(id)arg1;
- (BOOL)addLocalContact:(id)arg1 listType:(unsigned long)arg2;
- (void)addContactInternal:(id)arg1;
- (BOOL)addContact:(id)arg1 listType:(unsigned long)arg2;
- (BOOL)addContact:(id)arg1 listType:(unsigned long)arg2 opLog:(BOOL)arg3;
- (id)getAllBrandContacts;
- (id)getAllEnterpriseMainBrandContacts;
- (id)getContactList:(unsigned long)arg1 contactType:(unsigned long)arg2 needLoadExt:(BOOL)arg3;
- (id)getContactList:(unsigned long)arg1 contactType:(unsigned long)arg2;
- (BOOL)isBelongToMMContactInCache:(id)arg1;
- (BOOL)isInContactList:(id)arg1;
- (BOOL)isContactExistLocal:(id)arg1;
- (BOOL)isContactBlack:(id)arg1;
- (id)getContactByNameFromCache:(id)arg1;
- (id)getContactByNameFromDB:(id)arg1;
- (id)getContactByName:(id)arg1;
- (void)updateCache:(id)arg1;
- (void)initDB:(id)arg1 lock:(id)arg2;
- (void)updateNewDB:(id)arg1 NewUser:(BOOL)arg2;
- (BOOL)isUserNewDB;
- (void)onPushDeleteContact:(id)arg1;
- (void)onPushModifyContact:(id)arg1 updateImage:(BOOL)arg2;
- (void)handleLocalField:(id)arg1 oldContact:(id)arg2;
- (id)reloadContact:(id)arg1 mergeImage:(id)arg2;
- (void)callOnRemoveContactFromAddressBook:(id)arg1;
- (void)callOnModifyContactHeadImageExt:(id)arg1;
- (void)callOnDeleteExt:(id)arg1;
- (void)callOnModifyExt:(id)arg1;
- (void)internalDeleteContact:(id)arg1;
- (void)internalModifyContact:(id)arg1;
- (void)internalNewContact:(id)arg1;
- (void)mergeChatRoomData:(id)arg1 oldContact:(id)arg2;
- (void)handleOfficalContactName:(id)arg1;
- (BOOL)isContactMatch:(id)arg1 listType:(unsigned long)arg2 contactType:(unsigned long)arg3;
- (int)interalReloadContacts:(unsigned long)arg1 needLoadExt:(BOOL)arg2;
- (BOOL)isHardCodeContact:(id)arg1;
- (void)addHardCodeContacts;
- (void)addAddHardcodeContact:(id)arg1 selector:(SEL)arg2;
- (id)generateOfficialContact:(id)arg1;
- (id)generatePluginContactNoListContact:(id)arg1;
- (id)generatePluginContact:(id)arg1;
- (id)generatePluginContact:(id)arg1 uiType:(unsigned long)arg2;
- (void)internalUpdateContactLocalDataWithUserName:(id)arg1;
- (void)refreshContactLocalData;
- (void)refreshPluginNickName:(BOOL)arg1;
- (void)addDictoryDataToCache:(id)arg1 listType:(unsigned long)arg2;
- (int)autoreloadContacts:(unsigned long)arg1 needLoadExt:(BOOL)arg2;
- (int)autoreloadContacts:(unsigned long)arg1;
- (id)addSelfContactToCache;
- (BOOL)isCacheAllLoaded;
- (void)dealloc;
- (void)removeListen;
- (void)initListen;
- (id)init;
- (BOOL)SetFriendMetaFlag:(unsigned long)arg1 ForUser:(id)arg2;
- (BOOL)SetLastUpdateTime:(unsigned long)arg1 ForUser:(id)arg2;
- (BOOL)ModifyNotifyStatus:(id)arg1 withStatus:(unsigned long)arg2;
- (BOOL)thread_onPushModifyContact:(id)arg1 isInit:(BOOL)arg2;
- (BOOL)thread_BatchModifyContact:(id)arg1;
- (id)addOrUpdateContactToDB:(id)arg1 listType:(unsigned long)arg2 add:(char *)arg3 modify:(char *)arg4;
- (BOOL)getAllRemarkList:(id)arg1 listType:(unsigned long)arg2;
- (BOOL)getAllUserName:(id)arg1;
- (BOOL)getAllContactNoExtInfoList:(id)arg1 listType:(unsigned long)arg2;
- (BOOL)getAllContactList:(id)arg1 listType:(unsigned long)arg2;
- (BOOL)migrationContacts:(unsigned long)arg1 first:(BOOL)arg2;
- (void)reportMigrationStat:(unsigned long)arg1 status:(unsigned long)arg2;
- (BOOL)splist_migrationContactList:(id)arg1;
- (void)setMigrationFinished;
- (BOOL)loadContactExtInfo:(id)arg1;
- (BOOL)updateContactToDb:(id)arg1;
- (BOOL)addContactToDb:(id)arg1;
- (BOOL)removeContactFromDB:(id)arg1;
- (id)getContactFromDB:(id)arg1;
- (void)removeContactFromDic:(id)arg1;
- (void)setContactToDic:(id)arg1 forKey:(id)arg2;
- (id)getContactFromDic:(id)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned int hash;
@property(readonly) Class superclass;

@end

