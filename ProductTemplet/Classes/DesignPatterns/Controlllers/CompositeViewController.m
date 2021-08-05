//
//  CompositeViewController.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/29.
//  Copyright © 2018年 BN. All rights reserved.
//

/*
 组合模式让我们可以把相同基类型的对象组合到树状结构中，其中父节点包含同类型的子节点。换句话说，这种树状结构形成"部分——整体"的层次结构。什么是“部分——整体”的层次结构呢？它是既包含对象的组合又包含叶节点的单个对象的一种层次结构。每个组合体包含的其他节点，可以是叶节点或者其他组合体。这种关系在这个层次结构中递归重复。因为每个组合或叶节点有相同的基类型，同样的操作可应用于它们中的每一个，而不必在客户端作类型检查。客户端对组合与叶节点进行操作时可忽略它们之间的差别。
 
 组合模式：将对象组合成树形结构以表示"部分——整体"的层次结构。组合使得用户对单个对象和组合对象的使用的具有一致性。
 
 */

#import "CompositeViewController.h"

#import "CompanyProtocol.h"
#import "CompanyComponent.h"
#import "CompanyLeaf.h"

@interface CompositeViewController ()

@end

@implementation CompositeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    CompanyComponent *root = [[CompanyComponent alloc] initWithCompanyName:@"嘟嘟牛科技有限公司"];
    // 添加一个叶子节点
    [root addCompany:[[CompanyLeaf alloc] initWithCompanyName:@"嘟嘟牛人力资源部"]];
    
    CompanyComponent *component = [[CompanyComponent alloc] initWithCompanyName:@"深圳视格有限公司(嘟嘟牛子公司)"];
    [component addCompany:[[CompanyLeaf alloc] initWithCompanyName:@"视格人力资源部"]];
    // 添加一个组合节点
    [root addCompany:component];
    
    NSLog(@"-----------------结构图----------------");
    [root display];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

