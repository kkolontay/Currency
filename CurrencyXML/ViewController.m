//
//  ViewController.m
//  CurrencyXML
//
//  Created by kkolontay on 7/24/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

#import "ViewController.h"
#import "RestRequest.h"
#import "UIViewController+ErrorsShower.h"
#import "ParserXML.h"
#import "DBCoreData.h"
#import "CustomTableViewCell.h"

@interface ViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *currencyTable;

@end

@implementation ViewController

ParserXML *parser;

- (void)viewDidLoad {
  [super viewDidLoad];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataTable:) name:@"DataReceivedDataReload" object:nil];
  }

- (void) reloadDataTable:(NSNotification *) notification {
  [_currencyTable reloadData];
  _titleLabel.text = [[DBCoreData sharedInstance] fetchNameOfBank];
}

- (void) viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self renewData];
 }

- (IBAction)reloadDataButtonPressed:(id)sender {
  [self renewData];
 }

- (void) viewWillDisappear:(BOOL)animated {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [super viewWillDisappear:animated];
}

- (void) renewData {
  __weak typeof (self) weakSelf = self;
  [[RestRequest sharedInstance] fetchData:^(NSData *data, NSString *error) {
    if (error != nil) {
      [weakSelf showError:error];
      return;
    }
    if (data != nil) {
      parser = [[ParserXML alloc] initWithData:data];
      [parser parsing];
    }
  }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[DBCoreData sharedInstance] getCountData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
  NSDictionary *dictionary = [[DBCoreData sharedInstance] fetchObject:indexPath.row];
  [cell setData:dictionary];
  return cell;
}

@end
