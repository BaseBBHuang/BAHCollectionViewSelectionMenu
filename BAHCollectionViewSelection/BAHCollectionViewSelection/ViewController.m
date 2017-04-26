//
//  ViewController.m
//  BAHCollectionViewSelection
//
//  Created by 乔贝斯 on 2017/4/21.
//  Copyright © 2017年 BAH. All rights reserved.
//

#import "ViewController.h"
#import "BAHFunctionView.h"
#import "BAHMoreViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface ViewController ()<UIScrollViewDelegate, BAHMoreViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) NSMutableArray *imagesTowArray;
@property (nonatomic, strong) BAHFunctionView *functionView;
@end

@implementation ViewController

#pragma mark - getters and setters
- (NSMutableArray *)imagesArray
{
    if (!_imagesArray) {
        _imagesArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < 10; i++) {
            [_imagesArray addObject:[NSString stringWithFormat:@"%d", i+1]];
        }
//        [_imagesArray addObject:@"more"];
    }
    return _imagesArray;
}

- (NSMutableArray *)imagesTowArray
{
    if (!_imagesTowArray) {
        _imagesTowArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 21; i < 30; i++) {
            [_imagesTowArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    return _imagesTowArray;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    __weak __typeof(self) weakSelf = self;
    BAHFunctionView *fView = [[BAHFunctionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250) items:self.imagesArray  actionBlock:^(NSString *title) {
        
        if ([title isEqualToString:@"BAHCollectionViewCellPlus"]) {
            BAHMoreViewController *more = [[BAHMoreViewController alloc] init];
            more.imagesArray = self.imagesTowArray;
            [self.navigationController pushViewController:more animated:YES];
            more.delegate = self;
        }
        
    }];
    self.functionView = fView;
    [self.view addSubview:fView];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSelectedFuctionViewCell:(NSString *)menueString
{
    NSLog(@"menu: %@", menueString);
    
    if (menueString != nil) {
        [self.imagesArray addObject:menueString];
        [self.functionView.collectionView reloadData];
    }
}


@end
