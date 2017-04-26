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
    [self addLongPressGesture];
    
}

- (void)addLongPressGesture
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureClick:)];
    [self addGestureRecognizer:longPress];
}

- (void)longPressGestureClick:(id)sender
{
    NSLog(@"longPressGestureClick");
    if ([self.delegate respondsToSelector:@selector(longPressGestureCallback:)]) {
        [self.delegate longPressGestureCallback:self];
    }
}


- (IBAction)deleteClick:(id)sender {
    NSLog(@"delete");
    if ([self.delegate respondsToSelector:@selector(didSelectedDeleteButton:atIndexPath:)]) {
        [self.delegate didSelectedDeleteButton:self atIndexPath:_indexPath];
    }
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
