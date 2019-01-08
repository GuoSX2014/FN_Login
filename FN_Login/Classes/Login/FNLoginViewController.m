//
//  FNLoginViewController.m
//  FNYongNeng
//
//  Created by qunye zhu on 2018/4/8.
//  Copyright © 2018年 qunye zhu. All rights reserved.
//

#import "FNLoginViewController.h"
#import <Masonry/Masonry.h>
//#import "FNUserManager.h"
//#import "FNJumpUtil.h"
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>
#import <FN_Macros/FNProjectColorMacros.h>
#import <FNMacros/FNAppMacros.h>
#import <FNCategory/FNCategory.h>

@interface FNLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (strong, nonatomic) FNLogInTextField *userName;
@property (strong, nonatomic) FNLogInTextField *password;
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UIButton *showPwdButton;
@end

@implementation FNLoginViewController
#pragma mark - life cycle
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange) name:UITextFieldTextDidChangeNotification object:nil];
}
#pragma mark - 初始化控件
- (void)setUpViews{
    self.fd_prefersNavigationBarHidden = YES;

    self.bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.bgView.backgroundColor = kBackgroundBlackDominantColor;
    [self.view addSubview:self.bgView];


    UILabel *titleLbl = [UILabel new];
    titleLbl.font = [UIFont systemFontOfSize:28];
    // PingFangMediumFontSize(28);
    titleLbl.textColor = kTextGrayDominantColor;
    NSString *str = @"欢迎进入我的泛能";
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSForegroundColorAttributeName:kBackgroundBlueDominantColor,
                            } range:[str rangeOfString:@"我的泛能"]];
    titleLbl.attributedText = attStr;
    [self.bgView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kRealWidth(120));
        make.left.mas_offset(kRealWidth(25));
    }];


    [self.bgView addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLbl.mas_bottom).offset(kRealWidth(27));
        make.left.mas_equalTo(kRealWidth(25));
        make.right.mas_equalTo(kRealWidth(-25));
        make.height.mas_equalTo(kRealWidth(44));
    }];

    UIView *line = [UIView new];
    [self.bgView addSubview:line];
    line.backgroundColor = kSepratorGrayDiminantColor;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userName.mas_bottom).offset(3);
        make.left.right.mas_equalTo(self.userName);
        make.height.mas_equalTo(1);
    }];

    [self.bgView addSubview:self.password];
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userName.mas_bottom).offset(kRealWidth(10));
        make.left.mas_equalTo(kRealWidth(25));
        make.right.mas_equalTo(kRealWidth(-25-36));
        make.height.mas_equalTo(kRealWidth(44));
    }];

    UIView *line2 = [UIView new];
    [self.bgView addSubview:line2];
    line2.backgroundColor = kSepratorGrayDiminantColor;
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.password.mas_bottom).offset(3);
        make.left.right.mas_equalTo(self.userName);
        make.height.mas_equalTo(1);
    }];

    //眼睛
    UIButton *eyesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [eyesBtn setImage:[UIImage imageNamed:@"eyes_close"] forState:UIControlStateNormal];
    [eyesBtn setImage:[UIImage imageNamed:@"eyes_open"] forState:UIControlStateSelected];
    eyesBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [eyesBtn addTarget:self action:@selector(showPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:eyesBtn];

    [eyesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.password);
        make.left.mas_equalTo(self.password.mas_right);
        make.width.mas_equalTo(kRealWidth(40));
    }];


    UIView *subView = [[UIView alloc] init];
    CALayer *subLayer=subView.layer;
    subLayer.shadowColor = HexRGBA(0x0780ED, 0.2).CGColor;
    subLayer.shadowOffset = CGSizeMake(kRealWidth(7) , 20);
    subLayer.shadowOpacity = 0.5;
    subLayer.shadowRadius = kRealWidth(12);
    [self.bgView addSubview:subView];

    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(kRealWidth(30));
        make.left.mas_equalTo(kRealWidth(25));
        make.right.mas_equalTo(kRealWidth(-25));
        make.height.mas_equalTo(kRealWidth(40));
    }];
    [subView addSubview:self.loginButton];
    self.loginButton.layer.cornerRadius = kRealWidth(20);
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.frame = subView.bounds;

    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];


#if VersionType == 0
    // 0--9 测试账号
    _userName.text = @"15032202620";
//    _userName.text = @"18614062343";
    _password.text = @"123456";
    _loginButton.enabled = YES;

#elif VersionType == 1
//    _userName.text = @"18939532019";
//    _password.text = @"123456";
//    _loginButton.enabled = YES;

#else
    _userName.text = @"";
    _password.text = @"";
    _loginButton.enabled = NO;
#endif

}

#pragma mark - setters & getters

- (FNLogInTextField *)userName
{
    if (!_userName) {
        _userName = [[FNLogInTextField alloc] init];
        _userName.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_user"]];
        _userName.leftViewMode = UITextFieldViewModeAlways;
        _userName.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userName.textAlignment = NSTextAlignmentLeft;
        _userName.textColor = kTextGrayDominantColor;
        _userName.keyboardType = UIKeyboardTypeDefault;
        _userName.delegate = self;
        _userName.returnKeyType = UIReturnKeyNext;
        //17733680080
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:@"请输入手机号/邮箱"];
        [attributedText addAttribute:NSForegroundColorAttributeName value:kTextDeepGrayDominantColor range:NSMakeRange(0, attributedText.length)];
        _userName.attributedPlaceholder =  attributedText;
    }
    return _userName;
}



- (FNLogInTextField *)password{
    if (!_password) {
        _password = [[FNLogInTextField alloc] init];
        _password.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_password"]];
        _password.leftViewMode = UITextFieldViewModeAlways;
        //设置显示模式为永远显示(默认不显示)
        _password.clearButtonMode = UITextFieldViewModeWhileEditing;
        _password.textAlignment = NSTextAlignmentLeft;
        _password.textColor = kTextGrayDominantColor;
        _password.keyboardType = UIKeyboardTypeDefault;

        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:@"请输入密码"];
        [attributedText addAttribute:NSForegroundColorAttributeName value:kTextDeepGrayDominantColor range:NSMakeRange(0, attributedText.length)];
        _password.attributedPlaceholder =  attributedText;
        _password.delegate = self;
        _password.returnKeyType = UIReturnKeyDone;
        _password.secureTextEntry = YES;
    }
    return _password;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:[UIImage imageWithColor:HexRGBA(0x0780ed, .2)] forState:UIControlStateDisabled];
        [_loginButton setBackgroundImage:[UIImage imageWithColor:kBackgroundBlueDominantColor] forState:UIControlStateNormal];
        [_loginButton setTitleColor:HexRGBA(0xFFFFFF, .2) forState:UIControlStateDisabled];
        [_loginButton setTitleColor:kTextWhiteDominantColor forState:UIControlStateNormal];
        _loginButton.layer.cornerRadius = kRealWidth(20);
        _loginButton.layer.masksToBounds = YES;

        _loginButton.enabled = NO;
        [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}


#pragma mark - 登录点击事件
- (void)login {
    NSLog(@"=============登录点击事件===================");
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.bgView endEditing:YES];
//    [FNProgressHUD showLoadingWithMaskType:HUDMaskTypeNone];
//    [[FNUserManager shareManager] loginWithUserName:self.userName.text password:self.password.text success:^(id returnData, NSInteger code, NSString *msg) {
//        [FNProgressHUD dismiss];
////        [FNProgressHUD showSuccessWithText:msg toView:self.view];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [FNJumpUtil jumpToRootViewController];
//        });
//    } failure:^(NSError *error) {
//        [FNProgressHUD dismiss];
//        [FNProgressHUD showInfoWithText:error.domain toView:self.bgView];
//    }];

}

#pragma mark 显示密码
- (void)showPassword:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.password.secureTextEntry = !sender.selected;
}


#pragma mark - textField代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self setClearButtonWithField:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self setClearButtonWithField:textField];
}

- (void)setClearButtonWithField:(UITextField *)textField {
    UIButton *clearButton = [textField valueForKey:@"_clearButton"];
    [clearButton setImage:[UIImage imageNamed:@"login_clear"]
                 forState:UIControlStateNormal];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.userName) {
        [self.password becomeFirstResponder];
        return YES;
    }else{
        if (self.password.text.length && self.userName.text.length) {
            [self login];
            return YES;
        }else{
            if (!self.userName.text.length) {

                //                [FNToast showToastWithMessage:@"请输入账号！"];
            }else{
                //                [FNToast showToastWithMessage:@"请输入密码！"];
            }
            return NO;
        }
    }
}
#pragma mark  输入框改变
- (void)textFieldChange{
    if (self.password.text.length && self.userName.text.length) {
        self.loginButton.enabled = YES;
    }else{
        self.loginButton.enabled = NO;
    }
}

@end


@implementation FNLogInTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self changeClearButton];
    }
    return self;
}

- (void)changeClearButton {
    UIButton *clearButton = [self valueForKey:@"_clearButton"];
    [clearButton setImage:[UIImage imageNamed:@"login_clear"]
                 forState:UIControlStateNormal];
}


//文字显示区域
-(CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect rect = [super textRectForBounds:bounds];
    rect.origin.x = rect.origin.x + 10;
    return rect;
}
//编辑区域
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect rect = [super editingRectForBounds:bounds];
    rect.origin.x = rect.origin.x + 10;
    return rect;
}
@end
