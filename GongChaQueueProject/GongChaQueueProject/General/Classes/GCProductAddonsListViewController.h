//
// Created by pfpldev on 27/1/15.
// Copyright (c) 2015 KyleSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCOrderDetailObject.h"

@interface GCProductAddonsListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong , nonatomic) GCOrderDetailObject *orderDetailObject;
@end

