//
//  FontListController.m
//  ProductTemplet
//
//  Created by dev on 2018/12/10.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "FontListController.h"

@interface FontListController ()

@property (strong, nonatomic) NSMutableArray *fontList;

@end

@implementation FontListController

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.fontList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *fontDict = self.fontList[section];
    NSArray *fonts = fontDict[@"fonts"];
    return fonts.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    id fontDict = self.fontList[section];
    return fontDict[@"name"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"FontCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    
    NSDictionary *fontDict = self.fontList[indexPath.section];
    NSArray *fonts = fontDict[@"fonts"];
    id font = fonts[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ 中文效果！English.", font[@"name"]];
    cell.textLabel.font = font[@"font"];
    
    return cell;
}

#pragma mark -- layz
-(NSMutableArray *)fontList{
    if (!_fontList) {
        _fontList = [NSMutableArray array];
        
        for (id familyName in UIFont.familyNames) {
            NSLog(@"family: %@", familyName);
            NSMutableDictionary *family = [NSMutableDictionary dictionary];
            [family setObject:familyName forKey:@"name"];
            NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
            NSMutableArray *fonts = [NSMutableArray array];
            for (id fontName in fontNames) {
                NSLog(@"name: %@", fontName);
                NSDictionary *font = @{
                                       @"name"    :   fontName,
                                       @"font"    :   [UIFont fontWithName:fontName size:17.0],
                                       
                                       };
                
                [fonts addObject:font];
            }
            [family setObject:fonts forKey:@"fonts"];
            
            [_fontList addObject:family];
        }
    }
    return _fontList;
}

@end
