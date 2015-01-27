//
//  GCConfirmViewController.m
//  GongChaQueueProject
//
//  Created by pfpldev on 27/1/15.
//  Copyright (c) 2015 KyleSun. All rights reserved.
//

#import "GCConfirmViewController.h"
#import "SimpleAlertView.h"
@interface GCConfirmViewController ()

@end

@implementation GCConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitOrder:(id)sender {
    NSString *productID = self.orderDetailObject.product.pid;
    NSString *addonsID = self.orderDetailObject.addons.aid;
                        
    [GCApiManager submitOrderWithProductID:productID withAddons:addonsID withViewController:self completion:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SimpleAlertView show:@"success" withViewController:self];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
