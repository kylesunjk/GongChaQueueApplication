//
// Created by pfpldev on 27/1/15.
// Copyright (c) 2015 KyleSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <Bolts/BFTask.h>
#import <Bolts/BFTaskCompletionSource.h>

@interface GCApiManager : NSObject

//main method for getting data
+ (BFTask *)loadDataFromPath:(NSString *)path;

//get all products list
+ (void)getProductListWithViewController:(UIViewController *)viewcontroller completion:(void (^)(NSArray * products))success;

//get addons list by product pid
+ (void)getAddonsListWithProductId:(NSString *)productId withViewController:(UIViewController *)viewcontroller completion:(void (^)(NSArray * addonsList))success;

//post submission data from custer
+ (void)submitOrderWithProductID:(NSString *)productID withAddons:(NSString *)addonsID withViewController:(UIViewController *)viewcontroller completion:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success;

//post submission data from custer
+ (void)registerUserNotificationKey:(NSString *)deviceToken withApplicatonType:(NSString *)typeName completion:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success;
@end