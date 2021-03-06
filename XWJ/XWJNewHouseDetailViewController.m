//
//  XWJNewHouseDetailViewController.m
//  XWJ
//
//  Created by Sun on 15/12/12.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJNewHouseDetailViewController.h"
#import "XWJNewHouseInfoViewController.h"
#import "XWJAccount.h"
#import "XWJHouseMapController.h"
@interface XWJNewHouseDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *houseImg;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;
@property (nonatomic) NSMutableArray *tableData;
@property NSMutableArray *photos;
@property NSMutableArray *buts;

@end

@implementation XWJNewHouseDetailViewController

#define TAG 100
- (void)viewDidLoad {
    [super viewDidLoad];
    
 self.tableData = [NSMutableArray array];
    self.photos = [NSMutableArray array];
    
//    [self.tableData addObjectsFromArray:[NSArray arrayWithObjects:@"开盘 2015-5-1",@"地址 青岛市崂山区崂山路25号",@"状态 在售",@"优惠 交5000可98折 ", nil]];

    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 30)];
    label.textColor = XWJGREENCOLOR;
    label.text = @"楼盘信息";
    [view addSubview:label];
    self.infoTableView.tableHeaderView = view;
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getXinFangdetail];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)shouCang{
    NSString *url = GETXINFANGSHOUCANG_URL;
    
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        /*
         userid	登录用户id	String
         type	类型（1：买新房，2：二手房，3：出租房）	String,1,2,3
         lpId	楼盘id	String
         */
        XWJAccount *account = [XWJAccount instance];
        [dict setValue:[self.dic valueForKey:@"id"]  forKey:@"lpId"];
        [dict setValue:@"1"  forKey:@"type"];
        [dict setValue: account.uid  forKey:@"userid"];
        [dict setValue:@"1" forKey:@"isCollect"];
    
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
        [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%s success ",__FUNCTION__);
            
            if(responseObject){
                NSDictionary *dict = (NSDictionary *)responseObject;
                NSLog(@"dic %@",dict);
                NSNumber *res =[dict objectForKey:@"result"];
                if ([res intValue] == 1) {
                    
                    NSString *errCode = [dict objectForKey:@"errorCode"];
                    UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:nil message:errCode delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    alertview.delegate = self;
                    [alertview show];
                    
//                    [self.navigationController popViewControllerAnimated:YES];
                    
                    
                }
                
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%s fail %@",__FUNCTION__,error);
            
        }];
    
}
-(void)getXinFangdetail{
    NSString *url = GETXINFANGDETAIL_URL;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[self.dic valueForKey:@"id"]  forKey:@"areaId"];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%s success ",__FUNCTION__);
        
        if(responseObject){
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            //            XWJCity *city  = [[XWJCity alloc] init];
            
                         self.dic  = [dic objectForKey:@"house"];
            [self.photos addObjectsFromArray:[dic objectForKey:@"photo"] ];
            
            [self.tableData addObject:[NSString  stringWithFormat:@"开盘 %@",[self.dic objectForKey:@"kpsj"]]] ;
            [self.tableData addObject:[NSString  stringWithFormat:@"地址 %@",[self.dic objectForKey:@"lpmc"]]] ;
            [self.tableData addObject:[NSString  stringWithFormat:@"状态 %@",[self.dic objectForKey:@"zt"]]] ;
            [self.tableData addObject:[NSString  stringWithFormat:@"优惠 %@",[self.dic objectForKey:@"yhxx"]]] ;
//            特点、最新动态、周边配套和详细信息
            [self.tableData addObject:[NSString  stringWithFormat:@"特点 %@",[self.dic objectForKey:@"zxdt"]]] ;
            [self.tableData addObject:[NSString  stringWithFormat:@"最新动态 %@",[self.dic objectForKey:@"yhxx"]]] ;
            [self.tableData addObject:[NSString  stringWithFormat:@"周边配套 %@",[self.dic objectForKey:@"zbpt"]]] ;
            [self.tableData addObject:[NSString  stringWithFormat:@"详细信息 %@",[self.dic objectForKey:@"xxxx"]]] ;

            
            self.nameLabel.text = [self.dic objectForKey:@"lpmc"];
            self.moneyLabel.text = [NSString stringWithFormat:@"开盘 %@",[self.dic objectForKey:@"jiage"]];
            [self.locationBtn setTitle:[self.dic objectForKey:@"weiZhi"] forState:UIControlStateNormal];
            [self.timeBtn setTitle:[self.dic objectForKey:@"kpsj"] forState:UIControlStateNormal];
            
            NSString *houseurl;
            if ([self.dic valueForKey:@"zst"] != [NSNull null]) {
                houseurl = [self.dic  valueForKey:@"zst"];
            }else{
                houseurl = @"";
            }
            
            [self.houseImg sd_setImageWithURL:[NSURL URLWithString:houseurl] placeholderImage:[UIImage imageNamed:@"newhouse"]];
            [self.infoTableView reloadData];
            self.infoTableView.contentSize = CGSizeMake(0, 30*self.tableData.count+60);
            NSInteger count = self.photos.count;
            CGFloat width = self.view.bounds.size.width/3;
            CGFloat height = self.scrollView.bounds.size.height;
            self.scrollView.contentSize = CGSizeMake(width*count, height);
//            if(count>6)
//                count = 6;
            for (int i=0; i<count; i++) {
                UIImageView *button = [[UIImageView alloc ] init];
                button.frame = CGRectMake(width*i, 0, width, height);
                button.tag = TAG+i;
                button.userInteractionEnabled = YES;

                NSString *url;
                if ([[self.photos objectAtIndex:i] valueForKey:@"hxt"] != [NSNull null]) {
                    url = [[self.photos objectAtIndex:i] valueForKey:@"hxt"];
                }else{
                    url = @"";
                }

                [button sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
                UITapGestureRecognizer* singleRecognizer;
                singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
                //点击的次数
                singleRecognizer.numberOfTapsRequired = 1;
                [button addGestureRecognizer:singleRecognizer];

                button.backgroundColor = [UIColor whiteColor];

                [self.scrollView addSubview:button];
            }
            //            [self.houseArr addObjectsFromArray:arr];
            //            [self.tableView reloadData];
                        NSLog(@"dic %@",dic);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%s fail %@",__FUNCTION__,error);
        
    }];
}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer{
//    NSInteger index = iv.tag -TAG;
    UIImageView *iv = (UIImageView *)recognizer.view;
//    NSInteger index=  recognizer.view.tag;
  XWJNewHouseInfoViewController  *vie = [self.storyboard instantiateViewControllerWithIdentifier:@"newhouseinfo"];
//    vie.dic = self.dic;
    vie.dic = [NSMutableDictionary dictionary];
    [vie.dic setDictionary:self.dic];
    [vie.dic setObject:iv.image forKey:@"image"];
    [self.navigationController showViewController:vie sender:nil];
    NSLog(@"click ");
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cztablecell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cztablecell"];
    }
    // Configure the cell...
    cell.textLabel.text = [self.tableData objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)yuyuekanfang:(UIButton *)sender {
    
    NSString *tel = [self.dic objectForKey:@"lxdh"];
    
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",tel];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}
- (IBAction)shoucang:(UIButton *)sender {
    [self shouCang];
}
- (IBAction)ditu:(UIButton *)sender {
    
    XWJHouseMapController *map = [self.storyboard instantiateViewControllerWithIdentifier:@"housemap"];
    NSString *loc  = [self.dic objectForKey:@"gps"];
//    loc = @"36.120";
    if (![loc isEqual:[NSNull null]]) {
        map.lati = [[loc componentsSeparatedByString:@"."][0] floatValue];
        map.lon = [[loc componentsSeparatedByString:@"."][1] floatValue];
        [self.navigationController showViewController:map sender:nil];
    }
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
