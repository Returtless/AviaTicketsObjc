//
//  TicketTableViewCell.h
//  AviaTickets
//
//  Created by Владислав Лихачев on 25.10.2020.
//  Copyright © 2020 Vladislav Likhachev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "APIManager.h"
#import "Ticket.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketTableViewCell : UITableViewCell

@property (nonatomic, strong) Ticket *ticket;

@end


NS_ASSUME_NONNULL_END
