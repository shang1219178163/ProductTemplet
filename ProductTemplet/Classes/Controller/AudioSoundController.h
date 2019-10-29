

#import <UIKit/UIKit.h>

@interface AudioSoundController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) NSArray *keys;

@end
