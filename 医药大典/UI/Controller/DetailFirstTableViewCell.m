//
//  DetailFirstTableViewCell.m
//  医药大典
//
//  Created by qf on 15/10/16.
//  Copyright (c) 2015年 fanzhirong. All rights reserved.
//

#import "DetailFirstTableViewCell.h"
#import "DetailFirstBean.h"
@interface DetailFirstTableViewCell ()

@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UILabel *content;
@property (nonatomic,strong)UILabel *date;

@end
@implementation DetailFirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _title = [[UILabel alloc]init];
        _title.font = [UIFont systemFontOfSize:16];
        _title.textColor = [UIColor blackColor];
        _title.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_title];
        
        NSArray *array = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_title]-3-|" options:0 metrics:nil views:@{@"_title":_title}];
        [self addConstraints:array];
        array = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-3-[_title(16)]" options:0 metrics:nil views:@{@"_title":_title}];
        [self addConstraints:array];
        
        _content = [[UILabel alloc]init];
        _content.font = [UIFont systemFontOfSize:12];
        _content.numberOfLines = 2;
        _content.lineBreakMode = NSLineBreakByTruncatingTail;
        _content.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_content];
        
        array = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_content]-3-|" options:0 metrics:nil views:@{@"_content":_content}];
        [self addConstraints:array];
        array = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-23-[_content(30)]" options:0 metrics:nil views:@{@"_content":_content}];
        [self addConstraints:array];
        
        _date = [[UILabel alloc]init];
        _date.font = [UIFont systemFontOfSize:12];
        _date.textColor = [UIColor grayColor];
        _date.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_date];
        
        array = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_date]-3-|" options:0 metrics:nil views:@{@"_date":_date}];
        [self addConstraints:array];
        array = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-55-[_date(16)]" options:0 metrics:nil views:@{@"_date":_date}];
        [self addConstraints:array];
    }
    return self;
}

-(void)setCellData:(id)data
{
    DetailFirstBean *bean = data;
    _title.text = bean.title;
    NSString *str = bean.content;
    str = [str stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"<P>" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"<span>" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"</P>" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"</span>" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"<STRONG>" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"</STRONG>" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    str = [str stringByReplacingOccurrencesOfString:@"&#8211;" withString:@" "];
    _content.text = str;
    
    
//    NSPredicate *pe = [NSPredicate predicateWithFormat:@"content LIKE<\S>"];
//    NSArray *arr = [data filteredArrayUsingPredicate:pe];

    _date.text = bean.date;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
