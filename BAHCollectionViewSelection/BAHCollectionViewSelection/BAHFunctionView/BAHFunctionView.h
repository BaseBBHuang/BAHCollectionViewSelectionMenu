//
//  BAHFunctionView.h
//  BAHCollectionViewSelection
//
//  Created by 乔贝斯 on 2017/4/21.
//  Copyright © 2017年 BAH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAHFunctionView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;


- (instancetype)initWithFrame:(CGRect)frame items:(NSMutableArray *)items actionBlock:(void(^)(NSString *title))actionBlock;


@end
