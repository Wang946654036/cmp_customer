//
//  ZSAlertView.m
//  Runner
//
//  Created by BZL on 2019/6/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "ZSAlertView.h"

@interface ZSAlertView () <UIAlertViewDelegate,UIActionSheetDelegate>

@end

@implementation ZSAlertView

+ (ZSAlertView *)sharedInstance
{
    static ZSAlertView *sharedAlertInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAlertInstance = [[self alloc] init];
    });
    return sharedAlertInstance;
}
#pragma mark--alertView
- (void)showAlertController:(UIViewController *)viewController
                      title:(NSString *)title
                    message:(NSString *)message
                cancelTitle:(NSString *)cancelTitle
                actionBlock:(actionBlock)block
          otherButtonTitles:(NSString *)otherButtonTitles, ...  {
    self.alertBlcok = block;
    // 读取可变参数里面的titles数组
    NSMutableArray *titlesArray = [[NSMutableArray alloc] initWithCapacity:0];
    va_list list;
    if(otherButtonTitles) {
        //1.取得第一个参数的值(即是buttonTitles)
        [titlesArray addObject:otherButtonTitles];
        //2.从第2个参数开始，依此取得所有参数的值
        NSString *otherTitle;
        va_start(list, otherButtonTitles);
        while ((otherTitle = va_arg(list, NSString*))) {
            [titlesArray addObject:otherTitle];
        }
        va_end(list);
    }
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0){
        
        [self showAlertController:viewController title:title message:message cancelTilte:cancelTitle otherTitleArray:titlesArray actionBlock:^(NSInteger buttonTag) {
            if (self.alertBlcok) {
                self.alertBlcok(buttonTag);
            }
        }];
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles: nil];
        for(NSString *otherTitle in titlesArray){
            [alert addButtonWithTitle:otherTitle];
        }
        [alert show];
    }
    
    
}
//alert封装
- (void)showAlertController:(UIViewController *)viewController
                      title:(NSString *)title
                    message:(NSString *)message
                cancelTilte:(NSString *)cancelTitle
            otherTitleArray:(NSArray *)otherTitleArray
                actionBlock:(actionBlock)block {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // 下面两行代码 是修改 title颜色和字体的代码
     NSAttributedString *attributedMessage = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0f], NSForegroundColorAttributeName:[UIColor blackColor]}];
     [alert setValue:attributedMessage forKey:@"attributedTitle"];
    if (cancelTitle) {
        // 取消
        UIAlertAction  *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            block(0);
        }];
        [alert addAction:cancelAction];
    }
    
    if (otherTitleArray.count>0) {
        for (NSInteger i = 0; i<otherTitleArray.count; i++) {
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherTitleArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                block(i+1);
            }];
            // [action setValue:[UIColor redColor] forKey:@"titleTextColor"]; // 此代码 可以修改按钮颜色
            [alert addAction:otherAction];
        }
        
    }
    
    [viewController presentViewController:alert animated:YES completion:nil];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.alertBlcok) {
        self.alertBlcok(buttonIndex);
    }
}
#pragma mark--actionSheet
- (void)showActionSheetController:(UIViewController *)viewController
                            title:(NSString *)title
                          message:(NSString *)message
                      cancelTitle:(NSString *)cancelTitle
                      destructive:(NSString *)destructive
                      actionBlock:(actionBlock)block
                otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self.sheetBlcok = block;
    // 读取可变参数里面的titles数组
    NSMutableArray *titlesArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    va_list list;
    if(otherButtonTitles) {
        //1.取得第一个参数的值(即是buttonTitles)
        [titlesArray addObject:otherButtonTitles];
        //2.从第2个参数开始，依此取得所有参数的值
        NSString *otherTitle;
        va_start(list, otherButtonTitles);
        while ((otherTitle = va_arg(list, NSString*))) {
            [titlesArray addObject:otherTitle];
        }
        va_end(list);
    }
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]){
        [self showActionSheetController:viewController title:title message:message cancelTitle:cancelTitle destructive:destructive titlesArray:titlesArray actionBlock:^(NSInteger buttonTag) {
            if (self.sheetBlcok) {
                self.sheetBlcok(buttonTag);
            }
        }];
    }
    else{
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cancelTitle destructiveButtonTitle:destructive otherButtonTitles:nil];
        for(NSString *otherTitle in titlesArray){
            [sheet addButtonWithTitle:otherTitle];
        }
        [sheet showInView:viewController.view];
    }
    
}
// ActionSheet的封装

- (void)showActionSheetController:(UIViewController *)viewController
                            title:(NSString *)title
                          message:(NSString *)message
                      cancelTitle:(NSString *)cancelTitle
                      destructive:(NSString *)destructive
                      titlesArray:(NSArray *)titlesArray
                      actionBlock:(actionBlock)block{
    
    
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    if (cancelTitle) {
        UIAlertAction  *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (self.sheetBlcok) {
                self.sheetBlcok(0);
            }
        }];
        [sheet addAction:cancelAction];
    }
    if (destructive) {
        UIAlertAction  *destructiveAction = [UIAlertAction actionWithTitle:destructive style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if (self.sheetBlcok) {
                self.sheetBlcok(-1);
            }
        }];
        [sheet addAction:destructiveAction];
    }
    if (titlesArray.count > 0) {
        for (NSInteger i = 0; i<titlesArray.count; i++) {
            UIAlertAction  *action = [UIAlertAction actionWithTitle:titlesArray[i]
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                self.sheetBlcok(i+1);
                                                            }];
            [sheet addAction:action];
        }
    }
    [viewController presentViewController:sheet animated:YES completion:nil];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.sheetBlcok) {
        self.sheetBlcok(buttonIndex);        
    }
}

@end
