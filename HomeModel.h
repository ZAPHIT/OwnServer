//
//  HomeModel.h
//  OwnServer
//
//  Created by Joey Serquina on 4/22/14.
//  Copyright (c) 2014 sample. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HomeModelProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *)items;

@end


@interface HomeModel : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic,weak)id<HomeModelProtocol> delegate;

-(void)downloadItems;

@end
