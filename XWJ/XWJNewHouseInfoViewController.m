//
//  XWJNewHouseInfoViewController.m
//  XWJ
//
//  Created by Sun on 15/12/12.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJNewHouseInfoViewController.h"

@interface XWJNewHouseInfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *houseImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *directionLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property NSMutableDictionary *dict;
@end

@implementation XWJNewHouseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dict = [NSMutableDictionary dictionary];
    self.navigationItem.title = @"信息";
    // Do any additional setup after loading the view.
    self.houseImg.image = [self.dic objectForKey:@"image"];
    self.titleLabel.text = [self.dic valueForKey:@"lpmc"];
    self.sizeLabel.text =[self.dic objectForKey:@"lpmc"];
    self.totalLabel.text = [NSString stringWithFormat:@"%@",[self.dic objectForKey:@"jiage"]] ;
    self.firstLabel.text = [self.dic objectForKey:@"lpmc"];
    self.directionLabel.text =[self.dic objectForKey:@"lpmc"];
    
    [self getXinFangInfo];
}


/*
 
 data =     {
 Wei = 3;
 cx = "\U53cc\U5357";
 hxmc = "\U56db\U5ba4\U4e24\U5385\U4e09\U536b";
 hxt = "http://www.hisenseplus.com/HisenseUpload/loupan/B2015129103321.png";
 id = 12;
 mj = "290.33";
 sf = 300000;
 shi = 4;
 ting = 2;
 yang = 6;
 zj = 450000;
 };
 */
-(void)updateView{
//    self.titleLabel.text = [self.dict valueForKey:@"lpmc"];
//    self.sizeLabel.text =[self.dict objectForKey:@"lpmc"];
//    self.totalLabel.text = [NSString stringWithFormat:@"%@",[self.dic objectForKey:@"jiage"]] ;
//    self.firstLabel.text = [self.dic objectForKey:@"lpmc"];
//    self.directionLabel.text =[self.dic objectForKey:@"lpmc"];
 
    NSString *hx = [NSString stringWithFormat:@"%@室%@厅%@卫",[self.dict objectForKey:@"shi"],[self.dict objectForKey:@"ting"],[self.dict objectForKey:@"Wei"]];
    self.titleLabel.text = hx;
    self.navigationItem.title = hx;
    self.sizeLabel.text =[NSString stringWithFormat:@"面积：%@", [self.dict objectForKey:@"mj"]];
    self.totalLabel.text = [NSString stringWithFormat:@"总价：%@",[self.dict objectForKey:@"zj"]];
    self.firstLabel.text = [NSString stringWithFormat:@"首付：%@",[self.dict objectForKey:@"sf"]];
    self.directionLabel.text =[NSString stringWithFormat:@"朝向：%@",[self.dict objectForKey:@"cx"]];
}

-(void)getXinFangInfo{
    NSString *url = GETXINFANGHXT_URL;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[self.dic valueForKey:@"id"]  forKey:@"styleId"];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%s success ",__FUNCTION__);
        
        if(responseObject){
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            //            XWJCity *city  = [[XWJCity alloc] init];
            
            self.dict  = [dic objectForKey:@"data"];

            [self updateView];
            //            [self.houseArr addObjectsFromArray:arr];
            //            [self.tableView reloadData];
            NSLog(@"dic %@",dic);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%s fail %@",__FUNCTION__,error);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
