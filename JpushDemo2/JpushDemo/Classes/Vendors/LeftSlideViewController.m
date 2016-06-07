//
//  LeftSlideViewController.m
//  JpushDemo
//
//  Created by 王树超 on 16/5/11.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "LeftSlideViewController.h"

@interface LeftSlideViewController ()<UIGestureRecognizerDelegate>{
    CGFloat _scalef;  //实时横向位移
}
@property (nonatomic,strong) UITableView * leftTableView;
//蒙版
@property (nonatomic,strong) UIView * contentView;
@property (nonatomic,assign) CGFloat leftTableViewW;

@end

@implementation LeftSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 初始化左视图和右视图
- (instancetype)initWithLeftView:(UIViewController *)leftVC
                     andMainView:(UIViewController *)mainVC{
    self = [super init];
    if (self) {
        self.speedf = 0.7;
        self.leftVC = leftVC;
        self.mainVC = mainVC;
        
        // 滑动手势
        self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureAction:)];
        [self.mainVC.view addGestureRecognizer:self.pan];
        
        [self.pan setCancelsTouchesInView:YES];
        self.pan.delegate = self;
#warning 控制轻拍是否关闭 可以搜索self.sideslipTapGes.enabled 来设置
        //轻拍手势
        self.sideslipTapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
        [self.mainVC.view addGestureRecognizer:self.sideslipTapGes];
        self.sideslipTapGes.enabled = NO;
        
        
#warning 干嘛的啊
        self.leftVC.view.hidden = YES;
        self.leftVC.view.center = CGPointMake(-WIDTH*0.5 +80 , HEIGHT * 0.5);
        [self.view addSubview:self.leftVC.view];
        
        // 蒙版
        UIView * view = [[UIView alloc]initWithFrame:self.leftVC.view.bounds];
#warning 
#pragma mark 这里设置了蒙版颜色微透明的 所以蒙版不显示了
        view.backgroundColor = [UIColor clearColor];
        self.contentView = view;
        [self.leftVC.view addSubview:self.contentView];
        
        // 获取左侧TableView
        for (UIView * obj in self.leftVC.view.subviews) {
            if ([obj isKindOfClass:[UITableView class]]) {
                self.leftTableView = (UITableView *)obj;
            }
        }
        self.leftTableView.backgroundView.backgroundColor =[UIColor blackColor];
        self.leftTableView.backgroundColor = [UIColor clearColor];
        self.leftTableView.frame = CGRectMake(0, 0, WIDTH - 100, HEIGHT);
        
        [self.view addSubview:self.mainVC.view];
        self.closed = YES;//初始时侧滑窗关闭
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
#warning 干嘛的啊
    self.leftVC.view.hidden = NO;
}

// 关闭左视图
- (void)closeLeftView{
    self.sideslipTapGes.enabled = NO;
    [UIView beginAnimations:nil context:nil];
    
    self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.mainVC.view.center = CGPointMake(WIDTH / 2, HEIGHT / 2);
    self.closed = YES;
    
    //王树超修改
    self.leftVC.view.center = CGPointMake(-(WIDTH*0.5) + 80, HEIGHT * 0.5);
//    self.leftTableView.center = CGPointMake(30, HEIGHT * 0.5);
//    self.leftTableView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
    self.contentView.alpha = kLeftAlpha;
    
    [UIView commitAnimations];
}


// 打开左视图
- (void)openLeftView{
    self.sideslipTapGes.enabled = YES;
    [UIView beginAnimations:nil context:nil];
    self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
    self.mainVC.view.center = kMainPageCenter;
    self.closed = NO;
#warning 如果左侧控件不复杂可以用这个来调整tableView的位置
    //控制左侧tableview的位置
    
    self.leftVC.view.center = CGPointMake(WIDTH *0.5, HEIGHT *0.5);
//    
//    self.leftTableView.center = CGPointMake((WIDTH - 100) * 0.5, HEIGHT * 0.5);
//#warning 控制左侧table的大小变化
//    self.leftTableView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.contentView.alpha = 0;
    
    [UIView commitAnimations];
    // [self disableTapButton];
}


/**
 *  设置滑动开关是否开启
 *
 *  @param enabled YES:支持滑动手势，NO:不支持滑动手势
 */
- (void)setPanEnabled: (BOOL) enabled{
    
    [self.pan setEnabled:enabled];
    
}

#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    
    if ((!self.closed) && (tap.state == UIGestureRecognizerStateEnded))
    {
        
        
        self.sideslipTapGes.enabled = NO;
        
        
        [UIView beginAnimations:nil context:nil];
        tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        tap.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
        self.closed = YES;
        
        self.leftVC.view.center = CGPointMake(-(WIDTH*0.5) + 80, HEIGHT * 0.5);

//        
//        self.leftTableView.center = CGPointMake(30, HEIGHT * 0.5);
//        self.leftTableView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.7,0.7);
        
        self.contentView.alpha = kLeftAlpha;
        
        [UIView commitAnimations];
        _scalef = 0;
        // [self removeSingleTap];
    }
    
}

// 手势触发事件
- (void)panGestureAction:(UIPanGestureRecognizer *)panAction{
#warning  这里的point指的是从触摸屏幕开发后移动的位置
    CGPoint point = [panAction translationInView:self.view];
   
    
    _scalef = (point.x * self.speedf + _scalef);
    
    BOOL needMoveWithTap = YES; // 是否跟随手势移动
    if (((self.mainVC.view.frame.origin.x <= 0) && (_scalef <= 0)) || ((self.mainVC.view.frame.origin.x >= (WIDTH - 100 )) && (_scalef >= 0))) {
        //
        _scalef = 0;
        needMoveWithTap = NO;
    }
    
    // 根据视图位置判断是左滑还是右滑
    if (needMoveWithTap && (panAction.view.frame.origin.x >= 0) && (panAction.view.frame.origin.x <= (WIDTH - 100))) {
        CGFloat panCenterX = panAction.view.center.x + point.x * self.speedf;
        if (panCenterX < WIDTH * 0.5 - 2) {
            panCenterX = WIDTH * 0.5;
        }
        CGFloat panCenterY = panAction.view.center.y;
        panAction.view.center = CGPointMake(panCenterX, panCenterY);
        
        // scale
        CGFloat scale = 1;
        panAction.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
        [panAction setTranslation:CGPointMake(0, 0) inView:self.view];
        //王树超
        CGFloat leftCenterX = _leftVC.view.center.x + point.x * self.speedf;
        self.leftVC.view.center = CGPointMake(leftCenterX,HEIGHT * 0.5);
        
        
//        CGFloat leftTabCenterX = 30 + ((WIDTH - 100) * 0.5 - 30) * (panAction.view.frame.origin.x / (WIDTH - 100));
//        NSLog(@"%f",leftTabCenterX);
//        
//        // leftScale
//        CGFloat leftScale = 0.7 + (1 - 0.7) * (panAction.view.frame.origin.x / (WIDTH - 100));
//        
//        self.leftTableView.center = CGPointMake(leftTabCenterX, HEIGHT * 0.5);
//        self.leftTableView.transform = CGAffineTransformScale(CGAffineTransformIdentity, leftScale,leftScale);
        
        
        
        
        //tempAlpha kLeftAlpha~0
        CGFloat tempAlpha = kLeftAlpha - kLeftAlpha * (panAction.view.frame.origin.x / (WIDTH - 100));
        self.contentView.alpha = tempAlpha;
        
    }else{
        //超出范围，
        if (self.mainVC.view.frame.origin.x < 0){
            [self closeLeftView];
            _scalef = 0;
        }
        else if (self.mainVC.view.frame.origin.x > (WIDTH - 100)){
            [self openLeftView];
            _scalef = 0;
        }
    }
    //手势结束后修正位置,超过约一半时向多出的一半偏移
    if (panAction.state == UIGestureRecognizerStateEnded) {
        if (fabs(_scalef) > vCouldChangeDeckStateDistance)
        {
            if (self.closed)
            {
                [self openLeftView];
            }
            else
            {
                [self closeLeftView];
            }
        }
        else
        {
            if (self.closed)
            {
                [self closeLeftView];
            }
            else
            {
                [self openLeftView];
            }
        }
        _scalef = 0;
    }
    
    
}

#pragma mark - Delegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    
    if(touch.view.tag == vDeckCanNotPanViewTag)
    {
        //        NSLog(@"不响应侧滑");
        return NO;
    }
    else
    {
        //        NSLog(@"响应侧滑");
        return YES;
    }
}


@end
