//
//  CityTableViewCell.h
//  AviaTickets
//
//  Created by Владислав Лихачев on 16.10.2020.
//  Copyright © 2020 Vladislav Likhachev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CityTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *abbrLabel;
@property (nonatomic, strong) UILabel *countryLabel;
@property (nonatomic, strong) UIImageView *weatherImageView;

@end

NS_ASSUME_NONNULL_END
