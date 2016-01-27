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
    }
    
    return sharedClient;
}

@end
