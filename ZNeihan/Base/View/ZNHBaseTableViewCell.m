//
//  ZNHBaseTableViewCell.m
//  ZNeihan
//
//  Created by zengruofan on 16/10/28.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import "ZNHBaseTableViewCell.h"

@implementation ZNHBaseTableViewCell

-(UITableView *)table {
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 7.0) {
        //UITableViewCell—>UITableViewCellScrollView—>UITableCellContentView。
        return (UITableView *)self.superview.superview;
    } else {
        //UITableViewCell—>UITableCellContentView。
        return (UITableView *)self.superview;
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//  快速创建一个不是从xib中加载的tableview cell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    if (tableView == nil) {
        return [[self alloc] init];
    }
    NSString *className = NSStringFromClass([self class]);
    NSString *identifier = [className stringByAppendingString:@"CellID"];
    [tableView registerClass:[self class] forHeaderFooterViewReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

//  快速创建一个从xib中加载的tableview cell
+ (instancetype)nibCellWithTableView:(UITableView *)tableView {
    if (tableView == nil) {
        return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
    }
    NSString *className = NSStringFromClass([self class]);
    NSString *identifier = [className stringByAppendingString:@"nibCellID"];
    UINib *nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    return [tableView
             dequeueReusableCellWithIdentifier:identifier];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
