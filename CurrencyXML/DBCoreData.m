//
//  DBCoreData.m
//  CurrencyXML
//
//  Created by kkolontay on 7/24/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

#import "DBCoreData.h"

@implementation DBCoreData
NSArray *currencyData;
NSMutableArray *arrayForShowing;
NSString *presentedDate;
NSString *nameOfBankCurrent;

+ (id) sharedInstance {
  static DBCoreData *instance = nil;
  static dispatch_once_t onceTokin;
  dispatch_once(&onceTokin, ^{
    instance = [[DBCoreData alloc] init];
  });
  return instance;
}

- (void) setData:(NSMutableArray *)array bankName: (NSString *) bank date: (NSString *) date {
  arrayForShowing = [[NSMutableArray alloc] init];
  currencyData = [[NSArray alloc] initWithArray:array];
  nameOfBankCurrent = bank;
  presentedDate = date;
  [self prepareData];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"DataReceivedDataReload" object:nil];
}

- (void) prepareData {
  for (int i = 0; i < currencyData.count; i += 2) {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    NSString *formattedStringObjectOne = [self getCurrentData: [currencyData objectAtIndex:i]];
    [dictionary setObject:formattedStringObjectOne forKey: @"objectone"];
    NSString *formattedStirngObjectTwo = nil;
    if (i + 1 < currencyData.count) {
      formattedStirngObjectTwo = [self getCurrentData: [currencyData objectAtIndex:i + 1]];
      [dictionary setObject: formattedStirngObjectTwo forKey: @"objecttwo"];
    }
    [arrayForShowing addObject:dictionary];
  }
}

- (long) getCountData {
  return arrayForShowing.count;
}

- (NSString *) fetchNameOfBank {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd"];
  NSDate *date = [formatter dateFromString:presentedDate];
  [formatter setDateFormat:@"E, d MMM yyyy"];
  NSString *newFormat = [formatter stringFromDate: date];
  return [NSString stringWithFormat:@"%@ - %@", nameOfBankCurrent, newFormat];
}

- (NSDictionary*) fetchObject: (long) index {
  return [arrayForShowing objectAtIndex:index];
}

- (NSString *) getCurrentData: (NSMutableDictionary *) dictionary {
  NSString *currency = [dictionary objectForKey: @"currency"];
  NSString *value = [dictionary objectForKey: @"rate"];
  return [self getStringCurrency: currency value: value];
  
}

- (NSString *) getStringCurrency: (NSString *) currency value: (NSString *) value {
    return [NSString stringWithFormat:@"%@ - %@", currency, value];
}

@end
