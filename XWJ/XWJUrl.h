//
//  XWJUrl.h
//  XWJ
//
//  Created by Sun on 15/12/7.
//  Copyright © 2015年 Paul. All rights reserved.
//

#ifndef XWJUrl_h
#define XWJUrl_h


#define MESSAGE_CONTENT @"【信我家】您的信我家验证码为：%d，感谢您的使用！"


//#define XWJBASEURL @"http://115.28.48.166:8100/appPhone/"
#define XWJBASEURL @"http://www.hisenseplus.com:8100/appPhone/rest/"
#define IDCODE_URL @"http://dx.qxtsms.cn/sms.aspx?action=send&userid=%@&account=hisenseplus&password=hisenseplus&mobile=%@&content=%@&sendTime=&checkcontent=1"

#define LOGIN_URL  XWJBASEURL"user/userLogin"
#define REGISTER_URL  XWJBASEURL"user/register"
#define RESETPWD_URL  XWJBASEURL"user/resetPass"


//find

#define GETFINDLIST_URL XWJBASEURL"find/findIndex"
#define GETFIND_URL XWJBASEURL"find/findDetail"

#define GETWUYE_URL XWJBASEURL"sup/supIndex"

#define GETXINFANG_URL XWJBASEURL"house/newHouseIndex"

#define GETXINFANGDETAIL_URL XWJBASEURL"house/houseDetail"
//ad
#define GETACTIVE_URL XWJBASEURL"act/findActPage"
#define GETAD_URL  XWJBASEURL"index/ads"
#define GETENROLL_URL XWJBASEURL"act/enrollAct"
#define GETDETAILAD_URL XWJBASEURL"act/actDetail"
//bind
#define GETCITY_URL  XWJBASEURL"build/getCitys"
#define GETDISTRICT_URL  XWJBASEURL"build/getSubdistrict"
#define GETBUIDING_URL  XWJBASEURL"build/getBuildings"
#define GETROOM_URL  XWJBASEURL"build/getRomes"
//#define GETROOM_URL @"http://www.hisenseplus.com:8100/appPhone/build/getRooms"
#define LOCKROOM_URL  XWJBASEURL"build/lockRooms"


#define YEZHU_URL  XWJBASEURL"build/infoValidate"
#define CHANGEFANGYUAN_URL  XWJBASEURL"build/changeDefault"

//#define GETCITY_URL  XWJBASEURL"build/getCitys"
//#define GETCITY_URL  XWJBASEURL"build/getCitys"

//huodong
#define HUODONG_URL  XWJBASEURL"act/findActPage"


#define AD_URL  XWJBASEURL"index/ads"


#endif /* XWJUrl_h */
