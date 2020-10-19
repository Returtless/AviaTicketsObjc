//
//  NewsArray.m
//  AviaTickets
//
//  Created by Владислав Лихачев on 19.10.2020.
//  Copyright © 2020 Vladislav Likhachev. All rights reserved.
//

#import "NewsArray.h"

@implementation NewsArray


@end

@implementation NewsArticle
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _source = [dictionary valueForKey:@"source"];
        _author = [dictionary valueForKey:@"author"];
        _urlToImage = [dictionary valueForKey:@"urlToImage"];
        _content = [dictionary valueForKey:@"content"];
        _title = [dictionary valueForKey:@"title"];
        _publishedAt = [dictionary valueForKey:@"publishedAt"];
        _theDescription= [dictionary valueForKey:@"description"];
        _url = [dictionary valueForKey:@"url"];
    }
    return self;
}
@end

@implementation NewsSource
@end
