//
//  SyncModel.h
//  OwnServer
//
//  Created by Joey Serquina on 5/16/14.
//  Copyright (c) 2014 sample. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SyncModelProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *)items;

@end

@interface SyncModel : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic,weak)id<SyncModelProtocol> delegate;

-(void)downloadItems;
@end



