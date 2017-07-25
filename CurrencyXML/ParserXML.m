//
//  ParserXML.m
//  CurrencyXML
//
//  Created by kkolontay on 7/24/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

#import "ParserXML.h"
#import "DBCoreData.h"

@implementation ParserXML

NSData *parsingData;
NSString *nameOfBank = @"no name";
NSXMLParser *parserMarker;
NSString *currentValue;
NSString *currentDate;
NSMutableArray *currency;

- (id) initWithData: (NSData *) data {
  self = [super init];
  if (self != nil) {
    parsingData = data;
    currency = [[NSMutableArray alloc] init];
  }
  return self;
}

- (NSString *) getNameOfBank {
  return nameOfBank;
}

- (NSString *) getDate {
  return currentDate;
}

- (void) parsing {
  parserMarker = [[NSXMLParser alloc] initWithData: parsingData];
  [parserMarker setDelegate: self];
  [parserMarker parse];
}

- (void) parserDidStartDocument:(NSXMLParser *)parser {
  NSLog(@"parserDidStartDocument");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
  if ([elementName isEqualToString:@"Cube"]) {
    if ([attributeDict objectForKey:@"time"] != nil) {
      currentDate = [attributeDict objectForKey:@"time"];
    }
    if ([attributeDict objectForKey:@"currency"] != nil && [attributeDict objectForKey:@"rate"] != nil) {
      NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
      [dictionary setObject:[attributeDict objectForKey:@"currency"] forKey:@"currency"];
      [dictionary setObject:[attributeDict objectForKey:@"rate"] forKey:@"rate"];
      [currency addObject:dictionary];
    }
  }
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
  currentValue = string;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
  if ([elementName isEqualToString: @"gesmes:name"]) {
    nameOfBank = currentValue;
  }
}

- (void) parserDidEndDocument:(NSXMLParser *)parser {
  [[DBCoreData sharedInstance] setData:currency bankName: nameOfBank date: currentDate];
}

@end
