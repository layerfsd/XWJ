//
//  XWJGZmiaoshuViewController.m
//  XWJ
//
//  Created by Sun on 15/12/12.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJGZmiaoshuViewController.h"

@interface XWJGZmiaoshuViewController ()
@property (weak, nonatomic) IBOutlet UILabel *guzhangDanhao;
@property (weak, nonatomic) IBOutlet UILabel *connent;
@property (weak, nonatomic) IBOutlet UIScrollView *jinchangScroll;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel1;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel2;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel3;
@property (weak, nonatomic) IBOutlet UILabel *shoujihao;

@property (weak, nonatomic) IBOutlet UILabel *chuliRen;
@end

@implementation XWJGZmiaoshuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"报修详情";

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.jinchangScroll.frame = CGRectMake(self.jinchangScroll.frame.origin.x, self.jinchangScroll.frame.origin.y, SCREEN_SIZE.width, self.jinchangScroll.frame.size.height);
}

-(void)viewDidAppear:(BOOL)animated{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)getGZDetail{
        NSString *url = GETFGUZHANGDETAIL_URL;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[self.detaildic objectForKey:@"id"] forKey:@"id"];
//        XWJAccount *account = [XWJAccount instance];
//        [dict setValue:account.uid forKey:@"id"];
//        if (self.type==1) {
//
//            [dict setValue:@"维修" forKey:@"type"];
//        }else
//            [dict setValue:@"投诉" forKey:@"type"];
        
        
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
        [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%s success ",__FUNCTION__);
            
            /*
             {"result":"1","data":{"id":20,"code":"1-20151214020","createtime":"12-14 13:10","miaoshu":"内容","zt":"未受理","hfzt":null,"xing":-1,"yytime":"12-14 13:10","yytime1":"1-1 shangwu","slname":null,"gbtime":null,"lwpgsj":null,"lwclr":null,"leixing":"维修"},"errorCode":null}
             */
            if(responseObject){
                NSDictionary *dic = (NSDictionary *)responseObject;
                
                self.detaildic = [NSMutableDictionary dictionaryWithDictionary:[dic objectForKey:@"data"]];
                //            NSMutableArray * array = [NSMutableArray array];
                //            XWJCity *city  = [[XWJCity alloc] init];
                
                //            NSArray *arr  = [dic objectForKey:@"data"];
                //            [self.houseArr removeAllObjects];
                //            [self.houseArr addObjectsFromArray:arr];
                //            [self.tableView reloadData];
                
                
                NSString *errCode = [dict objectForKey:@"errorCode"];
                UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:nil message:errCode delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                alertview.delegate = self;
                [alertview show];
                [self.navigationController popViewControllerAnimated:YES];
                NSLog(@"dic %@",dic);
                [self updateView ];
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%s fail %@",__FUNCTION__,error);
            
        }];
    
}
-(void)updateView{
    self.guzhangDanhao.text = [NSString stringWithFormat:@"%@ %@",[self.detaildic objectForKey:@"createtime"],[self.detaildic objectForKey:@"code"]];
    self.connent.text  = [NSString stringWithFormat:@"%@",[self.detaildic objectForKey:@"miaoshu"]];
    self.chuliRen.text = [NSString stringWithFormat:@"%@",[self.detaildic objectForKey:@"lwclr"]];
    self.shoujihao.text = [NSString stringWithFormat:@"%@",[self.detaildic objectForKey:@"lwpgsj"]];
    self.timeLabel1.text = [NSString stringWithFormat:@"%@",[self.detaildic objectForKey:@"yytime"]];
    self.timeLabel2.text = [NSString stringWithFormat:@"%@",[self.detaildic objectForKey:@"yytime1"]];
    self.timeLabel3.text = [NSString stringWithFormat:@"%@",[self.detaildic objectForKey:@"gbtime"]];
    
}
- (IBAction)pingjia:(UIButton *)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
