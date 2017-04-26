//
//  BAHMoreViewController.h
//  BAHCollectionViewSelection
//
//  Created by 乔贝斯 on 2017/4/24.
//  Copyright © 2017年 BAH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BAHMoreViewControllerDelegate <NSObject>

- (void)didSelectedFuctionViewCell:(NSString *)menueString;

@end

@interface BAHMoreViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *imagesArray;

@property (nonatomic, weak) id<BAHMoreViewControllerDelegate> delegate;
@end
