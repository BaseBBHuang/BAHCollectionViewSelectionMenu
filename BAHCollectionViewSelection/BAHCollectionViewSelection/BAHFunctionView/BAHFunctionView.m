//
//  BAHFunctionView.m
//  BAHCollectionViewSelection
//
//  Created by 乔贝斯 on 2017/4/21.
//  Copyright © 2017年 BAH. All rights reserved.
//

#import "BAHFunctionView.h"
#import "BAHCollectionViewCell.h"
#import "BAHCollectionViewCellPlus.h"
#import "BAHCollectionViewFlowLayout.h"

static NSString *collectionCellID = @"BAHCollectionViewCellID";
static NSString *collectionCellWhiteID = @"BAHCollectionViewCellWhiteID";
static NSString *collectionCellPlusID = @"BAHCollectionViewCellPlusID";
#define kPageControlHeight 20
#define kLineSpacing 1
#define kInteritemSpacing 1
#define kSelfFrame self.frame.size
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]


@interface BAHFunctionView ()<UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, BAHCollectionViewCellDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;
//排满页面的 cell 个数
@property (nonatomic, assign) NSUInteger pageCounter;
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, copy) void (^btnAction)(NSString *title);

@end

@implementation BAHFunctionView

#pragma mark - getters and setters
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [BAHCollectionViewFlowLayout new];
        layout.minimumLineSpacing = kLineSpacing;
        layout.minimumInteritemSpacing = kInteritemSpacing;
        layout.itemSize = CGSizeMake((kSelfFrame.width-3*kLineSpacing)/4, (kSelfFrame.height-kPageControlHeight-kLineSpacing)/2);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kSelfFrame.width, kSelfFrame.height-kPageControlHeight) collectionViewLayout:layout];
        _collectionView.bounces = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = RGBA(246, 246, 246, 1);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.delaysContentTouches = NO;//可以解决单元格被点击时，高亮显示慢的问题。
        [_collectionView registerNib:[UINib nibWithNibName:@"BAHCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:collectionCellID];
        [_collectionView registerNib:[UINib nibWithNibName:@"BAHCollectionViewCellPlus" bundle:nil] forCellWithReuseIdentifier:collectionCellPlusID];
        [_collectionView registerClass:[BAHCollectionViewCellWhite class] forCellWithReuseIdentifier:collectionCellWhiteID];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, kSelfFrame.width, kPageControlHeight)];
        _pageControl.center = CGPointMake(kSelfFrame.width / 2, kSelfFrame.height - kPageControlHeight/2);
        _pageControl.backgroundColor = RGBA(246, 246, 246, 1);

    }
    return _pageControl;
}

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame items:(NSMutableArray *)items actionBlock:(void(^)(NSString *title))actionBlock
{
    if (self = [super initWithFrame:frame])
    {
        self.imagesArray = items;
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
    }
    self.btnAction = actionBlock;
    return self;
}


#pragma mark - UICollectionViewDelegate, DataSource and UICollectionViewDelegateFlowLayout
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //一行放 4 个，一页共 8 个，算出排满的数值，算出分页个数
    _pageCounter = self.imagesArray.count+1;
    while (_pageCounter % 8 != 0) {
        ++_pageCounter;
    }
    _pageControl.numberOfPages = _pageCounter / 8;
    return _pageCounter;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BAHCollectionViewCell *cell = nil;
    
    if (indexPath.item > self.imagesArray.count)
    {   //空白的 cell
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellWhiteID forIndexPath:indexPath];
    }
    else if(indexPath.item == self.imagesArray.count)
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellPlusID forIndexPath:indexPath];
    }
    else
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
        cell.delegate = self;
        cell.indexPath = indexPath;
        cell.backgroundColor = [UIColor whiteColor];
        cell.imageView.image = [UIImage imageNamed:self.imagesArray[indexPath.row]];
    }
    
        
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 手指按下高亮
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor lightGrayColor]];
}
// 手指松开取消高亮
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor whiteColor]];
}

// 选择哪个 cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    if ([cell isKindOfClass:[BAHCollectionViewCell class]])
    {
//        NSLog(@"BAHCollectionViewCell");
        BAHCollectionViewCell *celltemp = cell;
        if (!celltemp.deleteButton.hidden) {
            celltemp.deleteButton.hidden = YES;
        }
    }
    else if ([cell isKindOfClass:[BAHCollectionViewCellPlus class]])
    {
        NSLog(@"BAHCollectionViewCellPlus");
        if (self.btnAction) {
            self.btnAction(@"BAHCollectionViewCellPlus");
        }
    }
    else
    {
        NSLog(@"white");
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / self.frame.size.width);
}

#pragma mark - BAHCollectionViewCellDelegate
- (void)longPressGestureCallback:(BAHCollectionViewCell *)selectedCell
{
    selectedCell.deleteButton.hidden = NO;
}

- (void)didSelectedDeleteButton:(BAHCollectionViewCell *)selectedCell atIndexPath:(NSIndexPath *)indexPath
{
    selectedCell.deleteButton.hidden = YES;
    [self.imagesArray removeObjectAtIndex:indexPath.row];
    [self.collectionView reloadData];
}



@end
