//
//  QY_LeftViewController.m
//  QY_ AnimationDemo
//
//  Created by ihefe－hulinhua on 16/4/8.
//  Copyright © 2016年 ihefe_hlh. All rights reserved.
//

#import "QY_LeftViewController.h"

@interface QY_LeftViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)NSArray     *menuArray;

@end

@implementation QY_LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:getQY_TopBarViewInstancetype(@"菜单")];
    [self initData];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    _menuArray = [NSArray arrayWithObjects:@"视图弹出",@"基础动画",@"关键帧动画",@"组动画",@"过渡动画",@"仿射变换",@"综合案例", nil];
}

-(void)initView{
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-60) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _menuArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *TABLE_VIEW_ID = @"table_view_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLE_VIEW_ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TABLE_VIEW_ID];
    }
    cell.textLabel.text = [_menuArray objectAtIndex:indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SWRevealViewController *revealViewController = self.revealViewController;
    UIViewController *viewController;
    
//    switch (indexPath.row) {
//        case 0:
//            viewController = [[BaseAnimationController alloc] init];
//            break;
//        case 1:
//            viewController = [[KeyFrameAnimationController alloc] init];
//            break;
//        case 2:
//            viewController = [[GroupAnimationController alloc] init];
//            break;
//        case 3:
//            viewController = [[TransitionAnimationController alloc] init];
//            break;
//        case 4:
//            viewController = [[AffineTransformController alloc] init];
//            break;
//        case 5:
//            viewController = [[ComprehensiveCaseController alloc] init];
//            break;
//        default:
//            break;
//    }
    //调用pushFrontViewController进行页面切换
    if (viewController) {
        [revealViewController pushFrontViewController:viewController animated:YES];
    }
    
    
}

- (void)dealloc
{
    NSLog(@"leftVC ___dealloc");
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
