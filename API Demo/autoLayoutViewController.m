//
//  autoLayoutViewController.m
//  API Demo
//
//  Created by 杨毅辉 on 15/6/17.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "autoLayoutViewController.h"

@interface autoLayoutViewController()

@property (nonatomic, strong) UIView *topGrayView;
@property (nonatomic, strong) UIButton *topButton;

@property (nonatomic, strong) UIView *bottomGrayView;
@property (nonatomic, strong) UIButton *bottomButton;

@end

/**
 *  布局 NSLayoutContraint和Visual Format Language
 */
@implementation autoLayoutViewController

#pragma mark - 将按钮放置在最中央

/**
 *  将按钮放置在最中央
 */
- (void)layoutConstraintTest {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    /**
     *  将这个属性设置成NO 将确保UIKit 不会将控件混合也不会自动将autoresizing maskss 转变成自动布局的限制条件。
     *  任何时候你在处理自动布局限制条件时将你所有的UI 组件的这个属性都设置成NO 是一个和好的办法。
     */
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:@"button" forState:UIControlStateNormal];
    
    yyhViewAddSubview(button);
    
    UIView *superView = button.superview;
    
    NSLayoutConstraint *centerXconstraint = [NSLayoutConstraint constraintWithItem:button
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:superView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0f
                                                                          constant:0.0f];
    NSLayoutConstraint *centerYContraint = [NSLayoutConstraint constraintWithItem:button
                                                                        attribute:NSLayoutAttributeCenterY
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:superView
                                                                        attribute:NSLayoutAttributeCenterY
                                                                       multiplier:1.0f
                                                                         constant:0.0f];
    
    [superView addConstraints:@[centerXconstraint,centerYContraint]];
}

#pragma mark - 登录注册页面

/**
 *  登录注册页面
 */
- (void)visualFormatLanguageTest {
    
    yyhObjectInit(UITextField, email);
    email.translatesAutoresizingMaskIntoConstraints = NO;
    email.borderStyle = UITextBorderStyleRoundedRect;
    email.placeholder = @"Email";
    yyhViewAddSubview(email);
    
    yyhObjectInit(UITextField, confirmEmail);
    confirmEmail.translatesAutoresizingMaskIntoConstraints = NO;
    confirmEmail.borderStyle = UITextBorderStyleRoundedRect;
    confirmEmail.placeholder = @"Confirm Email";
    yyhViewAddSubview(confirmEmail);
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    registerBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [registerBtn setTitle:@"Register" forState:UIControlStateNormal];
    yyhViewAddSubview(registerBtn);
    
    /**
     *  email的约束
     */
    NSMutableArray *emailResult = [[NSMutableArray alloc] init];
    NSDictionary *emailDic = NSDictionaryOfVariableBindings(email);
    [emailResult addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[email]-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:emailDic]];
    [emailResult addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[email]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:emailDic]];
    NSArray *emailConstraint = [NSArray arrayWithArray:emailResult];
    
    /**
     *  confirm email的约束
     */
    NSMutableArray *confirmEmailResult = [[NSMutableArray alloc] init];
    NSDictionary *confirmEmailDic = NSDictionaryOfVariableBindings(confirmEmail,email);
    [confirmEmailResult addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[confirmEmail]-|"
                                                                                    options:0
                                                                                    metrics:nil
                                                                                      views:confirmEmailDic]];
    [confirmEmailResult addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[email]-[confirmEmail]"
                                                                                    options:0
                                                                                    metrics:nil
                                                                                      views:confirmEmailDic]];
    NSArray *confirmEmailConstraint = [NSArray arrayWithArray:confirmEmailResult];
    
    /**
     *  register的约束
     */
    NSMutableArray *registerResult = [[NSMutableArray alloc] init];
    NSDictionary *registerDic = NSDictionaryOfVariableBindings(registerBtn,confirmEmail);
    [registerResult addObject:[NSLayoutConstraint constraintWithItem:registerBtn
                                                           attribute:NSLayoutAttributeCenterX
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeCenterX
                                                          multiplier:1.0f
                                                            constant:0.0f]];
    [registerResult addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[confirmEmail]-[registerBtn]"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:registerDic]];
    NSArray *registerConstraint = [NSArray arrayWithArray:registerResult];
    
    /**
     添加布局
     
     */
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [result addObjectsFromArray:emailConstraint];
    [result addObjectsFromArray:confirmEmailConstraint];
    [result addObjectsFromArray:registerConstraint];
    [self.view addConstraints:[NSArray arrayWithArray:result]];
}

#pragma mark - 使用不同父类的view 进行约束

/**
 *  创建两个视图，一个在上，一个在下，中间间距100，每个视图中各有一个按钮。
 */
- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createGrayViews];
    [self createButtons];
    
    [self applyConstraintsToTopGrayView];
    [self applyConstraintsToButtonOnTopGrayView];
    
    [self applyConstraintsToBottomGrayView];
    [self applyConstraintsToButtonOnBottomGrayView];
    
}

/**
 *  创建视图
 *
 *  @return 视图
 */
- (UIView *)newGrayView {
    
    UIView *result = [[UIView alloc] init];
    result.backgroundColor = [UIColor lightGrayColor];
    result.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:result];
    return result;
}

- (void)createGrayViews {
    
    self.topGrayView = [self newGrayView];
    self.bottomGrayView = [self newGrayView];
}

/**
 *  创建按钮
 *
 *  @param paramView 父视图
 *
 *  @return 按钮
 */
- (UIButton *)newButtonPlacedOnView:(UIView *)paramView {
    
    UIButton *result = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    result.translatesAutoresizingMaskIntoConstraints = NO;
    [result setTitle:@"Button" forState:UIControlStateNormal];
    [paramView addSubview:result];
    return result;
}

- (void)createButtons {
    
    self.topButton = [self newButtonPlacedOnView:self.topGrayView];
    self.bottomButton = [self newButtonPlacedOnView:self.bottomGrayView];
}

/**
 *  顶部视图设置约束条件
 */
- (void)applyConstraintsToTopGrayView {
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_topGrayView);
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    NSString *const kHConstraint = @"H:|-[_topGrayView]-|";
    NSString *const kVConstraint = @"V:|-[_topGrayView(==100)]";
    
    /* Horizontal constraint(s)  水平居中*/
    [constraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:kHConstraint
                                             options:0
                                             metrics:nil
                                               views:views]
     ];
    
    /* Vertical constraint(s)  距离顶部100*/
    [constraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:kVConstraint
                                             options:0
                                             metrics:nil
                                               views:views]
     ];
    
    [self.topGrayView.superview addConstraints:constraints];
}

/**
 *  顶部按钮设置约束
 */
- (void)applyConstraintsToButtonOnTopGrayView {
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_topButton);
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    NSString *const kHConstraint = @"H:|-[_topButton]";
    
    /* Horizontal constraint(s) */
    [constraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:kHConstraint
                                             options:0
                                             metrics:nil
                                               views:views]
     ];
    
    /* Vertical constraint(s)  垂直居中*/
    [constraints addObject:
     [NSLayoutConstraint constraintWithItem:self.topButton
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.topGrayView
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1.0f
                                   constant:0.0f]
     ];
    
    [self.topButton.superview addConstraints:constraints];
}

/**
 *  底部视图设置约束
 */
- (void)applyConstraintsToBottomGrayView {
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_topGrayView,_bottomGrayView);
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    NSString *const kHConstraint = @"H:|-[_bottomGrayView]-|";
    NSString *const kVConstraint =@"V:|-[_topGrayView]-[_bottomGrayView(==100)]";
    
    /* Horizontal constraint(s)  水平居中*/
    [constraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:kHConstraint
                                             options:0
                                             metrics:nil
                                               views:views]
     ];
    
    /* Vertical constraint(s)  距离顶部视图100*/
    [constraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:kVConstraint
                                             options:0
                                             metrics:nil
                                               views:views]
     ];
    
    [self.bottomGrayView.superview addConstraints:constraints];
}

/**
 *  底部按钮设置约束
 */
- (void)applyConstraintsToButtonOnBottomGrayView {
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_topButton,_bottomButton);
    
    NSString *const kHConstraint = @"H:[_topButton][_bottomButton]";
    
    /* Horizontal constraint(s)  底部视图按钮的左边应该和顶部视图中按钮的右边对齐*/
    [self.bottomGrayView.superview addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:kHConstraint
                                             options:0
                                             metrics:nil
                                               views:views]
     ];
    
    /* Vertical constraint(s)  垂直居中*/
    [self.bottomButton.superview addConstraint:
     [NSLayoutConstraint constraintWithItem:self.bottomButton
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.bottomGrayView
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1.0f
                                   constant:0.0f]
     ];
}

@end
