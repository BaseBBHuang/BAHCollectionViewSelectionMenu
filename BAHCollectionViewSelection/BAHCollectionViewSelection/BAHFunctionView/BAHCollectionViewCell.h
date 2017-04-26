//
//  BAHCollectionViewCell.h
//  BAHCollectionView
//
//  Created by 乔贝斯 on 2017/4/11.
//  Copyright © 2017年 BAH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAHCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end


@interface BAHCollectionViewCellWhite : BAHCollectionViewCell

@end
