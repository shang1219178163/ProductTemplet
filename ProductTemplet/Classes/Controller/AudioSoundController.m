
#import "AudioSoundController.h"

@implementation AudioSoundController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tbView];
    
    self.keys = [self.dic.allKeys sortedArrayUsingSelector:@selector(compare:)];
    [self.tbView reloadData];
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.keys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = self.keys[indexPath.row];
    NSString *value = self.dic[key];
    NSArray *itemList = [value componentsSeparatedByString:@".caf"];
	
    static NSString *identifier = @"identifier";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: identifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
//    }
    
    UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView identifier:identifier style:UITableViewCellStyleSubtitle];

    cell.textLabel.text = itemList.firstObject;
    cell.detailTextLabel.text = [itemList.lastObject deleteWhiteSpaceBeginEnd];

    return cell;
}
/**
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [keys objectAtIndex:section];
    return key;
}
*/
/*- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return keys;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *key = self.keys[indexPath.row];
    
    SystemSoundID soundID = [key intValue];
    AudioServicesPlaySystemSound(soundID);
}

#pragma mark - lazy

- (NSDictionary *)dic{
    if (!_dic) {
        _dic = ({
            NSString *path = [NSBundle.mainBundle pathForResource:@"sound" ofType:@"plist"];
            NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:path];
            dict;
        });
    }
    return _dic;
}


@end
