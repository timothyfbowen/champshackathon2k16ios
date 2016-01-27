//
//  BRGrapeAPIClient.m
//  beRecruitediOS
//
//  Created by Timothy F. Bowen on 4/30/15.
//  Copyright (c) 2015 BeRecruited.com. All rights reserved.
//

#import "HTTPClient.h"

@implementation HTTPClient

+ (HTTPClient *)sharedClient {
    static HTTPClient *sharedClient = nil;
    //[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyNever];
    if(sharedClient == nil) {
        NSString *urlString = @"http://qa.ncsasports.org:80";
        sharedClient = [[HTTPClient alloc] initWithBaseURL:[NSURL URLWithString:urlString]];
        AFJSONRequestSerializer *requestSerializer = [[AFJSONRequestSerializer alloc] init];
        //[requestSerializer setAuthorizationHeaderFieldWithUsername:@"Api-Key" password:@"r3cru1t"];
        [requestSerializer setValue:@"ncsasports" forHTTPHeaderField:@"Api-Key"];
        //[requestSerializer setValue:[[BRHTTPClient sharedClient] authToken] forHTTPHeaderField:@"auth_token"];
        sharedClient.requestSerializer = requestSerializer;
        sharedClient.responseSerializer =[[AFJSONResponseSerializer alloc] init];
        NSString *auth = [[NSUserDefaults standardUserDefaults] objectForKey:@"auth-token"];
        if(auth) {
            [sharedClient setAuthToken:auth];
        }
    }
    return sharedClient;
}

- (NSDictionary *)paramDictForParams:(NSDictionary *)params {
    if(!self.authToken) return params;
    if(!params) params = [[NSDictionary alloc] init];
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] initWithDictionary:params];
    [paramDict setObject:self.authToken forKey:@"auth-token"];
    NSLog(@"%@", paramDict);
    return paramDict;
}

- (void)setAuthToken:(NSString *)authToken {
    _authToken = authToken;
    if(authToken) {
        [[NSUserDefaults standardUserDefaults] setObject:authToken forKey:@"auth-token"];
    }
}

@end
