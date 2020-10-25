//
//  TicketsViewController.h
//  AviaTickets
//
//  Created by Владислав Лихачев on 25.10.2020.
//  Copyright © 2020 Vladislav Likhachev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketTableViewCell.h"

#define TicketCellReuseIdentifier @"TicketCellIdentifier"

NS_ASSUME_NONNULL_BEGIN

@interface TicketsViewController : UITableViewController

- (instancetype)initWithTickets:(NSArray *)tickets;

@end


NS_ASSUME_NONNULL_END
