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
    
    NSArray *familyNames = [NSArray arrayWithArray:UIFont.familyNames];

    self.fontList = [NSMutableArray array];
    
    for (id familyName in familyNames) {
        NSLog(@"family: %@", familyName);
        NSMutableDictionary *family = [NSMutableDictionary dictionary];
        [family setObject:familyName forKey:@"name"];
        NSArray *fontNames = [NSArray arrayWithArray:[UIFont fontNamesForFamilyName:familyName]];
        NSMutableArray *fonts = [NSMutableArray arrayWithCapacity:[fontNames count]];
        for (id fontName in fontNames) {
            NSLog(@"name: %@", fontName);
            NSDictionary *font = [NSDictionary dictionaryWithObjectsAndKeys:fontName, @"name", [UIFont fontWithName:fontName size:14.0], @"font", nil];
            [fonts addObject:font];
        }
        
        [family setObject:fonts forKey:@"fonts"];
        
        [self.fontList addObject:family];
    }
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.fontList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    id fontDict = self.fontList[section];
    id font = fontDict[@"fonts"];
    return [font count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    id fontDict = self.fontList[section];
    return fontDict[@"name"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"FontCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    
    id fontDict = self.fontList[indexPath.section];
    id fonts = fontDict[@"fonts"];
    id font = fonts[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ 这是中文字体！English.", font[@"name"]];
    cell.textLabel.font = font[@"font"];
    
    return cell;
}


@end
