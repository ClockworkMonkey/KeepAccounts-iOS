//
//  WRGLoginViewController.m
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/7/24.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGLoginViewController.h"

static CGFloat const kSeparatorW = 0.5f;
static CGFloat const kIconMaxWH = 90.f;
static CGFloat const kIconMinWH = 60.f;

@interface WRGLoginViewController () <CAAnimationDelegate>
@property (nonatomic, strong) UIView *topContentView;
@property (nonatomic, strong) UIView *centerContentView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIImageView *appIconImageView;
@property (nonatomic, strong) UILabel *appADLabel;
@property (nonatomic, strong) UILabel *appNameLabel;
@property (nonatomic, strong) UITextField *accountField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UILabel *reminderLabel;
@property (nonatomic, assign) NSTimeInterval keyboardAnimationDuration;
@end

@implementation WRGLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    [self setupLoginView];
    [self addNotificationObserver];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self removeNotificationObserver];
}

- (void)addNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideAction:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeNotificationObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)setupLoginView {
    
    self.view.backgroundColor = COLOR_UI_WHITE;
    
    self.backButton = [[UIButton alloc] init];
    [self.view addSubview:self.backButton];
    [self.backButton setImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.topContentView = [[UIView alloc] init];
    [self.view addSubview:self.topContentView];
    
    self.appIconImageView = [[UIImageView alloc] init];
    [self.topContentView addSubview:self.appIconImageView];
    self.appIconImageView.image = [UIImage imageNamed:@"TestImage"];
    self.appIconImageView.layer.borderColor = COLOR_UI_GRAY.CGColor;
    self.appIconImageView.layer.borderWidth = 2.f;
    self.appIconImageView.layer.cornerRadius = 10.f;
    self.appIconImageView.layer.masksToBounds = YES;
    
    self.appNameLabel = [UILabel labelWithFontSize:20.f text:@"网易·有钱"];
    [self.topContentView addSubview:self.appNameLabel];
    self.appNameLabel.adjustsFontSizeToFitWidth = YES;
    self.appNameLabel.minimumScaleFactor = 0.1f;
    self.appNameLabel.textAlignment = NSTextAlignmentCenter;
    self.appNameLabel.textColor = COLOR_TEXT_DEFAULT;
    
    self.appADLabel = [UILabel labelWithFontSize:8.f text:@"专 业 记 账 管 钱 软 件"];
    [self.topContentView addSubview:self.appADLabel];
    self.appADLabel.adjustsFontSizeToFitWidth = YES;
    self.appADLabel.minimumScaleFactor = 0.1f;
    self.appADLabel.textAlignment = NSTextAlignmentCenter;
    self.appADLabel.textColor = COLOR_TEXT_DEFAULT;
    
    /** 中间的View 包含：输入框、登录按钮、注册和忘记密码 */
    self.centerContentView = [[UIView alloc] init];
    [self.view addSubview:self.centerContentView];
    
    UIView *inputView = [[UIView alloc] init];
    [self.centerContentView addSubview:inputView];
    
    UIImageView *acIconImageView = [[UIImageView alloc] init];
    [inputView addSubview:acIconImageView];
    acIconImageView.image = [UIImage imageNamed:@"TestImage"];
    
    self.accountField = [[UITextField alloc] init];
    [inputView addSubview:self.accountField];
    self.accountField.clearButtonMode = UITextFieldViewModeAlways;
    self.accountField.placeholder = @"请输入网易邮箱账号";
    self.accountField.font = [UIFont systemFontOfSize:13];
    self.accountField.textColor = COLOR_TEXT_DEFAULT;
    self.accountField.keyboardType = UIKeyboardTypeEmailAddress;
    
    UIView *acSeparatorView = [[UIView alloc] init];
    [inputView addSubview:acSeparatorView];
    acSeparatorView.backgroundColor = COLOR_UI_GRAY;
    
    UIImageView *pwIconImageView = [[UIImageView alloc] init];
    [inputView addSubview:pwIconImageView];
    pwIconImageView.image = [UIImage imageNamed:@"TestImage"];
    
    self.passwordField = [[UITextField alloc] init];
    [inputView addSubview:self.passwordField];
    self.passwordField.clearButtonMode = UITextFieldViewModeAlways;
    self.passwordField.placeholder = @"请输入账号密码";
    self.passwordField.font = [UIFont systemFontOfSize:13.f];
    self.passwordField.textColor = COLOR_TEXT_DEFAULT;
    self.passwordField.keyboardType = UIKeyboardTypeASCIICapable;
    
    UIView *pwSeparatorView = [[UIView alloc] init];
    [inputView addSubview:pwSeparatorView];
    pwSeparatorView.backgroundColor = COLOR_UI_GRAY;
    
    self.reminderLabel = [UILabel labelWithFontSize:12.f text:@""];
    [self.centerContentView addSubview:self.reminderLabel];
    self.reminderLabel.textColor = COLOR_TEXT_RED;
    
    UIButton *loginButton = [[UIButton alloc] init];
    [self.centerContentView addSubview:loginButton];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:COLOR_TEXT_WHITE forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:20.f];
    loginButton.layer.cornerRadius = 3.f;
    loginButton.layer.masksToBounds = YES;
    loginButton.backgroundColor = COLOR_UI_RED;
    
    UIView *registerAndForgetPasswordView = [[UIView alloc] init];
    [self.centerContentView addSubview:registerAndForgetPasswordView];
    
    UIButton *registerButton = [[UIButton alloc] init];
    [self.centerContentView addSubview:registerButton];
    [registerButton setTitle:@"注册网易账号" forState:UIControlStateNormal];
    [registerButton setTitleColor:COLOR_TEXT_GRAY forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:10.f];
    
    UIView *rafSeparatorView = [[UIView alloc] init];
    [registerAndForgetPasswordView addSubview:rafSeparatorView];
    rafSeparatorView.backgroundColor = COLOR_UI_GRAY;
    
    UIButton *forgetPasswordButton = [[UIButton alloc] init];
    [self.centerContentView addSubview:forgetPasswordButton];
    [forgetPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPasswordButton setTitleColor:COLOR_TEXT_GRAY forState:UIControlStateNormal];
    forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:10.f];
    
    UIView *otherMethodLoginView = [[UIView alloc] init];
    [self.view addSubview:otherMethodLoginView];
    otherMethodLoginView.backgroundColor = COLOR_RANDOM;
    
    UIView *omlSeparatorView = [[UIView alloc] init];
    [otherMethodLoginView addSubview:omlSeparatorView];
    omlSeparatorView.backgroundColor = COLOR_UI_GRAY;
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).inset(kMargin);
        } else {
            make.top.equalTo(self.view.mas_top).inset(kMargin);
        }
        make.left.equalTo(self.view).offset(kMargin);
        make.width.height.mas_equalTo(25.f);
    }];
    
    [self.topContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backButton.mas_bottom).offset(kMargin * 3.f);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(kIconMaxWH);
        make.bottom.equalTo(self.appADLabel.mas_bottom);
    }];
    
    [self.appIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topContentView);
        make.left.right.equalTo(self.topContentView).inset(kMargin * 0.5f);
        make.height.mas_equalTo(self.appIconImageView.mas_width);
    }];
    
    [self.appNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.appIconImageView.mas_bottom).offset(kMargin * 0.5f);
        make.left.right.equalTo(self.topContentView);
    }];

    [self.appADLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.appNameLabel.mas_bottom);
        make.left.right.equalTo(self.topContentView);
    }];
    
    [self.centerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(kMargin * 3);
        make.left.right.equalTo(self.view);
    }];
    
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.centerContentView);
        make.height.mas_equalTo(100.f);
    }];
    
    [acIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(inputView).inset(15.f);
        make.width.height.mas_equalTo(20.f);
    }];
    
    [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputView).inset(kMargin);
        make.left.equalTo(acIconImageView.mas_right).offset(kMargin);
        make.right.equalTo(inputView).inset(kMargin);
        make.height.mas_equalTo(30.f);
    }];
    
    [acSeparatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(inputView).inset(kMargin);
        make.top.equalTo(self.accountField.mas_bottom).offset(kMargin - kSeparatorW);
        make.height.mas_equalTo(kSeparatorW);
    }];
    
    [pwIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(acSeparatorView.mas_bottom).offset(15.f);
        make.left.equalTo(inputView).inset(15.f);
        make.width.height.mas_equalTo(20.f);
    }];
    
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(acSeparatorView).offset(kMargin);
        make.left.equalTo(pwIconImageView.mas_right).offset(kMargin);
        make.right.equalTo(inputView).inset(kMargin);
        make.height.mas_equalTo(30.f);
    }];
    
    [pwSeparatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(inputView).inset(kMargin);
        make.top.equalTo(self.passwordField.mas_bottom).offset(kMargin - kSeparatorW);
        make.height.mas_equalTo(kSeparatorW);
    }];
    
    [self.reminderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(inputView.mas_bottom).offset(kMargin * 0.5f);
        make.left.right.equalTo(self.centerContentView).inset(kMargin * 2.f);
        make.height.mas_equalTo(kMargin * 2.f);
    }];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.reminderLabel.mas_bottom).offset(kMargin * 1.f);
        make.left.right.equalTo(self.centerContentView).inset(kMargin * 2.f);
    }];
    
    [registerAndForgetPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton.mas_bottom).offset(kMargin / 2.f);
        make.left.bottom.right.equalTo(self.centerContentView);
    }];
    
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(registerAndForgetPasswordView);
        make.right.equalTo(rafSeparatorView.mas_left).inset(kMargin * 2.f);
    }];
    
    [rafSeparatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(registerAndForgetPasswordView);
        make.top.bottom.equalTo(registerAndForgetPasswordView).inset(kMargin / 2.f);
        make.width.mas_equalTo(kSeparatorW);
    }];
    
    [forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(registerAndForgetPasswordView);
        make.left.equalTo(rafSeparatorView.mas_right).offset(kMargin * 2.f);
    }];
    
    [otherMethodLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).inset(kMargin);
        } else {
            make.bottom.equalTo(self.view.mas_bottom).inset(kMargin);
        }
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(150.f);
        make.height.mas_equalTo(50.f);
    }];
    
    [omlSeparatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(otherMethodLoginView);
        make.top.bottom.equalTo(otherMethodLoginView).inset(kMargin / 2.f);
        make.width.mas_equalTo(kSeparatorW);
    }];
}

- (void)loginButtonAction {
    NSString *email = self.accountField.text;
    NSString *password = self.passwordField.text;
    
    if (![self validateEmail:email]) {
        self.reminderLabel.text = @"邮箱格式不正确";
        return;
    }
    
    if (![self validatePassword:password]) {
        self.reminderLabel.text = @"密码格式不正确";
        return;
    }
    
//    [self loginWithEMail:email password:password];
}


- (BOOL)validateEmail:(NSString *)emailString {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:emailString];
}

- (BOOL)validatePassword:(NSString *)passwordString {
    NSString *passwordRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *passwordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordPredicate evaluateWithObject:passwordString];
}

- (void)backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)keyboardWillShowAction:(NSNotification *)notification {
    CGRect keyboardRect = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    self.keyboardAnimationDuration = [notification.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    CGFloat keyboardY = keyboardRect.origin.y;
    CGFloat centerViewMaxY = CGRectGetMaxY(self.centerContentView.frame);
    CGFloat offY = keyboardY - centerViewMaxY;
    if (offY < 0) {
        [UIView animateWithDuration:self.keyboardAnimationDuration animations:^{
            self.centerContentView.transform = CGAffineTransformMakeTranslation(0, offY - 15.f);
        }];
        
        [self updateTopContentViewPositionAndScale];
    }
}

- (void)keyboardWillHideAction:(NSNotification *)notification {
    self.keyboardAnimationDuration = [notification.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    [UIView animateWithDuration:self.keyboardAnimationDuration animations:^{
        self.centerContentView.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
    
    [self reverseTopContentViewPositionAndScale];
}

- (void)updateTopContentViewPositionAndScale {
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    CGFloat backButtonMaxY = CGRectGetMaxY(self.backButton.frame);
    CGPoint fromPoint = self.topContentView.layer.position;
    CGPoint toPoint = CGPointMake(fromPoint.x, backButtonMaxY + kMargin + kIconMinWH * 0.5f);
    positionAnimation.fromValue = [NSValue valueWithCGPoint:fromPoint];
    positionAnimation.toValue = [NSValue valueWithCGPoint:toPoint];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    scaleAnimation.toValue = [NSNumber numberWithFloat:kIconMinWH / kIconMaxWH];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.delegate = self;
    animationGroup.duration = self.keyboardAnimationDuration;
    animationGroup.repeatCount = 1.f;
    animationGroup.animations = @[positionAnimation, scaleAnimation];
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    [self.topContentView.layer addAnimation:animationGroup forKey:@"Position_Scale"];
}

- (void)reverseTopContentViewPositionAndScale {
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    CGFloat backButtonMaxY = CGRectGetMaxY(self.backButton.frame);
    CGPoint position = self.topContentView.layer.position;
    CGPoint fromPoint = CGPointMake(position.x, backButtonMaxY + kMargin + kIconMinWH * 0.5f);
    CGPoint toPoint = position;
    positionAnimation.fromValue = [NSValue valueWithCGPoint:fromPoint];
    positionAnimation.toValue = [NSValue valueWithCGPoint:toPoint];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:kIconMinWH / kIconMaxWH];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.f];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.delegate = self;
    animationGroup.duration = self.keyboardAnimationDuration;
    animationGroup.repeatCount = 1.f;
    animationGroup.animations = @[positionAnimation, scaleAnimation];
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    [self.topContentView.layer addAnimation:animationGroup forKey:@"Position_Scale_Reverse"];
}

- (void)loginWithEMail:(NSString *)email password:(NSString *)password {
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/users/login.do"];
    NSString *paramsStr = [NSString stringWithFormat:@"email=%@&password=%@", email, password];
    NSData *paramsData = [paramsStr dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = paramsData;
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"%@", dic);
        }
    }];
    
    [task resume];
}

@end
