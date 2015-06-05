//
//  TextKitViewController.m
//  API Demo
//
//  Created by 杨毅辉 on 15/5/6.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "TextKitViewController.h"

@interface TextKitViewController ()

@end

@implementation TextKitViewController

/*说明：
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*说明：
     NSTextContainer。
     定义了文本可以排版的区域。默认情况下是矩形区域，如果是其他形状的区域，需要通过子类化NSTextContainer来创建。
     
     NSLayoutManager。
     该类负责对文字进行编辑排版处理，将存储在NSTextStorage中的数据转换为可以视图控件中显示的文本内容，
     并把字符编码映射到对应的字形上，然后将字形排版到NSTextContainer定义的区域中。
     
     NSTextStorage。
     主要用来存储文本的字符和相关属性，是NSMutableAttributedString的子类。此外，当NSTextStorage中的字符或属性发生改变时，
     会通知NSLayoutManager，进而做到文本内容的显示更新。
     
     NSAttributedString。
     支持渲染不同风格的文本。
     
     NSMutableAttributedString。
     可变类型的NSAttributedString，是NSAttributedString的子类。
     
     */
    
    /*说明：
     NSLayoutManager、NSTextContainer、NSTextStorage之间究竟是什么关系呢？
     
     NSLayoutManager对象从NSTextStorage对象中取得文本内容进行排版，
     然后把排版之后的文本放到NSTextContainer对象指定的区域上。
     最后再由一个文本控件从NSTextContainer中取出内容显示到屏幕中。
     
     在没有计算机排版的时代，排版工人（NSLayoutManager）从铅字库中找到特定字体的字母（NSTextStorage），
     然后把它放到活动字模中（NSTextContainer），最后进行印刷。
     
     */
    
    [self textKitTest1];
    [self textKitTest2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 变更指定字符串的颜色


- (void)textKitTest1 {
    
    /*说明：'\n'为换行
     
     */
    NSString *string = @"Sometimes life hits you in the head with a brick. Don't lose faith. I'm convinced that the only thing that kept me going was that I loved what I did. You've got to find what you love. And that is as true for your work as it is for your lovers.\n有时候，人生会把你打得头破血流，不要丧失信心。我坚信这些年来让我坚持不懈的唯一理由是我爱我所做的事情。你必须找到你的所爱，无论是工作还是恋人，都是如此。";
    
    /*说明：创建一个包含内容的NSTextStorage对象。
     
     */
    NSTextStorage* textStorage = [[NSTextStorage alloc] initWithString:string];
    
    /*说明：创建一个NSLayoutManager对象。
     
     */
    NSLayoutManager* layoutManager = [[NSLayoutManager alloc] init];
    
    /*说明：将内容和排版关联起来。
     
     */
    [textStorage addLayoutManager:layoutManager];
    
    /*说明：设置一个中心点，后面的两个参数沿着中心点的边缘向内缩进量
     左边缩进10，右边缩进10，上边缩进20，下边缩进20
     这样可以使得文字部分不会太靠近视图的边界。
     
     */
    CGRect textViewRect = CGRectInset(self.view.bounds, 10.0, 20.0);
    
    /*说明：创建一个指定区域的NSTextContainer对象。
     
     */
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:textViewRect.size];
    
    /*说明：将排版和区域关联起来
     
     */
    [layoutManager addTextContainer:textContainer];
    
    /*说明：创建一个大小和区域都指定了的UITextView对象。
     
     */
    UITextView *textView = [[UITextView alloc] initWithFrame:textViewRect
                                               textContainer:textContainer];
    
    /*说明：为UITextView对象设置文本。
     
     */
    [textView setText:string];
    
    /*说明：在view中添加UITextView子视图。
     
     */
    [self.view addSubview:textView];
    
    /*说明：设置凸版印刷效果的 开始
     
     */
    [textStorage beginEditing];
    
    /*说明：属性设置
     NSFontAttributeName：字体
     NSForegroundColorAttributeName：颜色
     NSTextEffectAttributeName：效果
     
     */
    NSDictionary *attrsDic = @{NSFontAttributeName:[UIFont systemFontOfSize:25.0],
                               NSForegroundColorAttributeName:[UIColor blueColor],
                               NSTextEffectAttributeName: NSTextEffectLetterpressStyle};
    
    /*说明：创建一个NSMutableAttributedString对象
     
     */
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string
                                                                                attributes:attrsDic];
    /*说明：内容采用该样式
     
     */
    [textStorage setAttributedString:attrStr];
    
    [self markWord:@"我" inTextStorage:textStorage contentText:string];
    [self markWord:@"I" inTextStorage:textStorage contentText:string];
    
    /*说明：设置凸版印刷效果的 结束
     
     */
    [textStorage endEditing];
}

/*说明：在内容中查找指定的字符串，并变更指定字符串的颜色。
 markWord：指定字符串
 inTextStorage：内容
 contentText：文本内容
 
 */
- (void) markWord:(NSString*)word inTextStorage:(NSTextStorage*)textStorage contentText:(NSString *)text
{
    /*说明：用指定字符串作正则表达式
     
     */
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:word
                                                                           options:0
                                                                             error:nil];
    /*说明：获取指定字符串在文本内容中的位置
     
     */
    NSArray *matches = [regex matchesInString:text
                                      options:0
                                        range:NSMakeRange(0, [text length])];
    
    for (NSTextCheckingResult *match in matches) {
        
        /*说明：将每个位置的指定字符串添加属性，改变颜色。
         
         */
        NSRange matchRange = [match range];
        [textStorage addAttribute:NSForegroundColorAttributeName
                            value:[UIColor redColor]
                            range:matchRange];
    }
}

#pragma mark - 用户在手机系统设置中改变字体


- (void)textKitTest2 {
    
    /*说明：UIContentSizeCategoryDidChangeNotification，
     当用户在设置中改变了字体，系统会给应用程序发送这个通知。
     
     */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredContentSizeChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)preferredContentSizeChanged:(NSNotification *)notification{
    
    UITextView *textView = [[UITextView alloc] init];
    
    /*说明：preferredFontForTextStyle，获取用户设置的字体
     不要在代码中硬编码字体大小，而是监听系统字体设置的变化。
     
     iOS 7中提供了6种字体样式供选择。
     UIFontTextStyleHeadline。标题字体，例如：报纸的标题。
     UIFontTextStyleSubheadline。子标题字体。
     UIFontTextStyleBody。正文字体。
     UIFontTextStyleFootnote。脚注字体。
     UIFontTextStyleCaption1。标题字体，一般用于照片或者字幕。
     UIFontTextStyleCaption2。另一个可选Caption字体。
     
     */
    textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

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
