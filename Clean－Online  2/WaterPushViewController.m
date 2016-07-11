//
//  WaterPushViewController.m
//  Dry-CleanOnline
//
//  Created by 李康 on 16/6/27.
//  Copyright © 2016年 李康. All rights reserved.
//

#import "WaterPushViewController.h"
#import "LinWaterFlowLayout.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface WaterPushViewController ()<LinWaterFlowLayoutDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic,strong) UICollectionView *cv;
@property (nonatomic, strong) NSMutableArray *cellHeights;


@end
static int count = 10;
@implementation WaterPushViewController

- (UICollectionView *)collectionView
{
    if (!self.cv) {
        LinWaterFlowLayout *layout = [[LinWaterFlowLayout alloc] init];
        
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.delegate = self;
        self.cv = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        self.cv.backgroundColor = [UIColor whiteColor];
        self.cv.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        self.cv.dataSource = self;
        self.cv.delegate = self;
        self.cv.showsVerticalScrollIndicator = NO;
        
        [self.cv registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:@"cell"];
    }
    return self.cv;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"瀑布流展示";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backbt.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backView)];
    
    
    
    [self.navigationItem setLeftBarButtonItem:back];
    [self collectionView];
    [self.view addSubview:self.cv];
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && self.view.window == nil) {
        self.view = nil;
    }
    // Dispose of any resources that can be recreated.
}


-(void)backView{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

    
}
//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
//    [self updateLayout];
//}
//
//
//- (void)updateLayout
//{
//    LinWaterFlowLayout *layout =
//    (LinWaterFlowLayout *)self.collectionView.collectionViewLayout;
//    layout.itemWidth = 150;
//}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell =
    (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    
//    UIImageView *img = [[UIImageView alloc]initWithFrame:cell.frame];
//    img.image = [UIImage imageNamed:@"4.jpg"];
    
   // [cell addSubview:img];
    
    //cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"water.jpg"]];
//    
    
    
    
    return cell;
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"-------------%ld",(long)indexPath.item);
//}

#pragma mark -LinWaterFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(LinWaterFlowLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //return 160;
    return arc4random()%200+100;          //返回所需要的高度
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(LinWaterFlowLayout *)collectionViewLayout eachColumnStartingY:(NSUInteger)column
{
    if( column == 1 )
    {
        return 80;
    }
    return 0;
}

#pragma mark-UIScrollViewDelegate
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    NSLog(@"%f----%f", scrollView.contentOffset.y, scrollView.contentSize.height);
//    if( scrollView.contentOffset.y + SCREENHEIGHT > scrollView.contentSize.height + 60 )
//    {
//        count += 10;
//        CGPoint offset = scrollView.contentOffset;
//        offset.y += 60;
//        scrollView.contentOffset = offset;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.cv reloadData];
//        });
//    }
//    
//}

@end
