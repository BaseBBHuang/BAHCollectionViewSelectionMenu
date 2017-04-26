//
//  BAHCollectionViewCell.h
//  BAHCollectionView
//
//  Created by 乔贝斯 on 2017/4/11.
//  Copyright © 2017年 BAH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BAHCollectionViewCell;

@protocol BAHCollectionViewCellDelegate <NSObject>

- (void)longPressGestureCallback:(BAHCollectionViewCell *)selectedCell;
- (void)didSelectedDeleteButton:(BAHCollectionViewCell *)selectedCell atIndexPath:(NSIndexPath *)indexPath;

@end

@interface BAHCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) id<BAHCollectionViewCellDelegate> delegate;
@end


@interface BAHCollectionViewCellWhite : BAHCollectionViewCell

@end
