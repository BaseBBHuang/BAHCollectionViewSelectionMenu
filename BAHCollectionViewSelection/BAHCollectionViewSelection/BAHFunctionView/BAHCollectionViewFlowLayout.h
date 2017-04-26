//
//  BAHCollectionViewFlowLayout.h
//  BAHCollectionViewSelection
//
//  Created by 乔贝斯 on 2017/4/24.
//  Copyright © 2017年 BAH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAHCollectionViewFlowLayout : UICollectionViewFlowLayout
/**
 每一行多少 item
 */
@property (nonatomic, assign) NSUInteger itemsNumberPerRow;
/**
 多少行
 */
@property (nonatomic, assign) NSUInteger rowsNumber;
/**
 Layout 的属性
 */
@property (nonatomic, strong) NSMutableArray *allAttributes;

@end
