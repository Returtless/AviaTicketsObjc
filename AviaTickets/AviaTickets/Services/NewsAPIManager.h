//
//  NewsAPIObject.h
//  AviaTickets
//
//  Created by Владислав Лихачев on 19.10.2020.
//  Copyright © 2020 Vladislav Likhachev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsArray.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsAPIManager : NSObject

+ (instancetype)sharedInstance;
- (void)getNews:(void (^)(NSArray *news))completion;

@end

NS_ASSUME_NONNULL_END
