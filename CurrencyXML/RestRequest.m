//
//  RestRequest.m
//  CurrencyXML
//
//  Created by kkolontay on 7/24/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

#import "RestRequest.h"

@implementation RestRequest

  NSString *const htmlAddress = @"http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml";

+ (id) sharedInstance {
  static RestRequest *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[RestRequest alloc] init];
  });
  return instance;
}

- (void) fetchData:  (FetcherDataFromServer) fetchData {
  NSURL *url = [NSURL URLWithString:htmlAddress];
  NSURLSessionTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    if (error != nil) {
      dispatch_async(dispatch_get_main_queue(), ^{
        fetchData(nil, error.localizedDescription);
      });
      return;
    }
    if (httpResponse.statusCode < 200 || httpResponse.statusCode > 300) {
      NSString *error = [[NSString alloc] initWithFormat: @"Connection error with code %ld", (long) httpResponse.statusCode];
      dispatch_async(dispatch_get_main_queue(), ^{
        fetchData(nil, error);
      });
      return;
      }
    dispatch_async(dispatch_get_main_queue(), ^{
      fetchData(data, nil);
    });
  }];
  [downloadTask resume];
}

@end
