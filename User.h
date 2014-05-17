//
//  User.h
//  OwnServer
//
//  Created by Joey Serquina on 5/15/14.
//  Copyright (c) 2014 sample. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject


@property (nonatomic, strong) NSString *firstname;
@property (nonatomic, strong) NSString *lastname;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *emailAddress;
@property (nonatomic, strong) NSString *password;


@end
