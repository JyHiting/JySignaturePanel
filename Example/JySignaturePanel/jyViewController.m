//
//  jyViewController.m
//  JySignaturePanel
//
//  Created by tomy on 07/01/2019.
//  Copyright (c) 2019 tomy. All rights reserved.
//

#import "jyViewController.h"

#import <Masonry.h>
#import <Toast/Toast.h>
#import <JySignaturePanel.h>

@interface jyViewController ()

@property (nonatomic, strong) JySignaturePanel *panel;

@end

@implementation jyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _panel = JySignaturePanel.new;
    _panel.jy_bgColor = [UIColor yellowColor];
    [self.view addSubview:_panel];
    [_panel mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(self.view);
    }];
    
    UIButton *clear = [UIButton buttonWithType:UIButtonTypeCustom];
    clear.backgroundColor = [UIColor grayColor];
    [clear setTitle:@"clear" forState:UIControlStateNormal];
    [clear addTarget:self action:@selector(clearClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clear];
    [clear mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.left.equalTo(self.view).insets(UIEdgeInsetsMake(10, 20, 0, 0));
        make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(100, 30)]);
    }];
    
    UIButton *undo = [UIButton buttonWithType:UIButtonTypeCustom];
    undo.backgroundColor = [UIColor grayColor];
    [undo setTitle:@"undo" forState:UIControlStateNormal];
    [undo addTarget:self action:@selector(undoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:undo];
    [undo mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(clear.mas_bottom).offset(10);
        make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(100, 30)]);
    }];
    
    UIButton *redo = [UIButton buttonWithType:UIButtonTypeCustom];
    redo.backgroundColor = [UIColor grayColor];
    [redo setTitle:@"redo" forState:UIControlStateNormal];
    [redo addTarget:self action:@selector(redoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:redo];
    [redo mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(undo.mas_bottom).offset(10);
        make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(100, 30)]);
    }];
    
    UIButton *fetchImg = [UIButton buttonWithType:UIButtonTypeCustom];
    fetchImg.backgroundColor = [UIColor grayColor];
    [fetchImg setTitle:@"fetchImg" forState:UIControlStateNormal];
    [fetchImg addTarget:self action:@selector(fetchImgClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fetchImg];
    [fetchImg mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(redo.mas_bottom).offset(10);
        make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(100, 30)]);
    }];
    
    UIButton *setBgImg = [UIButton buttonWithType:UIButtonTypeCustom];
    setBgImg.backgroundColor = [UIColor grayColor];
    [setBgImg setTitle:@"setBgImg" forState:UIControlStateNormal];
    [setBgImg addTarget:self action:@selector(setBgImgClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setBgImg];
    [setBgImg mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(clear.mas_right).offset(20);
        make.top.equalTo(clear.mas_top);
        make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(100, 30)]);
    }];
    
    UIButton *isEmpty = [UIButton buttonWithType:UIButtonTypeCustom];
    isEmpty.backgroundColor = [UIColor grayColor];
    [isEmpty setTitle:@"isEmpty" forState:UIControlStateNormal];
    [isEmpty addTarget:self action:@selector(isEmptyClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:isEmpty];
    [isEmpty mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(undo.mas_right).offset(20);
        make.top.equalTo(undo.mas_top);
        make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(100, 30)]);
    }];

}

-(void)clearClick{
    
    [_panel jy_clear];
}

-(void)undoClick{
    
    [self.panel jy_undo];
}

-(void)redoClick{
    [self.panel jy_redo];
}

-(void)setBgImgClick{
    
    _panel.jy_bgImage = [UIImage imageNamed:@"cat.jpg"];
}
-(void)fetchImgClick{
    [_panel jy_fetchImage:^(UIImage * _Nonnull img) {
        
        NSLog(@"------");
    }];
}

-(void)isEmptyClick{
    if (_panel.jy_isEmpty) {
        [self.view makeToast:@"签名为空!!!"];
    }else{
        [self.view makeToast:@"签名不为空!!!"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
