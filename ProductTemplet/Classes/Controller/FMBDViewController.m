//
//  BDLearnController.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/21.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "FMBDViewController.h"

#import "DBManager.h"

#import "Person.h"
#import "Car.h"

#import "PersonCarsViewController.h"

#import "DBHandler.h"

#import "Student.h"
#import "Teacher.h"
#import "Lesson.h"

#import <NNGloble/NNGloble.h>
#import "NSObject+Helper.h"
#import "UIViewController+Helper.h"

@interface FMBDViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation FMBDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIBarButtonItem *itemBack = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(handleActionBack)];
    UIBarButtonItem *itemCars = [[UIBarButtonItem alloc] initWithTitle:@"车库" style:UIBarButtonItemStylePlain target:self action:@selector(watchCars)];
    self.navigationItem.leftBarButtonItems = @[itemBack, itemCars];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addData)];

    self.tbView.frame = self.view.bounds;
    self.tbView.dataSource = self;
    self.tbView.delegate = self;
    [self.view addSubview:self.tbView];
    
    
    
    NSMutableArray * marry = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i++) {
        Teacher * teacher = [[Teacher alloc]init];
        teacher.FLDBID = [NSString stringWithFormat:@"teacher_%zd",i];

        teacher.name = [@"tea_name_" stringByAppendingFormat:@"%@",@(i)];
        teacher.age = RandomInteger(20, 50);
        
        Student * stu = [Student new];
        stu.FLDBID = [NSString stringWithFormat:@"stu_%zd",i];

        stu.name = @"stu_Li";
        stu.age = RandomInteger(15, 20);
//
//        NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
//        for (NSInteger j = 0; j < 3 ; j++) {
//            Lesson * les = [Lesson new];
//            les.lessonID = [NSString getRandomStr:1000 to:1050];
//            les.lessonID = [@(RandomInteger(1000, 1050)) stringValue];
//            les.name = [@"les_name_" stringByAppendingFormat:@"%@",@(j)];
//            [marr addObject:les];
//        }
//        stu.lessonList = marr;
//        teacher.student = stu;
        [marry addObject:teacher];
      
        [[DBHandler shareManager] fl_insertModel:marry complete:^(DBHandler *manager, BOOL flag) {
            DDLog(@"%@",@(flag));
            
        }];
    }
    
    
}

- (void)handleActionBack{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    self.dataArray = [[DBManager shared] getAllPerson];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    Person *person = self.dataArray[indexPath.row];
    if (person.number == 0) {
        cell.textLabel.text = person.name;
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@(第%ld次更新)",person.name,person.number];
    }
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"age: %ld",person.age];
    return cell;
    
}

/**
 *  设置删除按钮
 *
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        Person *person = self.dataArray[indexPath.row];
        
        [[DBManager shared] deletePerson:person];
        [[DBManager shared] deleteAllCarsFromPerson:person];
        self.dataArray = [[DBManager shared] getAllPerson];
        
        [self.tbView reloadData];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonCarsViewController *controller = [[PersonCarsViewController alloc] init];
    controller.person = self.dataArray[indexPath.row];
    
//    [self.navigationController pushViewController:controller animated:YES];
    
        Person *person = self.dataArray[indexPath.row];
    
        person.name = [NSString stringWithFormat:@"%@",person.name];
    
        person.age = arc4random_uniform(100) + 1;
        [[DBManager shared] updatePerson:person];
    
        self.dataArray = [[DBManager shared] getAllPerson];
    
        [tableView reloadData];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UILabel new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UILabel new];

}


#pragma mark - Action
/**
 *  添加数据到数据库
 */
- (void)addData{
    
    NSLog(@"addData");
    
    int nameRandom = arc4random_uniform(1000);
    NSInteger ageRandom  = arc4random_uniform(100) + 1;
    
    
    NSString *name = [NSString stringWithFormat:@"person_%d号",nameRandom];
    NSInteger age = ageRandom;
    
    Person *person = [[Person alloc] init];
    person.name = name;
    person.age = age;
    
    
    [[DBManager shared] addPerson:person];
    self.dataArray = [[DBManager shared] getAllPerson];
    
    [self.tbView reloadData];
    
}
- (void)watchCars{
    [self goController:@"CarViewController" title:@"carList"];

}

#pragma mark - Getter
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        
    }
    return _dataArray;
    
}

@end
