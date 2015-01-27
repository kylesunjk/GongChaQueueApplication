//
// Created by pfpldev on 27/1/15.
// Copyright (c) 2015 KyleSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
@protocol GCAddonsObject
@end


@interface GCAddonsObject : JSONModel
@property (strong , nonatomic) NSString *aid;
@property (strong , nonatomic) NSString *name;
@property (strong , nonatomic) NSString *price;
@end


@interface GCAddonsListObject : JSONModel
@property (strong , nonatomic) NSArray <GCAddonsObject>*addons;
@end