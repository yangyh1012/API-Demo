//
//  UserInterfaceViewController.m
//  API Demo
//
//  Created by 杨毅辉 on 15/5/6.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "UserInterfaceViewController.h"
#import "TableViewController.h"

/*说明：
 
 */
@interface UserInterfaceViewController ()<UIAlertViewDelegate,UIActionSheetDelegate,UIWebViewDelegate,UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate,UIScrollViewDelegate>

@end

@implementation UserInterfaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*说明：获得父视图对象。
     
     */
    [self.view superview];
    
    /*说明：获得子视图对象集合。
     
     */
    [self.view subviews];
    
    /*说明：获得视图所在的UIWindow对象。
     
     */
    [self.view window];
    
    /**
     *  设置视图的背景图片
     */
    UIImage *image;
    self.view.layer.contents = (id)image.CGImage;
    
    /*说明：
     状态栏占用20点，
     导航栏（或工具栏）占用44点，
     标签栏占用49点。
     
     */
    
    /*说明：
     在storyboard中获取视图控制器
     storyboardWithName：它的第一个参数是故事板的名字，获得故事板
     instantiateViewControllerWithIdentifier：视图控制器在故事板中的标识，获得视图控制器实例
     
     */
    UserInterfaceViewController *viewController =
            [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"UserInterfaceViewController"];
    NSLog(@"%@",viewController);
    
    /*说明：
     UIInterfaceOrientationPortrait（或UIDeviceOrientationPortrait）。垂直向上，home键在下。
     UIInterfaceOrientationPortraitUpsideDown（或UIDeviceOrientationPortraitUpsideDown）。垂直向下，home键在上。
     UIInterfaceOrientationLandscapeLeft（或UIDeviceOrientationLandscapeLeft）。水平向左，home键在左。
     UIInterfaceOrientationLandscapeRight（或UIDeviceOrientationLandscapeRight）。水平向右，home键在右。
     
     */
    
    /*说明：导航模式
     
     平铺导航模式。
     内容没有层次关系，展示的内容都放置在一个主屏幕上，采用分屏或分页控制器进行导航，
     可以左右或者上下滑动屏幕查看内容。iPod touch中自带的天气预报应用，它采用分屏进行导航。
     
     标签导航模式。
     内容被分成几个功能模块，每个功能模块之间没有什么关系。通过标签管理各个功能模块，
     点击标签可以切换功能模块。iPod touch中自带的时钟应用，它采用的就是标签导航模式。
     
     树形结构导航模式。
     内容是有层次的，从上到下细分或者具有分类包含等关系，例如黑龙江省包含了哈尔滨，
     哈尔滨又包含了道里区、道外区等。iPod touch中自带的邮件应用，它采用的就是树形结构导航模式。
     
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 视图跳转

- (IBAction)onClick:(id)sender {
    
    TableViewController *t = [[TableViewController alloc] init];
    
    /*说明：
     UIModalTransitionStyleCoverVertical。呈现时沿垂直方向由底向上退出，覆盖原来视图，关闭时从上往底部退回。
     UIModalTransitionStyleFlipHorizontal。水平翻转，呈现的时候从右往左翻转，关闭的时候从左往右翻转回来。
     UIModalTransitionStyleCrossDissolve。两个视图交叉淡入淡出。
     UIModalTransitionStylePartialCurl。呈现时模态视图卷起一个边角翻页，关闭时模态视图翻回来。
     
     */
    t.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    /*说明：呈现模态视图。
     
     */
    [self presentViewController:t animated:YES completion:nil];
    
    /*说明：关闭模态视图。
     
     */
    [self dismissViewControllerAnimated:YES completion:^{
        
        /*说明：实现参数回传
         
         */
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RegisterCompletionNotification"
                                                            object:nil
                                                          userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"2", nil]];
    }];
}

#pragma mark -

- (void)createView {
    
    
}

- (void)createWindow {
    
    
}

- (void)createLabel {
    
    
}

#pragma mark - 操作表 UIActionSheet

- (void)createActionSheet {
    
    /*说明：
     如果想给用户提供多于两个的选择时。
     
     */
    
}

- (IBAction)testActionSheet:(id)sender {
    
    /*说明：
     delegate参数设定为self，即该操作表的委托对象为当前的视图控制器。
     cancelButtonTitle参数用于设置“取消”按钮的标题，在iPhone中它在最下面。
     destructiveButtonTitle参数用于设置“破坏性”按钮，它的颜色是红色的，如果没有“破坏性”按钮，可以将该参数设定为nil。“破坏性”按钮只能有一个，在最上面。
     otherButtonTitles参数是其他按钮，它是一个字符串数组，以nil结尾。
     
     */
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@"破坏性按钮"
                                                    otherButtonTitles:@"Fackbook",@"新浪微博",nil];
    
    /*说明：设定操作表的样式
     UIActionSheetStyleAutomatic。自动样式。
     UIActionSheetStyleDefault。默认样式。
     UIActionSheetStyleBlackTranslucent。半透明样式。
     UIActionSheetStyleBlackOpaque。透明样式。
     
     */
    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    [actionSheet showInView:self.view];
    
    
}

/*说明：实现UIActionSheetDelegate
 
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"buttonIndex = %li",(long)buttonIndex);
}

#pragma mark - 活动指示器 UIActivityIndicatorView

- (void)createActivityIndicatorView {
    
    [self showActivityIndicatorViewInNavigationItem];
}

/**
 startAnimating方法。用于开始动画，即旋转起来。
 stopAnimating方法。用于停止动画，即停止旋转。
 isAnimating方法。判断是否在旋转。
 hidesWhenStopped属性。它是布尔值，用于设置控件停止时是否隐藏。
 
 */
- (IBAction)startToMove:(id)sender
{
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] init];
    
    if ([activityIndicatorView isAnimating]) {
        
        [activityIndicatorView stopAnimating];
    } else {
        
        [activityIndicatorView startAnimating];
    }
}

/**
 *  在导航栏中显示等待对话框
 */
- (void)showActivityIndicatorViewInNavigationItem{
    
    /**
     * 将title换成一个加载条
     */
    UIActivityIndicatorView *aiview = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.navigationItem.titleView = aiview;
    [aiview startAnimating];
    
    /**
     *  在标题栏上面显示以下文字
     */
    self.navigationItem.prompt = @"数据加载中...";
}

/**
 *  在导航栏中显示关闭对话框
 */
- (void)closeActivityIndicatorViewInNavigationItem {
    
    /**
     *  停止等待指示器，让原来的title内容显示出来
     */
    self.navigationItem.titleView = nil;
    self.navigationItem.prompt = nil;
}

#pragma mark - 警告框 UIAlertView

- (void)createAlertView {
    
    /*说明：
     警告框使用场景：
     应用不能继续运行。
     例如，无法获得网络数据或者功能不能完成的时候，给用户一个警告，这种警告框只需一个按钮。
     
     询问另外的解决方案。
     好多应用在不能继续运行时，会给出另外的解决方案，让用户去选择。例如，Wi-Fi网络无法连接时，是否可以使用3G网络。
     
     询问对操作的授权。
     当应用访问用户的一些隐私信息时，需要用户授权，例如用户当前的位置、通讯录或日程表等。
     
     */
    
    
    /*说明：
     其中delegate参数在本例中设定为self，即该警告框的委托对象为当前的视图控制器.
     cancelButtonTitle参数用于设置“取消”按钮的标题，它是警告框的左按钮；
     otherButtonTitles参数是其他按钮，它是一个字符串数组，该字符串数组以nil结尾。
     
     */
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"Alert text goes here"
                                                       delegate:self
                                              cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Yes", nil];
    
    /**
     *  UIAlertActionStyleDefault：默认样式
     *  UIAlertViewStyleSecureTextInput：提示视图会包含一个安全加密的文字栏位
     *  UIAlertViewStylePlainTextInput：提示试图会显示一个可见的文字栏位
     *  UIAlertViewStyleLoginAndPasswordInput：提示视图会显示两个本文栏位，一个是可见的用户名称栏位，另一个是加密的密码栏位。
     */
    alertView.alertViewStyle = UIAlertActionStyleDefault;
    [alertView show];
    
    UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                         message:@"Alert text goes here"
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles: nil];
    
    alertView2.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [alertView2 textFieldAtIndex:0];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    
    [alertView2 show];
}

/*说明：实现UIAlertViewDelegate
 
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"buttonIndex = %li",(long)buttonIndex);
}

#pragma mark - 导航栏按钮 UIBarButtonItem

- (void)createBarButtonItem {
    
    /**
     *  自定义UIBarButtonItem的背景图和字体，放在didFinishLaunchingWithOptions这个方法中
     */
    UIImage *button30 = [[UIImage imageNamed:@"button_textured_30"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    UIImage *button24 = [[UIImage imageNamed:@"button_textured_24"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [[UIBarButtonItem appearance] setBackgroundImage:button30 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:button24 forState:UIControlStateNormal barMetrics:UIBarMetricsCompact];
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:220.0/255.0 green:104.0/255.0 blue:1.0/255.0 alpha:1.0], NSForegroundColorAttributeName, [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0], NSShadowAttributeName, [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], NSShadowAttributeName, [UIFont fontWithName:@"AmericanTypewriter" size:0.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    /**
     *  setBackButtonBackgroundImage
     *  自定义返回按钮的样式，放在didFinishLaunchingWithOptions这个方法中
     */
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:button30 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:button24 forState:UIControlStateNormal barMetrics:UIBarMetricsCompact];
}

#pragma mark - 按钮 UIButton

- (void)createButton {
    
    /*说明：创建UIButton对象
     
     */
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    /*说明：设置按钮文本标题
     
     */
    [button setTitle:@"Press Me" forState:UIControlStateNormal];
    
    /**
     *  设置按钮的背景图片
     */
    UIImage *normalImage = [UIImage imageNamed:@"NormalBlueButton.png"];
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    
    [button setImage:normalImage forState:UIControlStateNormal];
    
    /*说明：尺寸自动适应
     
     */
    [button sizeToFit];
    
    /*说明：固定按钮的中心点
     
     */
    button.center = CGPointMake(100, 50);
    
    [button addTarget:self action:@selector(buttonIsTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    /*说明：将按钮加入父视图
     
     */
    [self.view addSubview:button];
    
    //按钮宽度随着标题自适应
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(20, 20, 5000, 60);
    [button2 setBackgroundColor:[UIColor blueColor]];
    [button2 setTitle:@"测试按钮能不能随着标题文字变多而变宽" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    float btnWidth = button2.titleLabel.frame.size.width;
    button2.frame = CGRectMake(20, 20, btnWidth, 60);
    [self.view addSubview:button2];
}

- (void)buttonIsTapped:(UIButton *)paramSender {
    
    NSLog(@"Button is pressed.");
}

#pragma mark - 集合视图 UICollectionView

- (void)createCollectionView {
    
    
}

#pragma mark - 控制视图 UIControl

- (void)createControl {
    
    
}

#pragma mark - 时间选择器 UIDatePicker

- (void)createDatePicker {
    
    /*说明：
     Mode。设定日期选择器的模式。
     Local。设定本地化，日期选择器会按照本地习惯和文字显示日期。
     Interval。设定间隔时间，单位为分钟。
     Date。设定开始时间。
     Constraints。设定能显示的最大和最小日期。
     Timer。在倒计时定时器模式下倒计时的秒数。
     
     */
    
    yyhObjectInit(UIDatePicker, datePicker);
    
    datePicker.datePickerMode = UIDatePickerModeTime;
    
    [datePicker addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:datePicker];
}

- (IBAction)onclick:(UIDatePicker *)datePicker {
    
    /*说明：
     UIDatePicker的date属性返回NSDate数据，就是控件中选中的时间，
     NSDate的descriptionWithLocale:返回基于本地化的日期信息。
     
     */
    NSDate *theDate = datePicker.date;
    NSLog(@"the date picked is: %@", [theDate descriptionWithLocale:[NSLocale currentLocale]]);
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSLog(@"the date formate is: %@", [dateFormatter stringFromDate:theDate]);
}

/**
 *  设置date picker 能够显示的最小和最大时间
 */
- (void)datePickerTest2:(UIDatePicker *)datePicker {
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    yyhObjectInit(NSDate, todayDate);
    NSTimeInterval oneYearTime = 24 * 60 * 60 * 365;
    NSDate *oneYearFromToday = [todayDate dateByAddingTimeInterval:oneYearTime];
    NSDate *twoYearsFromToday = [todayDate dateByAddingTimeInterval:2 * oneYearTime];
    datePicker.minimumDate = oneYearFromToday;
    datePicker.maximumDate = twoYearsFromToday;
}

/**
 *  展现一个两分钟的倒计时的功能
 */
- (void)datePickerTest3:(UIDatePicker *)datePicker {
    
    NSTimeInterval twoMinutes = 2 * 60;
    [datePicker setCountDownDuration:twoMinutes];
}

#pragma mark - 图片视图 UIImageView

- (void)imageViewTest {
    
    UIImage *macBookAir = [UIImage imageNamed:@"MacBookAir.png"];
    UIImageView *myImageView = [[UIImageView alloc] initWithImage:macBookAir];
    myImageView.center = self.view.center;
    
    /**
     *  
     
     UIViewContentModeScaleToFill：这个值会将image view 里的图片进行缩放，以充满整个image view。
     UIViewContentModeScaleAspectFit：这个值会确保image view 里的图片有正确的长宽比，并且会确保图片适应image view的边界。
     UIViewContentModeScaleAspectFill：这个值会确保image view 里的图片有正确的长宽比，并且使图片充满整个图片视图的
     边界。为了能使这个值正常工作，确保将clipsToBounds 这个属性值设置为YES。
     
     */
    myImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    yyhViewAddSubview(myImageView);
}

#pragma mark - 标签 UILabel

- (void)labelTest {
    
    yyhObjectInit(UILabel, label);
    
    label.text = @"iOS 6 Programming Cookbook";
    label.font = [UIFont boldSystemFontOfSize:14.0f];
    
    /**
     *  UILabel换行
     */
    [label setText:@"请先上传\
     语法"];

    /**
     * 
     指定了标签中的文本最多可以显示几行
     如果你不想要显示文本显示的行数，或者你不知道文本要显示多少行，那么将这个属性设置为0
     */
    label.numberOfLines = 3;
    
    /**
     *  标签里的字体能自动调整到适合标签的边界
     */
    label.adjustsFontSizeToFitWidth = YES;
    
    /**
     *  标签阴影的颜色
     */
    label.shadowColor = [UIColor lightGrayColor];
    
    /**
     *  
     指定了文本阴影的偏移量
     
     如果你将这个属性设置为（1,0），阴影将出现在文字右边1 像素的地方。
     如果设置为（1,2），阴影将出现在文字右边1 像素，文字下面2 像素的地方。
     如果设置为（-2，-10），阴影将出现在文本左边2像素，文本上边10 像素的地方。
     
     */
    label.shadowOffset = CGSizeMake(2.0f, 2.0f);
    
    /**
     *  指定了文本的换行模式
     */
    label.lineBreakMode = NSLineBreakByWordWrapping;
    
    /**
     *  事件可以正常的传递给该视图对象
     */
    label.userInteractionEnabled = YES;
    
    yyhViewAddSubview(label);
}

#pragma mark - 导航栏 UINavigationBar

- (void)createNavigationBar {
    
    /**
     *  自定义导航栏的背景图和字体，放在didFinishLaunchingWithOptions这个方法中
     */
    UIImage *gradientImage44 = [[UIImage imageNamed:@"surf_gradient_textured_44"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    UIImage *gradientImage32 = [[UIImage imageNamed:@"surf_gradient_textured_32"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UINavigationBar appearance] setBackgroundImage:gradientImage44 forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:gradientImage32 forBarMetrics:UIBarMetricsCompact];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], NSForegroundColorAttributeName, [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8], NSShadowAttributeName, [NSValue valueWithUIOffset:UIOffsetMake(0, -1)], NSShadowAttributeName, [UIFont fontWithName:@"Arial-Bold" size:0.0], NSFontAttributeName, nil]];
}

#pragma mark - 导航栏选项 UINavigationItem

- (void)createnavigationItem {
    
    /**
     
     设置导航栏标题的图片，导航栏自定义标题图片
     
     */
    [[self navigationItem] setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title.png"]]];
    
    /**
     
     设置导航栏右按钮
    
     */
    UIBarButtonItem *barButtonAction = [[UIBarButtonItem alloc] initWithTitle:@"Delete Numbers > 2"
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(navigationItemTest:)];
    [self.navigationItem setRightBarButtonItem:barButtonAction animated:NO];
    
    /**
     *  去掉导航栏的右按钮
     */
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
}

- (void)navigationItemTest:(id)paramSender {
    
    
}

#pragma mark - 分页控制 UIPageControl

- (void)createPageControl {
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.currentPage = 1;
}

#pragma mark - 普通选择器 UIPickerView

- (void)createPickerView {
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    
    /*说明：
     UIPickerView的Component就是指拨盘，
     selectedRowInComponent方法返回拨盘中被选定的行的索引，索引是从0开始的。
     
     */
    NSInteger row1 = [pickerView selectedRowInComponent:0];
    NSInteger row2 = [pickerView selectedRowInComponent:1];
    NSLog(@"%li,%li",(long)row1,(long)row2);
    
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    /**
     *  设置选择器是否有一个水平的阴影效果
     */
    pickerView.showsSelectionIndicator = YES;
    
    [self.view addSubview:pickerView];
}

/*说明：实现协议UIPickerViewDataSource方法
 为选择器中拨轮的数目。
 
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}

/*说明：实现协议UIPickerViewDataSource方法
 为选择器中某个拨轮的行数。
 
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        
        return 5;
        
    } else {
        
        return 6;
    }
}

/*说明：实现协议UIPickerViewDelegate方法
 为选择器中某个拨轮的行提供显示数据。
 
 */
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        
        return @"1";
    } else {
        
        return @"2";
    }
}

/*说明：实现协议UIPickerViewDelegate方法
 选中选择器的某个拨轮中的某行时调用。
 
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        
        [pickerView reloadComponent:1];
        
        //        [pickerView reloadAllComponents];
    }
}

#pragma mark - 进度条 UIProgressView

- (void)createProgressView {
    
    UIProgressView *progressView = [[UIProgressView alloc] init];
    
    /**
     *  跟UIProgressViewStyleDefault 相似，不过这是用于添加到toolbar 中的进度视图。
     */
    progressView.progressViewStyle = UIProgressViewStyleBar;
    float progress = progressView.progress;
    NSLog(@"%.f",progress);
}

#pragma mark - 滚动视图 UIScrollView

- (void)createScrollView {
    
    /*说明：
     1、contentSize属性：表示ScrollView中内容视图（Content View）的大小，它返回CGSize结构体类型，该结构体包含width和height两个成员。
     
     contentSize.width。
     ScrollView内容视图的宽。
     
     contentSize.height。
     ScrollView内容视图的高。
     
     frame.width。
     ScrollView的宽。
     
     frame.height。
     ScrollView的高。
     
     2、contentInset属性：用于在ScrollView中的内容视图周围添加边框，这往往为了留出空白以放置工具栏、标签栏或导航栏等。
     contentInset属性有4个分量，分别是Top、Bottom、Left和Right，分别代表顶边距离、底边距离、左边距离和右边距离。
     
     3、contentOffset属性：是内容视图坐标原点与ScrollView坐标原点的偏移量，返回CGPoint结构体类型，这个结构体类型包含x和y两个成员。
     
     设定ScrollView视图沿y轴正偏移110点的代码如下：
     [self.scrollView setContentOffset:CGPointMake(0, 110) animated:YES];
     或者
     self.scrollView.contentOffset = CGPointMake(0, 110);
     
     */
    
    yyhObjectInit(UIScrollView, scrollView);
    
    /**
     *  开启分页
     */
    CGRect scrollViewRect = self.view.bounds;
    
    //设置UIScrollView是否翻页滚动
    scrollView.pagingEnabled = YES;
    
    //设置滚动正文的范围
    scrollView.contentSize = CGSizeMake(scrollViewRect.size.width * 3.0f, scrollViewRect.size.height);
    
    //显示水平方向滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    
    //显示垂直方向滚动条
    scrollView.showsVerticalScrollIndicator = NO;
    
    //是否滚动到顶部
    scrollView.scrollsToTop = NO;

    //设置代理
    scrollView.delegate = self;
    
    /**
     *  改变指示器的外观
     */
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
    yyhViewAddSubview(scrollView);
}

/*说明：UIScrollViewDelegate
 
 当滑动视图里的内容滑动时将调用这个方法。
 
 */
- (void)scrollViewDidScroll: (UIScrollView *)aScrollView
{
    CGPoint offset = aScrollView.contentOffset;
    NSLog(@"%@",NSStringFromCGPoint(offset));
}

/**
 *  当用户滑动滑动视图里的内容并且手指离开屏幕而且内容还在滑动的时候，将会调用这个方法。
 *
 */
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    
}

/**
 *  当滑动视图里的内容结束滑动时将调用这个方法。
 *
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    
}

/**
 *  当用户完成拖拽滑动视图里的内容时将会调用这个方法。
 *
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    
}

#pragma mark - 分段控件 UISegmentedControl

/*说明：分段控件 UISegmentedControl
 
 */
- (void)createSegmentedControl {
    
    UIImage *segmentSelected = [[UIImage imageNamed:@"segcontrol_sel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
    UIImage *segmentUnselected = [[UIImage imageNamed:@"segcontrol_uns.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
    UIImage *segmentSelectedUnselected = [UIImage imageNamed:@"segcontrol_sel-uns.png"];
    UIImage *segUnselectedSelected = [UIImage imageNamed:@"segcontrol_uns-sel.png"];
    UIImage *segmentUnselectedUnselected = [UIImage imageNamed:@"segcontrol_uns-uns.png"];
    
    /**
     *  设置未选中状态和选中状态的背景图片，自定义分段控件，放在didFinishLaunchingWithOptions这个方法中
     */
    [[UISegmentedControl appearance] setBackgroundImage:segmentUnselected forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setBackgroundImage:segmentSelected forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    /**
     *  通过左右按钮的状态设置分割线的图片，自定义分段控件，放在didFinishLaunchingWithOptions这个方法中
     */
    [[UISegmentedControl appearance] setDividerImage:segmentUnselectedUnselected forLeftSegmentState:UIControlStateNormal
                                   rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setDividerImage:segmentSelectedUnselected forLeftSegmentState:UIControlStateSelected
                                   rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setDividerImage:segUnselectedSelected forLeftSegmentState:UIControlStateNormal
                                   rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    UISegmentedControl *mySegmentedControl = [[UISegmentedControl alloc] initWithItems:
                                              @[@"iPhone",
                                                [UIImage imageNamed:@"iPad.png"],
                                                @"iPod",
                                                @"iMac"]];
    
    [mySegmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    
    /**
     *  一旦用户选择了一个选项，那个选项会马上被选中而且一直保持选中状态. 如果你想要用户在选中一个选项之后，
     *  该选项马上变回原始状态（就像没有被选中一样），需要将momentary 属性设置为YES。
     */
    mySegmentedControl.momentary = YES;
    
    yyhViewAddSubview(mySegmentedControl);
}

- (void)segmentChanged:(UISegmentedControl *)paramSender {
    
    NSInteger selectedSegmentIndex = [paramSender selectedSegmentIndex];
    NSString *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
    NSLog(@"Segment %ld with %@ text is selected",(long)selectedSegmentIndex,selectedSegmentText);
}

#pragma mark - 滑块 UISlider

/*说明：滑块控件
 
 */
- (void)createSlider {
    
    UIImage *minImage = [[UIImage imageNamed:@"slider_minimum.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    UIImage *maxImage = [[UIImage imageNamed:@"slider_maximum.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    UIImage *thumbImage = [UIImage imageNamed:@"thumb.png"];
    
    /**
     *  滑块还没滑过的背景图，自定义滑块，放在didFinishLaunchingWithOptions这个方法中
     */
    [[UISlider appearance] setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    
    /**
     *  滑块滑过的部分的背景图，自定义滑块，放在didFinishLaunchingWithOptions这个方法中
     */
    [[UISlider appearance] setMinimumTrackImage:minImage forState:UIControlStateNormal];
    
    /**
     *  滑块的图片，自定义滑块，放在didFinishLaunchingWithOptions这个方法中
     */
    [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateNormal];
    
    yyhObjectInit(UISlider, mySlider);
    
    mySlider.minimumValue = 0.0f;
    mySlider.maximumValue = 100.0f;
    mySlider.value = mySlider.maximumValue / 2.0;
    
    /**
     *  最小值的背景颜色
     */
    mySlider.minimumTrackTintColor = [UIColor redColor];
    
    /**
     *  最大值的背景颜色
     */
    mySlider.maximumTrackTintColor = [UIColor greenColor];
    
    /**
     *  滑块的背景颜色
     */
    mySlider.thumbTintColor = [UIColor blackColor];
    
    
    /**
     *  slider左边的图片
     */
    [mySlider setMinimumValueImage:[UIImage imageNamed:@"MinimumValue"]];
    
    /**
     *  最小值的背景图片
     */
    [mySlider setMinimumTrackImage:[UIImage imageNamed:@"MinimumValue"] forState:UIControlStateNormal];
    
    /**
     *  滑块的背景图片
     */
    [mySlider setThumbImage:[UIImage imageNamed:@"Thumb"] forState:UIControlStateNormal];
    [mySlider setThumbImage:[UIImage imageNamed:@"Thumb"] forState:UIControlStateHighlighted];
    
    /**
     *  最大值的背景图片
     */
    [mySlider setMaximumTrackImage:[UIImage imageNamed:@"MaximumValue"] forState:UIControlStateNormal];
    
    /**
     *  slider右边的图片
     */
    [mySlider setMaximumValueImage:[UIImage imageNamed:@"MaximumValue"]];
    
    
    /**
     *  slider 的thumb 只要一移动，sliderValueChanged: target 方法就会马上被调用。
     *
     */
    [mySlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    /**
     *  设为NO，保证thumb 滑动时 不会被连续调用slider 的target
     */
    mySlider.continuous = NO;
    
    yyhViewAddSubview(mySlider);
}

- (IBAction)sliderValueChanged:(id)sender {
    
    UISlider *slider = (UISlider *)sender;
    int progressAsInt = (int)(slider.value + 0.5f);
    NSString *newText = [[NSString alloc]initWithFormat:@"%d",progressAsInt];
    NSLog(@"%@",newText);
}

#pragma mark - 开关 UISwitch

/*说明：开关控件 UISwitch
 
 */
- (void)createSwitch {
    
    UISwitch *switchSwitch = [[UISwitch alloc] init];
    
    /**
     *  设置开关的背景颜色
     */
    [switchSwitch setOnTintColor:[UIColor colorWithRed:0 green:175.0/255.0 blue:176.0/255.0 alpha:1.0]];
    
    /**
     *  默认开启开关
     */
    [switchSwitch setOn:YES];
    
    [switchSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    /**
     *  开关刚要关时的背景色
     */
    switchSwitch.tintColor = [UIColor redColor];
    /**
     *  开关打开后的背景色
     */
    switchSwitch.onTintColor = [UIColor brownColor];
    
    /**
     *  滑块颜色
     */
    switchSwitch.thumbTintColor = [UIColor yellowColor];
    
    /**
     *  这个图片将会在开关开的状态显示
     */
    switchSwitch.onImage = [UIImage imageNamed:@"snow"];
    
    /**
     *  这个图片代表开关处于关的状态
     */
    switchSwitch.offImage = [UIImage imageNamed:@"snow"];
    
    [self.view addSubview:switchSwitch];
}

- (IBAction)valueChanged:(id)sender {
    
    UISwitch *switchSwitch = (UISwitch *)sender;
    BOOL setting = switchSwitch.isOn;
    [switchSwitch setOn:setting animated:YES];
}

#pragma mark - 选项栏 UITabBar

- (void)createTabBar {
    
    UIImage *tabBackground = [[UIImage imageNamed:@"tab_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    /**
     *  设置背景图片，自定义选项栏的图片，放在didFinishLaunchingWithOptions这个方法中
     */
    [[UITabBar appearance] setBackgroundImage:tabBackground];
    
    /**
     *  设置选中时的背景图片，自定义选项栏的图片，放在didFinishLaunchingWithOptions这个方法中
     */
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab_select_indicator"]];
}

#pragma mark - 表格视图 UITableView

- (void)createTableView {
    
    
}

#pragma mark - 单元格视图 UITableViewCell

- (void)createTableViewCell {

    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    /**
     *  为cell设置背景图片，以及选中时的背景图片
     */
    CGRect cellRect = [cell frame];
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:cellRect];
    UIImage *background = [UIImage imageNamed:@"table_cell_single.png"];
    background = [background resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 43.0, 0.0, 64.0)];
    [backgroundView setImage:background];
    [cell setBackgroundView:backgroundView];
    
    UIImageView *selectedBackgroundView = [[UIImageView alloc] initWithFrame:cellRect];
    UIImage *selectBackground = [UIImage imageNamed:@"table_cell_single_sel.png"];
    selectBackground = [selectBackground resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 43.0, 0.0, 64.0)];
    [selectedBackgroundView setImage:selectBackground];
    [cell setSelectedBackgroundView:selectedBackgroundView];
    
    /**
     *  去掉cell的背景颜色
     */
    [cell setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - 文本域 UITextField

- (void)createTextField {
    
    yyhObjectInit(UITextField, textField);
    
    /**
     *  指定文本视图如何显示他的边框
     */
    textField.borderStyle = UITextBorderStyleRoundedRect;
    
    /**
     *  告诉文本视图如何垂直显示文本。
     */
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    /**
     *  指定了文本视图里的文本水平对齐方式
     */
    textField.textAlignment = NSTextAlignmentCenter;
    
    /**
     *  占位符，输入提示
     */
    textField.placeholder = @"Enter text here...";
    
    yyhObjectInit(UILabel, currencyLabel);
    //货币符号
    currencyLabel.text = [[[NSNumberFormatter alloc] init] currencySymbol];
    
    /**
     *  左视图
     */
    textField.leftView = currencyLabel;
    
    textField.delegate = self;
    
    /**
     *  左视图显示模式
     UITextFieldViewModeNever：从不显示左视图。
     UITextFieldViewModeWhileEditing：当编辑的时候才显示左视图。
     UITextFieldViewModeUnlessEditing：不编辑的时候才显示左视图。
     UITextFieldViewModeAlways：一直显示左视图。
     */
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    yyhViewAddSubview(textField);
}

/*
 说明：UITextFieldDelegate
 */

/**
 *  告诉文本视图用户是否开始编辑了
 */
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    NSLog(@"call textFieldShouldBeginEditing:");
    return YES;
}

/**
 *  当用户开始编辑文本视图时这个方法将会被调用
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    NSLog(@"call textFieldDidBeginEditing:");
}

/**
 *  告诉文本视图是否结束当前的编辑任务
 */
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    NSLog(@"call textFieldShouldEndEditing:");
    return YES;
}

/**
 *  当文本视图的编辑任务终止时将会调用这个方法
 */
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    NSLog(@"call textFieldDidEndEditing:");
}

/*说明：通过委托来放弃“第一响应者”
 
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    /*说明：关闭键盘
     
     */
    [textField resignFirstResponder];
    return YES;
}

/**
 *  任何时候文本视图里的文本被修改都会调动这个方法。方法返回的是一个布尔值。假如
 *  返回YES，说明允许修改文本。如果返回NO，文本视图中的文本不会被修改。
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return YES;
}

/**
 *  人工启动清除按钮
 */
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    return YES;
}

#pragma mark - 文本视图 UITextView

- (void)createTextView {
    
    /*说明：
     UITextViewDelegate
     
     */
    
    yyhObjectInit(UITextView, myTextView);
    
    myTextView.text = @"Some text here...";
    myTextView.font = [UIFont systemFontOfSize:16.0f];
    
    /**
     *  UITextView换行
     */
    myTextView.text = @"开始识别前请先点击“上传”按钮上传语法。\n\t上传内容为：\n\t";
    
    yyhViewAddSubview(myTextView);
}

/*说明：通过委托来放弃“第一响应者”
 
 */
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        
        /*说明：关闭键盘
         
         */
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - 工具栏 UIToolbar

- (void)createToolBar {
    
    
}

#pragma mark - 网页 UIWebView

- (void)createWebView {
    
    /*说明：
     UIWebViewDelegate
     
     webView:shouldStartLoadWithRequest:navigationType:。
     该方法在WebView开始加载新的界面之前调用，可以用来捕获WebView中的JavaScript事件。
     
     webViewDidStartLoad:。
     该方法在WebView开始加载新的界面之后调用。
     
     webViewDidFinishLoad:。
     该方法在WebView完成加载新的界面之后调用。
     
     webView:didFailLoadWithError:。
     该方法在WebView加载失败时调用。
     
     使用WebView构建Hybrid应用
     使用JavaScript调用本地代码
     
     */
    
    yyhObjectInit(UIWebView, webView);
    
    webView.delegate = self;
    
    /**
     *  loadHTMLString：baseURL:
     *  这个方法是加载NSString 的一个实例到页面视图上。这个string 必须是一个有效的HTML，或者说浏览器可以渲染的内容。
     */
    NSString *htmlString = @"iOS 6 Programming <strong>Cookbook</strong>";
    [webView loadHTMLString:htmlString baseURL:nil];
    
    yyhViewAddSubview(webView);
    
    /**
     *  loadRequest：
     *  加载一个NSURLRequest 的实例。当你想要在应用程序的网页视图里加载远程的URL时，这个方法是很有用的。
     */
    NSURL *url = [NSURL URLWithString:@"http://www.apple.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

/*说明：加载本地资源文件index.html，并将其显示在WebView上
 
 */
- (IBAction)testLoadHTMLString:(id)sender {
    
    UIWebView *webView = [[UIWebView alloc] init];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *bundleUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    
    NSError *error = nil;
    NSString *html = [[NSString alloc] initWithContentsOfFile:htmlPath
                                                     encoding:NSUTF8StringEncoding
                                                        error:&error];
    if (error == nil) {
        
        //数据加载没有错误的情况下
        [webView loadHTMLString:html baseURL:bundleUrl];
    }
}

/*说明：加载本地资源文件index.html，并将其显示在WebView上
 
 */
- (IBAction)testLoadData:(id)sender {
    
    UIWebView *webView = [[UIWebView alloc] init];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *bundleUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    
    NSError *error = nil;
    NSData *htmlData = [[NSData alloc] initWithContentsOfFile: htmlPath];
    
    if (error == nil) {
        
        //数据加载没有错误的情况下
        [webView loadData:htmlData
                 MIMEType:@"text/html"
         textEncodingName:@"UTF-8"
                  baseURL: bundleUrl];
    }
}

- (IBAction)testLoadRequest:(id)sender {
    
    UIWebView *webView = [[UIWebView alloc] init];
    NSURL * url = [NSURL URLWithString: @"http://www.51work6.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    webView.delegate = self;
    
}

/*说明：UIWebViewDelegate委托定义方法
 
 当网页视图开始加载内容时将调用这个方法。
 
 */
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    
}

/**
 *  当网页视图完成加载时将调用这个方法。
 *
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    /*说明：
     使用WebView的stringByEvaluatingJavaScriptFromString:方法调用JavaScript的语句，
     使用document.body.innerHTML获得页面中HTML代码的JavaScript语句。
     
     */
    
    NSLog(@"%@",[webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"]);
}

/**
 *  当因加载出错（例如：因网络问题而断开可连接）而导致停止加载时将调用这方法。
 *
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    
}

#pragma mark - 网络等待指示器

- (void)networkActivityIndicatorVisible {
    
    /**
     *  会在状态栏中显示网络等待指示器图标。它在状态栏中以经典旋转小图标的形式出现。
     */
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    /**
     *  停止网络等待指示器，并且其图标会在状态栏中消失。
     */
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}



#pragma mark - 键盘 UIKeyboard

- (void)createkeyboard {
    
    /**
     *  
     UIKeyboardWillShowNotification
     当键盘即将要显示的时候将会发出这个通知。
     这个通知包含了用户信息字典，里面包括了键盘的各种信息，键盘将以动画的形式显示在屏幕上。
     
     UIKeyboardDidShowNotification
     当键盘已经显示在屏幕上时将发出这个通知。
     
     UIKeyboardWillHideNotification
     当键盘将要从屏幕上移除时将会发出此通知。
     通知里包含了用户信息字典，里面包括了各种关于键盘信息的详细信息，当键盘隐藏时的动画，动画的持续时间，等等。
     
     UIKeyboardDidHideNotification
     当键盘完全隐藏后将发出此通知。
     *
     */
}

/**
 *  关闭键盘的三种方法
 */
- (void)closeKeyboard {
    
    //在IBAction的点击方法中加入
    UITextField *nameField;
    UITextField *numberField;
    [nameField resignFirstResponder];
    [numberField resignFirstResponder];
    
//=====================================================================
    
    //在视图中，加入方法：
    //-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//    UITouch *touch = [[event allTouches] anyObject];
//    if(touch.tapCount >= 1){
//        
//        [nameField resignFirstResponder];
//        [numberField resignFirstResponder];
//    }
    
//=====================================================================
    
    //在视图中，加入方法：
    //-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
    [self.view endEditing:YES];
}



- (void)viewWillAppear:(BOOL)animated {
    
    //注册键盘出现通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name: UIKeyboardDidShowNotification object:nil];
    //注册键盘隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name: UIKeyboardDidHideNotification object:nil];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    //解除键盘出现通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification object:nil];
    //解除键盘隐藏通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification object:nil];
    [super viewWillDisappear:animated];
}

- (void)keyboardDidShow:(NSNotification *)notification {
    
    NSLog(@"键盘打开");
}

- (void)keyboardDidHide:(NSNotification *)notification {
    
    NSLog(@"键盘关闭");
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    
    NSDictionary *info = [notification userInfo];
    
    /*说明：
     UIKeyboardAnimationCurveUserInfoKey：
     这个关键字的值指明了显示和隐藏键盘使用的动画类型。
     这个关键字包含了一个NSNumber 类型的值，此类型包含了一个NSUInteger 类型无符号整数
     
     UIKeyboardAnimationDurationUserInfoKey：
     这个键值指明了键盘显示或隐藏的动画所用的时间。
     这个键包含一个NSNumber 类型的值，此类包含一个double 类型的双字节值。
     
     UIKeyboardFrameBeginUserInfoKey：
     这个键值指明了键盘在动画之前的frame。
     假如键盘将要显示时，在显示之前将这个frame 传递给这个动画。假如键盘已经显示了并即将要隐藏时，
     这个frame 将会传递给这个隐藏动画，在键盘消失之前。这个键包含了一个CGRect 类型的值。
     
     UIKeyboardFrameEndUserInfoKey：获得键盘的尺寸，键盘高度
     这个键值指明了动画完成后的键盘frame。
     假如键盘即将要显示时，这个frame 将会在键盘完全显示后传递给键盘。。假如键盘已经完全显示，
     而且将要隐藏时，在完全隐藏后这个frame 将会传递给键盘。这个键值包含了一个CGRect 类型的值。
     
     */
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"%.f",keyboardSize.height);
    
    /*说明：滚动到一个矩形区域
     
     */
    CGRect textFieldRect = [self.view frame];
    [scrollView scrollRectToVisible:textFieldRect animated:YES];
}

/**
 *  在textView中输入时避免键盘的遮挡 textview 键盘 键盘自适应 自适应
 */
- (void)keyboardDidShow1:(NSNotification *)notification {
    
    NSDictionary *info = [notification userInfo];
    
    /*说明：UIKeyboardFrameEndUserInfoKey获得键盘的尺寸，键盘高度
     
     */
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"%.f",keyboardSize.height);
    
    //self.tableView.contentInset = UIEdgeInsetsMake(0, 0,keyboardSize.height, 0);
}

/**
 *  在textView中输入时避免键盘的遮挡 textview 键盘 键盘自适应 自适应
 */
- (void)keyboardDidHide1:(NSNotification *)notification {
    
    //self.tableView.contentInset = UIEdgeInsetsZero;
}

#pragma mark - 状态栏 StatusBar

- (void)BarTest {
    
    /**
     *
     
     状态栏 20
     导航栏 44
     工具栏 44
     标签栏 49
     
     iOS 7情况下，这些栏变成半透明，背景图片可以不需要考虑这些栏造成的影响。
     
     */
    
    /**
     *
     隐藏状态栏
     在Info.plist文件中加入
     View controller-based status bar appearance
     设置值为NO，就可以在全局状态下控制状态栏是否隐藏。
     
     然后在单个视图控制器中调用：
     */
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    /**
     *
     设置状态栏风格
     UIStatusBarStyleDefault。默认的黑色文字。
     UIStatusBarStyleLightContent。白色文字。
     */
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

#pragma mark - storyboard 故事板 和 Xib

- (void)storyboardTest {
    
    //获得当前故事板对象
    UIStoryboard *mainStoryboard = [self storyboard];
    NSLog(@"%@",mainStoryboard);
    
    //使用视图控制器的initWithNibName:bundle:方法从xib文件中创建视图控制器对象。
    UIViewController *controller = [[UIViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    NSLog(@"%@",controller);
    
    //从MyView的xib文件创建一个视图对象
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"UIView"
                                                      owner:self
                                                    options:nil];
    //通过isKindOfClass:判断目标视图类型
    UIView *view;
    for (id object in nibViews) {
        if ([object isKindOfClass:[UIView class]])
            view = (UIView *)object;
    }
}

- (void)nibTest {

    /**
     *  创建CustomCell类，并继承于UITableViewCell
     */
//    NSBundle *classBundle = [NSBundle bundleForClass:[CustomCell class]];
    
    /**
     *  将CustomCell类和UITableView取得联系
     */
//    UINib *topNib = [UINib nibWithNibName:REUSE_ID_TOP bundle:classBundle];
//    [[self tableView] registerNib:topNib forCellReuseIdentifier:REUSE_ID_TOP];
}

#pragma mark - GestureRecognizer

- (void)gestureRecognizerTest {
    
    /**
     轻扫手势
     
     */
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(handleSwipes:)];
    /* Swipes that are performed from right to left are to be detected */
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
    /* Just one finger needed */
    swipeGestureRecognizer.numberOfTouchesRequired = 1;
    /* Add it to the view */
    [self.view addGestureRecognizer:swipeGestureRecognizer];
    
    /**
     旋转手势
     
     */
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc]
                                                              initWithTarget:self
                                                              action:@selector(handleRotations:)];
    [self.view addGestureRecognizer:rotationGestureRecognizer];
    
    /**
     拖动手势
     
     */
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handlePanGestures:)];
    /* At least and at most we need only one finger to activate
     the pan gesture recognizer */
    panGestureRecognizer.minimumNumberOfTouches = 1;
    panGestureRecognizer.maximumNumberOfTouches = 1;
    
    /**
     长按手势
     
     */
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]
                                                                initWithTarget:self
                                                                action:@selector(handleLongPressGestures:)];
    //所需触摸2次
    longPressGestureRecognizer.numberOfTouchesRequired = 2;
    //允许100秒中运动
    longPressGestureRecognizer.allowableMovement = 100.0f;
    //长按时间为1秒
    longPressGestureRecognizer.minimumPressDuration = 1.0;
    
    /**
     轻击手势
     
     */
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handleTaps:)];
    //需要两个手指同时来完成动作
    tapGestureRecognizer.numberOfTouchesRequired = 2;
    //我们需要连续的点击三次
    tapGestureRecognizer.numberOfTapsRequired = 3;
    /* Add this gesture recognizer to the view */
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    /**
     捏合手势
     
     */
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(handlePinches:)];
    [self.view addGestureRecognizer:pinchGestureRecognizer];
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)paramSender {
    
    if (paramSender.direction & UISwipeGestureRecognizerDirectionDown) {
        
        NSLog(@"Swiped Down.");
    }
    if (paramSender.direction & UISwipeGestureRecognizerDirectionLeft) {
        
        NSLog(@"Swiped Left.");
    }
    if (paramSender.direction & UISwipeGestureRecognizerDirectionRight) {
        
        NSLog(@"Swiped Right.");
    }
    if (paramSender.direction & UISwipeGestureRecognizerDirectionUp) {
        
        NSLog(@"Swiped Up.");
    }
}

- (void)handleRotations:(UIRotationGestureRecognizer *)paramSender {
    
    UILabel *helloWorldLabel = [[UILabel alloc] initWithFrame:CGRectZero];//要改成成员变量，而不是临时变量
    CGFloat rotationAngleInRadians = 0;//要改成成员变量，而不是临时变量
    
    if (helloWorldLabel == nil){
        return;
    }
    
    /* Take the previous rotation and add the current rotation to it */
    helloWorldLabel.transform = CGAffineTransformMakeRotation(rotationAngleInRadians + paramSender.rotation);
    
    /* At the end of the rotation, keep the angle for later use */
    if (paramSender.state == UIGestureRecognizerStateEnded) {
        
        rotationAngleInRadians += paramSender.rotation;
    }
}

- (void)handlePanGestures:(UIPanGestureRecognizer*)paramSender {
    
    /**
     *  
     
     1. UIGestureRecognizerStateBegan
     2. UIGestureRecognizerStateChanged
     3. UIGestureRecognizerStateEnded
     
     */
    if (paramSender.state != UIGestureRecognizerStateEnded &&
        paramSender.state != UIGestureRecognizerStateFailed) {
        
        /**
         *  获取到我们手势的坐标
         */
        CGPoint location = [paramSender locationInView:paramSender.view.superview];
        paramSender.view.center = location;
    }
}

- (void)handleLongPressGestures:(UILongPressGestureRecognizer *)paramSender {
    
    if ([paramSender isEqual:paramSender]) {
        
        if (paramSender.numberOfTouchesRequired == 2) {
            
            CGPoint touchPoint1 = [paramSender locationOfTouch:0 inView:paramSender.view];
            CGPoint touchPoint2 = [paramSender locationOfTouch:1 inView:paramSender.view];
            CGFloat midPointX = (touchPoint1.x + touchPoint2.x) / 2.0f;
            CGFloat midPointY = (touchPoint1.y + touchPoint2.y) / 2.0f;
            CGPoint midPoint = CGPointMake(midPointX, midPointY);
            self.view.center = midPoint;
        } else {
            /* This is a long press gesture recognizer with more
             or less than 2 fingers */
        }
    }
}

- (void)handleTaps:(UITapGestureRecognizer*)paramSender {
    
    NSUInteger touchCounter = 0;
    for (touchCounter = 0; touchCounter < paramSender.numberOfTouchesRequired;touchCounter++) {
        
        CGPoint touchPoint = [paramSender locationOfTouch:touchCounter inView:paramSender.view];
        
        /**
         *  NSStringFromCGPoint
         *  把一个物理的位置信息CGPoint 转化成一个NSString 类型的数据。
         *
         */
        NSLog(@"Touch #%lu: %@",(unsigned long)touchCounter+1,NSStringFromCGPoint(touchPoint));
    }
}

- (void)handlePinches:(UIPinchGestureRecognizer *)paramSender {
    
    CGFloat currentScale = 0.0;
    if (paramSender.state == UIGestureRecognizerStateEnded) {
        
        currentScale = paramSender.scale;
    } else if (paramSender.state == UIGestureRecognizerStateBegan && currentScale != 0.0f) {
        
        paramSender.scale = currentScale;
    }
    if (paramSender.scale != NAN && paramSender.scale != 0.0){
        
        paramSender.view.transform = CGAffineTransformMakeScale(paramSender.scale,paramSender.scale);
    }
}

#pragma mark -


#pragma mark -

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
