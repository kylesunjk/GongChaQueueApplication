//
// Created by pfpldev on 27/1/15.
// Copyright (c) 2015 KyleSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>





@protocol GCProductObject
@end


@interface GCProductObject : JSONModel
@property (strong , nonatomic) NSString *pid;
@property (strong , nonatomic) NSString *name;
@property (strong , nonatomic) NSString *price;
@end


@interface GCProductsObject : JSONModel
@property (strong , nonatomic) NSArray <GCProductObject>*products;
@end