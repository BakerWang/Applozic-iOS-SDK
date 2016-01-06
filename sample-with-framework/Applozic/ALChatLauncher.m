//

//  MBChatManager.m

//  Applozic

//

//  Created by devashish on 21/12/2015.

//  Copyright © 2015 applozic Inc. All rights reserved.

//



#import "ALChatLauncher.h"
#import "ALUserDefaultsHandler.h"
#import "ALApplozicSettings.h"
#import "ALChatViewController.h"
#import "ALUser.h"
#import "ALRegisterUserClientService.h"
#import "ALMessageClientService.h"



@interface ALChatLauncher ()

@end
@implementation ALChatLauncher



- (instancetype)initWithApplicationId:(NSString *) applicationId;

{
    self = [super init];
    if (self) {
        self.applicationId = applicationId;
    }
    return self;
}



-(void)ALDefaultChatViewSettings

{
    
    [ALUserDefaultsHandler setLogoutButtonHidden:NO];
    [ALUserDefaultsHandler setBottomTabBarHidden:NO];
    [ALApplozicSettings setUserProfileHidden:NO];
    [ALApplozicSettings hideRefreshButton:NO];
    [ALApplozicSettings setTitleForConversationScreen:@"Conversation"];
    
    [ALApplozicSettings setFontFace:@"Helvetica"];
    [ALApplozicSettings setColourForReceiveMessages:[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1]];
    [ALApplozicSettings setColourForSendMessages:[UIColor colorWithRed:66.0/255 green:173.0/255 blue:247.0/255 alpha:1]];
//    [ALApplozicSettings setColourForNavigation:[UIColor whiteColor]];
//    [ALApplozicSettings setColourForNavigationItem:[UIColor blueColor]];
//    [ALApplozicSettings setColourForNavigation: [UIColor colorWithRed:66.0/255 green:173.0/255 blue:247.0/255 alpha:1]];
//    [ALApplozicSettings setColourForNavigationItem: [UIColor whiteColor]];
    
}



-(void)launchIndividualChat:(NSString *)userId andViewControllerObject:(UIViewController *)viewController andWithText:(NSString *)text;

{
    [self ALDefaultChatViewSettings];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Applozic"
                                
                                                         bundle:[NSBundle bundleForClass:ALChatViewController.class]];
    
    ALChatViewController *chatView =(ALChatViewController*) [storyboard instantiateViewControllerWithIdentifier:@"ALChatViewController"];
    chatView.contactIds = userId;
    chatView.text = text;
    chatView.individualLaunch = YES;
    
    UINavigationController *conversationViewNavController = [[UINavigationController alloc] initWithRootViewController:chatView];
    [viewController presentViewController:conversationViewNavController animated:YES completion:nil];
    
    
    
}

-(void)launchChatList:(NSString *)title andViewControllerObject:(UIViewController *)viewController

{
    
    [ALApplozicSettings setTitleForBackButton:title];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Applozic"
                                
                                                         bundle:[NSBundle bundleForClass:ALChatViewController.class]];
   
    UIViewController *theTabBar = [storyboard instantiateViewControllerWithIdentifier:@"messageTabBar"];
    [viewController presentViewController:theTabBar animated:YES completion:nil];
    
}


-(void)registerForNotification{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }else
    {
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
}

-(void)launchContactList:(UIViewController *)uiViewController {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Applozic"
                                
                                                         bundle:[NSBundle bundleForClass:ALChatViewController.class]];
    UIViewController *contcatListView = [storyboard instantiateViewControllerWithIdentifier:@"ALNewContactsViewController"];
    UINavigationController *conversationViewNavController = [[UINavigationController alloc] initWithRootViewController:contcatListView];
    [uiViewController presentViewController:conversationViewNavController animated:YES completion:nil];

}

@end

