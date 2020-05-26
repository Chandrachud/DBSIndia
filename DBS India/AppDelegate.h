//
//  AppDelegate.h
//  DBS India
//
//  Created by Chandrachud on 9/22/16.
//  Copyright © 2016 Chandrachud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITRAirSideMenu.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property ITRAirSideMenu *itrAirSideMenu;

-(void)showTheHomeScreenWithAnimationFlag:(BOOL)flag;
-(void)showTheLoginScreen;


@end

