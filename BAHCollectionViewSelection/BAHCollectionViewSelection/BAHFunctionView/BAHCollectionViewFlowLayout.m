//
//  BAHCollectionViewFlowLayout.m
//  BAHCollectionViewSelection
//
//  Created by 乔贝斯 on 2017/4/24.
//  Copyright © 2017年 BAH. All rights reserved.
//

#import "BAHCollectionViewFlowLayout.h"

@implementation BAHCollectionViewFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.rowsNumber = 2;
    self.itemsNumberPerRow = 4;
    self.allAttributes = [NSMutableArray array];
    
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSUInteger i = 0; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.allAttributes addObject:attributes];
    }
}

- (CGSize)collectionViewContentSize
{
    return [super collectionViewContentSize];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger item = indexPath.item;
    NSUInteger x;
    NSUInteger y;
    [self targetPositionWithItem:item resultX:&x resultY:&y];
    NSUInteger item2 = [self originItemAtX:x y:y];
    NSIndexPath *theNewIndexPath = [NSIndexPath indexPathForItem:item2 inSection:indexPath.section];
    
    UICollectionViewLayoutAttributes *theNewAttr = [super layoutAttributesForItemAtIndexPath:theNewIndexPath];
    theNewAttr.indexPath = indexPath;
    return theNewAttr;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray *tmp = [NSMutableArray array];
    
    for (UICollectionViewLayoutAttributes *attr in attributes) {
        for (UICollectionViewLayoutAttributes *attr2 in self.allAttributes) {
            if (attr.indexPath.item == attr2.indexPath.item) {
                [tmp addObject:attr2];
                break;
            }
        }
    }
    return tmp;
}


// 根据 item 计算目标item的位置
// x 横向偏移  y 竖向偏移
- (void)targetPositionWithItem:(NSUInteger)item
                       resultX:(NSUInteger *)x
                       resultY:(NSUInteger *)y
{
    NSUInteger page = item/(self.itemsNumberPerRow * self.rowsNumber);
    
    NSUInteger theX = item % self.itemsNumberPerRow + page * self.itemsNumberPerRow;
    NSUInteger theY = item / self.itemsNumberPerRow - page * self.rowsNumber;
    if (x != NULL) {
        *x = theX;
    }
    if (y != NULL) {
        *y = theY;
    }
}

// 根据偏移量计算item
- (NSUInteger)originItemAtX:(NSUInteger)x
                          y:(NSUInteger)y
{
    NSUInteger item = x * self.rowsNumber + y;
    return item;
}


@end
