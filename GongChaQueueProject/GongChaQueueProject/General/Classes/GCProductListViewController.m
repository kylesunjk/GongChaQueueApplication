//
// Created by pfpldev on 27/1/15.
// Copyright (c) 2015 KyleSun. All rights reserved.
//

#import "GCProductListViewController.h"
#import "GCProductObject.h"
#import "GCProductAddonsListViewController.h"
@interface GCProductListViewController (){
    
}
@property (weak, nonatomic) IBOutlet UICollectionView *productListCollectionView;
@property (strong , nonatomic) NSArray *productList;
@property (strong , nonatomic) GCOrderDetailObject *orderObject;
@end

@implementation GCProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!self.productList) {
        self.productList = [[NSArray alloc] init];
    }
    if (!self.orderObject) {
        self.orderObject = [[GCOrderDetailObject alloc] init];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [GCApiManager getProductListWithViewController:self completion:^(NSArray *products) {
        self.productList = products;
        [self.productListCollectionView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CollectionView Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.productList.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"productCell";
    UICollectionViewCell *cell = (UICollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    [[cell contentView] setFrame:[cell bounds]];
    [[cell contentView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];

    UILabel *productNameLabel = (UILabel *) [cell viewWithTag:2];
    UILabel *productPriceLabel = (UILabel *) [cell viewWithTag:3];
    
    GCProductObject *singleProduct = [self.productList objectAtIndex:indexPath.row];
    [productNameLabel setText:singleProduct.name];
    [productPriceLabel setText:singleProduct.price];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = collectionView.frame.size.width / 2;
    CGFloat height = width * 4 / 3; // width / 200 * 140;
    CGSize result = CGSizeMake(width - 10, height);
    return result;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.orderObject.product = [self.productList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"gotoAddons" sender:self];
}


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"gotoAddons"]) {
         GCProductAddonsListViewController *destinationViewController = [segue destinationViewController];
         destinationViewController.orderDetailObject = self.orderObject;
     }
}


@end