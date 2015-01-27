//
// Created by pfpldev on 27/1/15.
// Copyright (c) 2015 KyleSun. All rights reserved.
//

#import "SimpleAlertView.h"


@implementation SimpleAlertView {

}

+(void)show:(NSString *)message withViewController:(UIViewController *)controller{
    if (CURRENT_VERSION >= 8.0) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert] ;
//        
//        [controller presentViewController:alert animated:YES completion:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:controller cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:controller cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}
@end