//
// Created by pfpldev on 27/1/15.
// Copyright (c) 2015 KyleSun. All rights reserved.
//

#import "GCProductAddonsListViewController.h"
#import "GCConfirmViewController.h"
#import "SimpleAlertView.h"
@interface GCProductAddonsListViewController (){
    
}
@property (weak, nonatomic) IBOutlet UITableView *addonsTableview;
@property (strong , nonatomic) NSArray *addonsArray;
@end

@implementation GCProductAddonsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    NSString *productID = self.orderDetailObject.product.pid;
    [GCApiManager getAddonsListWithProductId:productID withViewController:self completion:^(NSArray *addonsList) {
        self.addonsArray = addonsList;
        [self.addonsTableview reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)gotoConfirmPage:(id)sender {
    if ([self.orderDetailObject isValidOrder]) {
        [self performSegueWithIdentifier:@"gotoConfirm" sender:self];
    }
    else{
        [SimpleAlertView show:@"pls choose addons" withViewController:self];
    }
}

#pragma mark - Tableview Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addonsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"addonsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [[cell contentView] setFrame:[cell bounds]];
    [[cell contentView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    
//    UIImageView *addonsImageview = (UIImageView *) [cell viewWithTag:1];
    UILabel *addonsNameLabel = (UILabel *) [cell viewWithTag:2];
    UILabel *addonsDescriptionLabel = (UILabel *) [cell viewWithTag:3];
    
    GCAddonsObject *addonsObject = [self.addonsArray objectAtIndex:indexPath.row];
    
//    [addonsImageview sd_setImageWithURL:[NSURL URLWithString:[coupon photo]] placeholderImage:nil];
    [addonsNameLabel setText:[addonsObject name]];
    [addonsDescriptionLabel setText:[addonsObject price]];
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    if (!self.orderDetailObject.addons) {
//        self.orderDetailObject.addons = [[NSMutableSet alloc] init];
//    }
//    if(cell.accessoryType==UITableViewCellAccessoryNone)
//    {
//        cell.accessoryType=UITableViewCellAccessoryCheckmark;
//        [self.orderDetailObject.addons addObject:[self.addonsArray objectAtIndex:indexPath.row]];
//    }
//    else{
//        cell.accessoryType=UITableViewCellAccessoryNone;
//        [self.orderDetailObject.addons  removeObject:[self.addonsArray objectAtIndex:indexPath.row]];
//    }
    self.orderDetailObject.addons = [self.addonsArray objectAtIndex:indexPath.row];
    if ([self.orderDetailObject isValidOrder]) {
        [self performSegueWithIdentifier:@"gotoConfirm" sender:self];
    }
    else{
        [SimpleAlertView show:@"pls choose addons" withViewController:self];
    }
}



 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if ([segue.identifier isEqualToString:@"gotoConfirm"]) {
         GCConfirmViewController *destinationViewController = [segue destinationViewController];
         destinationViewController.orderDetailObject = self.orderDetailObject;
     }

 }


@end