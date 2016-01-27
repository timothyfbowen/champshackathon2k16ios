//
//  BRGrapeAPIClient.m
//  beRecruitediOS
//
//  Created by Timothy F. Bowen on 4/30/15.
//  Copyright (c) 2015 BeRecruited.com. All rights reserved.
//

#import "BRGrapeAPIClient.h"
#import "BRHTTPClient.h"

@implementation BRGrapeAPIClient

+ (BRGrapeAPIClient *)sharedClient {
    static BRGrapeAPIClient *sharedClient = nil;
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyNever];
    if(sharedClient == nil) {
        NSString *urlString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"BRBaseGrapeURL"];
        sharedClient = [[BRGrapeAPIClient alloc] initWithBaseURL:[NSURL URLWithString:urlString]];
        AFJSONRequestSerializer *requestSerializer = [[AFJSONRequestSerializer alloc] init];
        [requestSerializer setAuthorizationHeaderFieldWithUsername:@"beRecruited" password:@"r3cru1t"];
        [requestSerializer setValue:@"topbunsameangle" forHTTPHeaderField:@"secret"];
        [requestSerializer setValue:[[BRHTTPClient sharedClient] authToken] forHTTPHeaderField:@"auth_token"];
        sharedClient.requestSerializer = requestSerializer;
        sharedClient.responseSerializer =[[AFJSONResponseSerializer alloc] init];
        /*
         //TODO: authenticate lol
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"auth_token"]) {
            [sharedClient setAuthToken:[[NSUserDefaults standardUserDefaults] objectForKey:@"auth_token"]];
        }
         */
    }
    
    return sharedClient;
}

@end
