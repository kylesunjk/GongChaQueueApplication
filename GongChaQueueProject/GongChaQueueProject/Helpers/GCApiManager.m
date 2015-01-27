//
// Created by pfpldev on 27/1/15.
// Copyright (c) 2015 KyleSun. All rights reserved.
//

#import "GCApiManager.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "SimpleAlertView.h"
#import "CommonTools.h"
#import "NSNetworkFailed.h"
#import "NSDeserializationFailed.h"
#import "CDCache.h"
#import "MICacheData.h"
#import "GCProductObject.h"
#import "GCAddonsObject.h"
@implementation GCApiManager {

}

+ (BFTask *)loadDataFromPath:(NSString *)path {
    return [[BFTask taskWithResult:path] continueWithBlock:^id(BFTask *task) {
        CDCache *jobsCache = [[MICacheData singleton] dbLoad:[GC_APIDOMAIN stringByAppendingString:path]];
        if (jobsCache == nil || (double) [[NSDate date] timeIntervalSince1970] - [jobsCache.timestamp doubleValue] > 300) {
            BFTaskCompletionSource *source = [BFTaskCompletionSource taskCompletionSource];
            
            [SVProgressHUD show];
            NSString *postingUrl = [GC_APIDOMAIN stringByAppendingString:path];
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager GET:postingUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSData *data = [CommonTools toJSONData:responseObject];
                NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                CDCache *cache = [[MICacheData singleton] dbSave:postingUrl withContent:json];
                    [source setResult:cache];
                [SVProgressHUD dismiss];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [source setError:[NSNetworkFailed cause:error]];
                [SVProgressHUD dismiss];
            }];
            return [source task];
            
        }
        else {
            return [BFTask taskWithResult:jobsCache];
        }
    }];
}



+ (void)getProductListWithViewController:(UIViewController *)viewcontroller completion:(void (^)(NSArray * products))success{
    
    [[[GCApiManager loadDataFromPath:@"products"] continueWithSuccessBlock:^id(BFTask *task) {
        
        CDCache *cache = task.result;
        id productData = [[cache json] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *initError = nil;
        GCProductsObject *product = [[GCProductsObject alloc] initWithData:productData error:&initError];
        if (initError) {
            return [BFTask taskWithError:[NSDeserializationFailed cause:initError]];
        } else {
            success (product.products);
            return nil;
        }
    }] continueWithBlock:^id(BFTask *task) {
        if (task.error) {
            [SimpleAlertView show:[task.error localizedDescription] withViewController:viewcontroller];
        }
        return nil;
    
    }];

}


+ (void)getAddonsListWithProductId:(NSString *)productId withViewController:(UIViewController *)viewcontroller completion:(void (^)(NSArray * addonsList))success{
   
    [[[GCApiManager loadDataFromPath:[@"addons/" stringByAppendingString:productId]] continueWithSuccessBlock:^id(BFTask *task) {
        
        CDCache *cache = task.result;
        id addonsData = [[cache json] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *initError = nil;
        GCAddonsListObject *addonsList = [[GCAddonsListObject alloc] initWithData:addonsData error:&initError];
        if (initError) {
            return [BFTask taskWithError:[NSDeserializationFailed cause:initError]];
        } else {
            success (addonsList.addons);
            return nil;
        }
    }] continueWithBlock:^id(BFTask *task) {
        if (task.error) {
            [SimpleAlertView show:[task.error localizedDescription] withViewController:viewcontroller];
        }
        return nil;
        
    }];

}

+ (void)submitOrderWithProductID:(NSString *)productID withAddons:(NSString *)addonsID withViewController:(UIViewController *)viewcontroller completion:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:productID,@"product",
                                                                           addonsID,@"addons",
                                                                                    nil];
    [manager POST:[GC_APIDOMAIN stringByAppendingString:@"submit"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        success(operation , responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
@end