//
//  CGKeyboardInputCollectionViewCell.m
//  CGProjectTest
//
//  Created by LeoCai on 8/26/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGKeyboardInputCollectionViewCell.h"
#import "Masonry.h"
#import "CGMarco.h"

@interface CGKeyboardInputCollectionViewCell()
@property (strong, nonatomic) UITextField *input;
@property (strong, nonatomic) UILabel *separatorLine;
@property (strong, nonatomic) NSMutableArray *inputStack;
@end

@implementation CGKeyboardInputCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _inputStack = [NSMutableArray array];
        [self configure:nil];
    }
    return self;
}

#pragma mark - lazy subviews
-(UITextField *)input{
    if (!_input) {
        _input = [UITextField new];
        _input.textAlignment = NSTextAlignmentRight;
        _input.enabled = NO;
        [self.contentView addSubview:_input];
        
        CGFloat padding  = 5.f;
        [_input mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(padding);
            make.right.equalTo(self.contentView).offset(-padding);
            make.bottom.equalTo(self.contentView).offset(-ONE_PIXEL);
        }];
    }
    return _input;
}

-(UILabel *)separatorLine{
    if (!_separatorLine) {
        _separatorLine = [UILabel new];
        [self.contentView addSubview:self.separatorLine];
        
        [_separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.input.mas_bottom);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.height.mas_equalTo(ONE_PIXEL);
        }];
    }
    return _separatorLine;
}

#pragma mark - setter/getter
-(NSString *)getInputText{
    return self.input.text;
}

-(void)setInputText:(NSString *)text{
    self.input.text = text;
}

#pragma mark - configure
-(void)configure:(NSObject *)object{
    self.input.placeholder = @"0.00";
    self.separatorLine.backgroundColor = [UIColor lightGrayColor];
}

-(void)inputText:(NSString *)text{
    NSString *originText = self.input.text;
    if (originText.length == 0) {
        if([text isEqualToString:@"."]){
            [self setInputText:@"0."];
            return;
        }
        if ([text isEqualToString:@"+"]||
            [text isEqualToString:@"-"]) {
            return;// 第一个输入为“0”，禁止输入
        }
    }else if (originText.length == 1) {
        if ([originText isEqualToString:@"0"]){
            if (![text isEqualToString:@"+"]&&![text isEqualToString:@"-"]&&![text isEqualToString:@"."]) {
                [self setInputText:text];
                return;
            }else{
                return;
            }
        }
    }
    
    NSString *lasObejct = [_inputStack lastObject];
    // 输入为普通数字
    if (![text isEqualToString:@"+"]&&![text isEqualToString:@"-"]&&![text isEqualToString:@"."]) {
        if ([lasObejct rangeOfString:@"."].location != NSNotFound) {
            NSArray *temp = [lasObejct componentsSeparatedByString:@"."];
            if ([temp.lastObject length] >= 2) {// 小数点后最多输入两位
                return;
            }
        }else if([lasObejct length] > 7) {//整数部分不超过9位
            return;
        }else if([lasObejct isEqualToString:@"0"]){
            if (_inputStack.count > 1) {
                return;
            }
        }
    }
    
    // 输入为“.”
    if ([text isEqualToString:@"."]) {
        if ([lasObejct rangeOfString:@"."].location != NSNotFound) {
            return;
        }else{
            if ([lasObejct isEqualToString:@"+"]||[lasObejct isEqualToString:@"-"]) {
                text = @"0.";
            }
        }
    }
    
    // 输入为“+”或者“-”，入栈并进行运算。
    if ([text isEqualToString:@"+"]||[text isEqualToString:@"-"]) {// 点击“加号”
        if ([lasObejct isEqualToString:@"+"] || [lasObejct isEqualToString:@"-"]) {
            return;
        }
        
        NSInteger pre = _inputStack.count - 2;
        if (pre > 0) {
            NSString *key = _inputStack[pre];
            if ([key isEqualToString:@"+"]||[key isEqualToString:@"-"]) {
                [self enterInput:text];
                return;
            }
        }
    }
    
    NSString *newText = [NSString stringWithFormat:@"%@%@",originText,text];
    self.input.text = newText;
    
    [self updateStack];
}

// 删除当前输入
-(void)deletInput{
    NSString *text = [self getInputText];
    NSUInteger len = text.length;
    switch (len) {
        case 0:
            break;
        case 1:
            [self setInputText:@""];
            break;
        default:
        {
            NSString *newText = [text substringToIndex:len - 1];
            [self setInputText:newText];
        }
            break;
    }
    
    [_inputStack removeAllObjects];
    [self updateStack];
}

// 回车计算
-(void)enterInput:(NSString *)key{
    if (_inputStack.count < 2) {
        return;
    }
    CGFloat num1 = [_inputStack[0] floatValue];
    NSString *opreator = _inputStack[1];
    CGFloat num2 = [_inputStack[2] floatValue];
    CGFloat num;
    if ([opreator isEqualToString:@"+"]) {
        num = num1 + num2;// 加法
    }else if ([opreator isEqualToString:@"-"]) {
        num = num1 - num2;// 减法
    }
    NSString *numStr = [NSString stringWithFormat:@"%.2f",num];
    NSString *text = numStr;
    if (key) {
        text = [NSString stringWithFormat:@"%@%@",numStr,key];
    }
    
    // 如果小数点后面为0，就删除
    NSArray *array = [text componentsSeparatedByString:@"."];
    NSString *lastObject = [array lastObject];
    if ([lastObject isEqualToString:@"00"]) {
        text = [text stringByReplacingOccurrencesOfString:@".00" withString:@""];
    }else{
        NSString *lastStr = [lastObject substringFromIndex:lastObject.length - 1];
        if ([lastStr isEqualToString:@"0"]) {
            text = [text substringToIndex:text.length-1];
        }
    }
    
    [self setInputText:text];
    [_inputStack removeAllObjects];
    [self updateStack];
}

-(void)updateStack{
    NSArray *array;
    NSString *inputText = [self getInputText];
    NSString *opreator;
    if ([inputText rangeOfString:@"+"].location != NSNotFound) {
        opreator = @"+";
        array = [inputText componentsSeparatedByString:@"+"];
        
    }else if ([inputText rangeOfString:@"-"].location != NSNotFound){
        opreator = @"-";
        array = [inputText componentsSeparatedByString:@"-"];
    }else{
        [_inputStack removeLastObject];
        [_inputStack addObject:inputText];
        NSLog(@"array:%@",array);
        NSLog(@"_inputStack:%@",_inputStack);
        return;
    }
    
    _inputStack = [NSMutableArray arrayWithArray:array];
    if ([[_inputStack lastObject] isEqualToString:@""]) {
        [_inputStack removeLastObject];
    }
    [_inputStack insertObject:opreator atIndex:1];
    NSLog(@"array:%@",array);
    NSLog(@"_inputStack:%@",_inputStack);
}

@end
