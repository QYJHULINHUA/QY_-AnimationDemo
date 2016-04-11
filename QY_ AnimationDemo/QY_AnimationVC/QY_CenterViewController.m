//
//  QY_CenterViewController.m
//  QY_ AnimationDemo
//
//  Created by ihefe－hulinhua on 16/4/8.
//  Copyright © 2016年 ihefe_hlh. All rights reserved.
//

#import "QY_CenterViewController.h"
#import "BIDPopAnimationView.h"



@interface QY_CenterViewController ()
@property (nonatomic , strong)NSArray *operateTitleArray;

@end

@implementation QY_CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:getQY_TopBarViewInstancetype(@"视图弹出")];
    [self initView];
    
    SWRevealViewController *revealVC = [self revealViewController];
    [revealVC panGestureRecognizer];
    [revealVC tapGestureRecognizer];
    
    
}



-(NSArray *)operateTitleArray{
    return [NSArray arrayWithObjects:@"弹出1",@"弹出2",@"弹出3",@"弹出4",@"弹出5",@"淡入淡出",@"展开1",@"展开2",@"展开3",@"展开4", nil];
}

-(void)initView{
    
    
    NSArray *operateArr = self.operateTitleArray;

    if(operateArr){
        NSUInteger row = operateArr.count%4==0 ? operateArr.count/4 : operateArr.count/4+1;
        UIView *operateView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-(row*50+20), SCREEN_WIDTH, row*50+20)];
        [self.view addSubview:operateView];
        for (int i=0; i<operateArr.count; i++) {
            QY_TitleButton *btn = [[QY_TitleButton alloc] initWithFrame:[self rectForBtnAtIndex:i totalNum:operateArr.count] withTitle:[operateArr objectAtIndex:i]];
            btn.tag = i;
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            [operateView addSubview:btn];
        }
    }
    //注册该页面可以执行滑动切换
    SWRevealViewController *revealController = self.revealViewController;
    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
}

-(CGRect)rectForBtnAtIndex : (NSUInteger)index totalNum : (NSUInteger)totleNum{
    //每一行最多显示4个
    NSUInteger maxColumnNum = 4;
    //每个按钮的列间距
    CGFloat columnMargin = 20;
    //每个按钮的行间距
    CGFloat rowMargin = 20;
    //行数
    // NSUInteger row = totleNum/maxColumnNum;
    //每个按钮的宽度
    CGFloat width = (SCREEN_WIDTH - columnMargin*5)/4;
    //每个按钮的高度
    CGFloat height = 30;
    
    //每个按钮的偏移
    CGFloat offsetX = columnMargin+(index%maxColumnNum)*(width+columnMargin);
    CGFloat offsetY = rowMargin+(index/maxColumnNum)*(height+rowMargin);
    
    return CGRectMake(offsetX, offsetY, width, height);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 请看这里，有惊喜！！！！
-(void)clickBtn : (UIButton *)btn{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    BIDPopStyle *pop = [[BIDPopStyle alloc] init];
    pop.animationType = btn.tag;
    
    [BIDPopAnimationView popAnimationView:view popStyle:pop];
}


- (void)dealloc
{
    NSLog(@"ceterVC ___dealloc");
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
