//
//  NTESSessionConfig.m
//  DemoApplication
//
//  Created by chris on 15/11/1.
//  Copyright © 2015年 chris. All rights reserved.
//

#import "NTESSessionConfig.h"
#import "NIMMediaItem.h"
#import "NTESCellLayoutConfig.h"

@implementation NTESSessionConfig

- (NSArray *)mediaItems{
    NSArray *defaultMediaItems = [NIMKit sharedKit].config.defaultMediaItems;
    
    
    
    return defaultMediaItems;

}

- (BOOL)disableCharlet
{
    return YES;
}


@end
