//
//  CustomTableViewCell.m
//  CurrencyXML
//
//  Created by kkolontay on 7/25/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

- (void) setData:(NSDictionary *)dictionary {
  _objectOne.text = [dictionary objectForKey:@"objectone"];
  _objectTwo.text = [dictionary objectForKey:@"objecttwo"];
}

@end
