//
//  InstanceId.m
//  instanceId
//
//  Created by Tim De Lange on 2019/06/03.
//  Copyright © 2019 Tim De Lange. All rights reserved.
//

#import "InstanceId.h"

@implementation InstanceId
static NSString *lastId = nil;

+(NSString *)uuid
{
    //also known as uuid/universallyUniqueIdentifier
    
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    
    NSString *uuidValue = (__bridge_transfer NSString *)uuidStringRef;
    uuidValue = [uuidValue lowercaseString];
    uuidValue = [uuidValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return uuidValue;
}

+(NSString *) getId
{
    
    if (lastId != nil) {
        return lastId;
    }
    
    lastId = [InstanceId getIdFromStorage];
    
    if (lastId != nil) {
        return lastId;
    }
    
    lastId = [InstanceId uuid];
    
    if (lastId != nil) {
        [InstanceId saveIdToStorage:lastId];
    }
    
    return lastId;
}

+(NSString *) getIdFromStorage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *theId = [defaults stringForKey:@"MVDX_INSTANCE_002"];
    return theId;
}

+(void) saveIdToStorage:(NSString *)theId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:theId forKey:@"MVDX_INSTANCE_002"];
    [defaults synchronize];
}

@end
