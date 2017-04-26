//
//  BAHCollectionViewCell.m
//  BAHCollectionView
//
//  Created by 乔贝斯 on 2017/4/11.
//  Copyright © 2017年 BAH. All rights reserved.
//

#import "BAHCollectionViewCell.h"

@implementation BAHCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

@end

@implementation BAHCollectionViewCellWhite

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
