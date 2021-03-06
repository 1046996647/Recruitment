//
//  EditResumeVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "EditResumeVC.h"
#import "EditResumeCell.h"
#import "HeaderView.h"
#import "EditJobMsgVC.h"
#import "EditEducationMsgVC.h"
#import "NSStringExt.h"
#import "UIImage+UIImageExt.h"


@interface EditResumeVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) NSArray *titleArr1;
@property (nonatomic,strong) UILabel *signLabel;
@property (nonatomic,strong) UIButton *editBtn;
@property (nonatomic,strong) UILabel *infoLabel;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UILabel *hopeLabel;
@property (nonatomic,strong) UIButton *userBtn;

@property(nonatomic,strong) PersonModel *model;


@end

@implementation EditResumeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 头视图
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    headView.backgroundColor = [UIColor whiteColor];
    
    // 简历信息
    UIButton *userBtn = [UIButton buttonWithframe:CGRectMake(6, 14, 66, 66) text:nil font:nil textColor:nil backgroundColor:nil normal:@"96" selected:nil];
    [userBtn addTarget:self action:@selector(headImgAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:userBtn];
    self.userBtn = userBtn;
    userBtn.layer.cornerRadius = userBtn.height/2;
    userBtn.layer.masksToBounds = YES;
    
    if ([self.title isEqualToString:@"预览"]) {
        userBtn.userInteractionEnabled = NO;
        
    }
    
    // 天天
    UILabel *signLabel = [UILabel labelWithframe:CGRectMake(userBtn.right+16, 11, 40, 18) text:@"" font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [headView addSubview:signLabel];
    self.signLabel = signLabel;
    
    UIButton *editBtn = [UIButton buttonWithframe:CGRectMake(signLabel.right+11, signLabel.top, 20, 20) text:nil font:nil textColor:nil backgroundColor:nil normal:@"95" selected:nil];
    [editBtn addTarget:self action:@selector(personalAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:editBtn];
    self.editBtn = editBtn;
    
    // 女|本科|两年|永嘉
    UILabel *infoLabel = [UILabel labelWithframe:CGRectMake(signLabel.left, editBtn.bottom+5, 300, 14) text:@"" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [headView addSubview:infoLabel];
    self.infoLabel = infoLabel;
    
    // 188426835
    UILabel *phoneLabel = [UILabel labelWithframe:CGRectMake(signLabel.left, infoLabel.bottom+5, 300, 14) text:@"" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [headView addSubview:phoneLabel];
    self.phoneLabel = phoneLabel;
    
    // 我毕业于杭州大学，希望多多看我的简历哦~
    UILabel *hopeLabel = [UILabel labelWithframe:CGRectMake(signLabel.left, phoneLabel.bottom+5, 300, 14) text:@"" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [headView addSubview:hopeLabel];
    self.hopeLabel = hopeLabel;
    
    headView.height = hopeLabel.bottom+12;
    
    NSArray *titleArr1 = @[@"求职意向",@"工作经历",@"教育经历",@"技能特长及自我评价",@"联系方式"];
    self.titleArr1 = titleArr1;
    

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = headView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];

    // 预览
    UIButton *preBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 30, 17) text:@"预览" font:[UIFont systemFontOfSize:14] textColor:@"#030303" backgroundColor:nil normal:nil selected:nil];
    [preBtn addTarget:self action:@selector(preAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:preBtn];
    
    if ([self.title isEqualToString:@"预览"]) {
        editBtn.hidden = YES;
        self.navigationItem.rightBarButtonItem = nil;
    }


}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    [self get_user_info];

}

- (void)headImgAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册选择" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        // 创建相册控制器
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        
        // 设置代理对象
        pickerController.delegate = self;
        // 设置选择后的图片可以被编辑
        //            pickerController.allowsEditing=YES;
        // 设置类型
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 设置为静态图像类型
        pickerController.mediaTypes = @[@"public.image"];
        // 跳转到相册页面
        [self presentViewController:pickerController animated:YES completion:nil];
        
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"手机拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 创建相册控制器
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        
        // 设置代理对象
        pickerController.delegate = self;
        // 设置选择后的图片可以被编辑
        //            pickerController.allowsEditing=YES;
        
        // 判断当前设备是否有摄像头
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear] || [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            
            // 设置类型
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            
        }
        
        // 跳转到相册页面
        [self presentViewController:pickerController animated:YES completion:nil];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];

    [alertController addAction:albumAction];
    [alertController addAction:cameraAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

// 返回用户表该用户相关信息
- (void)get_user_info
{
    // 登录才请求，因为在viewWillAppear里
    PersonModel *model = [InfoCache unarchiveObjectWithFile:Person];

    if (model) {
        NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
        
        [AFNetworking_RequestData requestMethodPOSTUrl:Get_user_info dic:paramDic showHUD:YES Succed:^(id responseObject) {
            
            PersonModel *model = [PersonModel yy_modelWithJSON:responseObject[@"data"]];
            self.model = model;
            
            //        [InfoCache archiveObject:model toFile:Person];
            
            NSMutableArray *arrM = [NSMutableArray array];
            NSArray *arr = responseObject[@"data"][@"jobhistory"];
            
            if ([arr isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in arr) {
                    PersonModel *model1 = [PersonModel yy_modelWithJSON:dic];
                    [arrM addObject:model1];
                }
            }
            
            if (model) {
                self.dataArr = @[@[model],arrM,@[model],@[model],@[model]];
                
            }
            
            [_tableView reloadData];
            
            
            
            [self.userBtn sd_setImageWithURL:[NSURL URLWithString:self.model.img] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"96"]];
            
            
            CGSize size = [NSString textLength:model.name font:self.signLabel.font];
            self.signLabel.width = size.width;
            self.signLabel.text = model.name;
            
            self.editBtn.left = self.signLabel.right+11;
            
            self.infoLabel.text = [NSString stringWithFormat:@"%@|%@cm|%@kg",model.sex,model.height,model.weight];
            
//            self.phoneLabel.text = [NSString stringWithFormat:@"%@  户籍：%@  所在地：%@",model.phone,model.jiguan,model.home];
            self.phoneLabel.text = [NSString stringWithFormat:@"户籍：%@  所在地：%@",model.jiguan,model.home];

            self.hopeLabel.text = [NSString stringWithFormat:@"婚姻状况：%@ 政治面貌：%@ %@年工作经验",model.marry,model.political,model.jobyear];
            
            
            
            
        } failure:^(NSError *error) {
            
        }];
    }
    
}


- (void)preAction
{
    EditResumeVC *vc = [[EditResumeVC alloc] init];
    vc.title = @"预览";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)personalAction
{
    EditJobMsgVC *vc = [[EditJobMsgVC alloc] init];
    vc.title = @"基本信息";
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArr count];
//    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 1;
    if (section == 0) {
        
        if (self.model.requestjobtype.length == 0) {
            return 0;
        }


    } else if (section == 1) {
        
        return [self.dataArr[section] count];

        
    } else if (section == 2) {
        if (self.model.graduatedfrom.length == 0) {
            return 0;
        }

        
    } else if (section == 3) {
        
        if (self.model.foreignlanguage.length == 0) {
            return 0;
        }

        
    } else if (section == 4) {
        if (self.model.phone.length == 0) {
            return 0;
        }

    }
    return 1;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PersonModel *model = self.dataArr[indexPath.section][indexPath.row];

    if (model.cellHeight < 1) {
        return 96;// 默认值

    }
    else {
        return model.cellHeight;

    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if ([self.title isEqualToString:@"预览"]) {
        if (section == 0) {
            
            if (self.model.requestjobtype.length == 0) {
                return 0.0001;
            }
            
            
        }  else if (section == 1) {
            
            if ([self.dataArr[section] count] == 0) {
                return 0.0001;

            }
            
            
        }  else if (section == 2) {
            if (self.model.graduatedfrom.length == 0) {
                return 0.0001;
            }
            
            
        } else if (section == 3) {
            
            if (self.model.foreignlanguage.length == 0) {
                return 0.0001;
            }
            
            
        } else if (section == 4) {
            if (self.model.phone.length == 0) {
                return 0.0001;
            }
            
        }
        
        return 35;
        
    }
    else {
        
        return 35;
    }
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *imgArr = @[@"88",@"89",@"90",@"ic_grid",@"ic_call"];
    HeaderView *headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 35)];
    [headerView.btn setTitle:self.titleArr1[section] forState:UIControlStateNormal];
    [headerView.btn setImage:[UIImage imageNamed:imgArr[section]] forState:UIControlStateNormal];
    
    if (section == 0 || section == 4) {
        headerView.hopeLabel.hidden = YES;
    }
    else {
        headerView.hopeLabel.hidden = NO;

    }
    
    if ([self.title isEqualToString:@"预览"]) {
        if (section == 0) {
            
            if (self.model.requestjobtype.length == 0) {
                return nil;
            }
            
            
        }  else if (section == 1) {
            
            if ([self.dataArr[section] count] == 0) {
                return nil;
                
            }
            
            
        }  else if (section == 2) {
            if (self.model.graduatedfrom.length == 0) {
                return nil;
            }
            
            
        } else if (section == 3) {
            
            if (self.model.foreignlanguage.length == 0) {
                return nil;
            }
            
            
        } else if (section == 4) {
            if (self.model.phone.length == 0) {
                return nil;
            }
            
        }
        
        return headerView;
        
    }
    else {
        
        return headerView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.title isEqualToString:@"预览"]) {
        return 0.0001;// Group不能设置0

    }
    else {
        
        if (section == 0) {
            
            if (self.model.requestjobtype.length == 0) {
                return 62;
            }

            
        }  else if (section == 1) {
            
            return 62;

            
        }  else if (section == 2) {
            if (self.model.graduatedfrom.length == 0) {
                return 62;
            }
            
            
        } else if (section == 3) {
            
            if (self.model.foreignlanguage.length == 0) {
                return 62;
            }

            
        } else if (section == 4) {
            if (self.model.phone.length == 0) {
                return 62;
            }

        }

        return 0.0001;

    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    if ([self.title isEqualToString:@"预览"]) {
//        footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
        return nil;
    }
    else {
        
        NSArray *titleArr = @[@"+ 增加求职意向",@"+ 增加工作经历",@"+ 增加教育经历",@"+ 增加技能特长及自我评价",@"+ 增加联系方式"];
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 62)];
        footView.backgroundColor = [UIColor whiteColor];
        
        UIButton *btn = [UIButton buttonWithframe:CGRectMake(12, 14, kScreen_Width-24, 35) text:titleArr[section] font:[UIFont systemFontOfSize:14] textColor:@"#FF9123" backgroundColor:nil normal:@"" selected:nil];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = [UIColor colorWithHexString:@"#FF9123"].CGColor;
        btn.layer.borderWidth = 1;
        [footView addSubview:btn];
        btn.tag = section;
        [btn addTarget:self action:@selector(footAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (section == 0) {
            
            if (self.model.requestjobtype.length == 0) {
                return footView;
            }
            
            
        }  else if (section == 1) {
            return footView;

            
        }else if (section == 2) {
            if (self.model.graduatedfrom.length == 0) {
                return footView;
            }
            
            
        } else if (section == 3) {
            
            if (self.model.foreignlanguage.length == 0) {
                return footView;
            }
            
            
        } else if (section == 4) {
            if (self.model.phone.length == 0) {
                return footView;
            }
            
        }
        
        return nil;

    }
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EditResumeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[EditResumeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.indexPath = indexPath;
    
    PersonModel *model = self.dataArr[indexPath.section][indexPath.row];
    cell.model = model;
     
    
    if ([self.title isEqualToString:@"预览"]) {
        cell.jobEditBtn.hidden = YES;
        
    }

    return cell;
}

- (void)footAction:(UIButton *)btn
{
    EditEducationMsgVC *vc = [[EditEducationMsgVC alloc] init];
    
    if (btn.tag == 0) {
        vc.title = @"求职意向";

        
    }  else if (btn.tag == 1) {
        
        vc.title = @"编辑工作经历";

    }else if (btn.tag == 2) {

        vc.title = @"教育经历";

        
    } else if (btn.tag == 3) {
        vc.title = @"技能特长及自我评价";

    } else if (btn.tag == 4) {

        vc.title = @"联系方式";

    }
    
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - UIImagePickerControllerDelegate

//选取后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"info:%@",info[UIImagePickerControllerOriginalImage]);
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //通过判断picker的sourceType，如果是拍照则保存到相册去
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    NSData *data = [UIImage imageOrientation:img];
    
    [AFNetworking_RequestData uploadImageUrl:Upload_user_img dic:paramDic data:data Succed:^(id responseObject) {
        
        [self.userBtn sd_setImageWithURL:[NSURL URLWithString:responseObject[@"img"]] forState:UIControlStateNormal];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

//取消后调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//此方法就在UIImageWriteToSavedPhotosAlbum的上方
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"已保存");
}

- (void)back{
    
    if (self.mark == 1) {
        [self.navigationController popToRootViewControllerAnimated:YES];

    }
    else {
        [self.navigationController popViewControllerAnimated:YES];

    }
}

@end
