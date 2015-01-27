//
//  CommonTools.h
//  iChangi Jbeacon
//
//  Created by Massive on 27/12/14.
//  Copyright (c) 2014 Massive Infinity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonTools : NSObject
+ (NSData *)toJSONData:(id)theData;

+ (id)toArrayOrNSDictionary:(NSData *)jsonData;
@end
