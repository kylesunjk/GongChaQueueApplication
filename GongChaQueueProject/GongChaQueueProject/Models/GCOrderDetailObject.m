//
// Created by pfpldev on 27/1/15.
// Copyright (c) 2015 KyleSun. All rights reserved.
//

#import "GCOrderDetailObject.h"


@implementation GCOrderDetailObject {

}
-(BOOL)isValidOrder{
    if(self.product && self.addons ){
        return YES;
    }
    else{
        return NO;
    }
}
@end