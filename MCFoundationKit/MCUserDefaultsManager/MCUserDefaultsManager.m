//
//  MCUserDefaultsManager.m
//  MCFoundationKit
//
//  Created by wang maocai on 2020/4/10.
//  Copyright © 2020 mc. All rights reserved.
//

#import "MCUserDefaultsManager.h"
#import "MCCommonDefine.h"

@implementation MCUserDefaultsManager

+ (void)setData:(id)data forKey:(NSString *)key
{
    if (data) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        id lData = data;
        if (lData != nil) {
            [userDefaults setObject:lData forKey:key];
            [userDefaults synchronize];
        }
    }
}

+ (id)getDataForKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    id lData = [userDefaults objectForKey:key];
    id lObject = lData;
    return lObject;
}

+ (void)removeDataForKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
    [userDefaults synchronize];
}

+ (void)clearAllData
{
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:kBundleIdentifier];
}

@end
