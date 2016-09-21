//
//  ZXServerAddressUtil.h
//  QiaoGu
//
//  Created by JackLiu on 14-8-20.
//  Copyright (c) 2014年 ZXInsight. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    UAT = 0,       //测试环境
    PROD = 1,      //生产环境
} EviromentMode;

@interface ZXServerAddressUtil : NSObject

+ (ZXServerAddressUtil *)sharedInstance;

- (void)setEviromentMode:(EviromentMode)mode;
-(NSString *)getChangePswUrl:(NSString *)apptoken autotoken:(NSString *)autotoken;
/**
 *  用户登录验证判断
 *  /mapi/[APP_TOKEN]/login
 *  eg: http://qiaogu.local.com/mapi/qiaogu/login?username=user1&password=111111
 */
- (NSString *)getLoginAddressWithAppToken:(NSString *)appToken;

/**
 *  用户Profile信息
 *  /mapi/[APP_TOKEN]/[MOBILE_AUTO_TOKEN]/user/profile
 *  eg: http://qiaogu.local.com/mapi/qiaogu/f37ae9e9c69da1843926d13350a743d3/user/profile
 */
- (NSString *)getProfileAddressWithAppToken:(NSString *)appToken mobileAutoToken:(NSString *)autoToken;

/**
 *  用户注册
 *  /mapi/[APP_TOKEN]/register
 *  eg: http://qiaogu.local.com/mapi/qiaogu/register?username=user1&password=111111&email=user1@gmail.com&c=0023000064
 */
- (NSString *)getRegisterAddressWithAppToken:(NSString *)appToken;

/**
 *  手机token直接登录
 *  /mapi/[APP_TOKEN]/[MOBILE_AUTO_TOKEN]/autologin
 *  eg: http://qiaogu.local.com/mapi/qiaogu/f37ae9e9c69da1843926d13350a743d3/autologin
 */
- (NSString *)getAutoLoginAddressWithApptoken:(NSString *)appToken mobileAutoToken:(NSString *)autoToken;

/**
 *  通过手机号注册普通用户
 *  /mapi/[APP_TOKEN]/mobile_register
 *  eg: http://qiaogu.local.com/mapi/qiaogu/mobile_register?mobile=180xxxxxxxx&password=111111&c=0023000064&valicode=120092
 */
- (NSString *)getMobileRegisterAddressWithAppToken:(NSString *)appToken;

/**
 *  通过手机号获取注册验证码
 *  /mapi/[APP_TOKEN]/mobile_reg_valicode
 *  eg: http://qiaogu.local.com/mapi/qiaogu/mobile_reg_valicode?mobile=180xxxxxxxx
 */
- (NSString *)getAuthCodeAddressWithAppToken:(NSString *)appToken;

/**
 *  商户 添加评论
 *  /mapi/[APP_TOKEN]/[MOBILE_AUTO_TOKEN]/retail/[ID]/comment/add
    [ID] 商户ID
 *  eg: http://qiaogu.local.com/mapi/qiaogu/f37ae9e9c69da1843926d13350a743d3/retail/15/comment/add?rating=5&comment=随便写点什么吧
 */
- (NSString *)getAddCommentAddressWithAppToken:(NSString *)appToken
                               mobileAutoToken:(NSString *)autoToken
                                withBusinessID:(NSString *)businessID;

/**
 *  商户 评论列表
 *  /mapi/[APP_TOKEN]/retail/[ID]/comments
    [ID] 商户ID
 *  eg: http://qiaogu.local.com/mapi/qiaogu/retail/15/comments?page=1&limit=10
 */
- (NSString *)getCommentListAddressWithAppToken:(NSString *)appToken
                                 withBusinessID:(NSString *)businessID;


/**
 *  用户 添加收藏
 *  /mapi/[APP_TOKEN]/[MOBILE_AUTO_TOKEN]/user/favorite/[nid]/add
    [nid] 表示商户内容nid
 *  eg: http://qiaogu.local.com/mapi/qiaogu/f37ae9e9c69da1843926d13350a743d3/user/favorite/15/add
 */
- (NSString *)getAddFavoriteAddressWithAppToken:(NSString *)appToken
                                mobileAutoToken:(NSString *)autoToken
                                      contentId:(NSString *)contentId;

/**
 *  用户 删除收藏
 *  /mapi/[APP_TOKEN]/[MOBILE_AUTO_TOKEN]/user/favorite/[ID]/delete
    [ID] 表示收藏ID
 *  eg: http://qiaogu.local.com/mapi/qiaogu/f37ae9e9c69da1843926d13350a743d3/user/favorite/1/delete
 */
- (NSString *)getDeleteFavoriteAddressWithAppToken:(NSString *)appToken
                                   mobileAutoToken:(NSString *)autoToken
                                        favoriteId:(NSString *)favoriteId;

/**
 *  用户 收藏列表
 *  /mapi/[APP_TOKEN]/[MOBILE_AUTO_TOKEN]/user/favorites
 *  eg: http://qiaogu.local.com/mapi/qiaogu/f37ae9e9c69da1843926d13350a743d3/user/favorites?page=1&limit=10
 */
- (NSString *)getFavoritesAddressWithAppToken:(NSString *)appToken
                              mobileAutoToken:(NSString *)autoToken;

/**
 *  物流地址列表
 *  /mapi/[APP_TOKEN]/[MOBILE_AUTO_TOKEN]/user/addresses
 *  eg: http://qiaogu.local.com/mapi/qiaogu/f37ae9e9c69da1843926d13350a743d3/user/addresses
 */
- (NSString *)getAddressesWithAppToken:(NSString *)appToken
                       mobileAutoToken:(NSString *)autoToken;

/**
 *  物流地址添加/编辑
 *  /mapi/[APP_TOKEN]/[MOBILE_AUTO_TOKEN]/user/address/edit
 *  eg: http://qiaogu.local.com/mapi/qiaogu/f37ae9e9c69da1843926d13350a743d3/user/address/edit
 */
- (NSString *)getEditAddressWithAppToken:(NSString *)appToken
                         mobileAutoToken:(NSString *)autoToken;

/**
 *  物流地址删除
 *  /mapi/[APP_TOKEN]/[MOBILE_AUTO_TOKEN]/user/address/[ID]/delete
    [ID] 表示 物流地址ID
 *  eg: http://qiaogu.local.com/mapi/qiaogu/f37ae9e9c69da1843926d13350a743d3/user/address/1/delete
 */
- (NSString *)getAddressDeleteWithAppToken:(NSString *)appToken
                           mobileAutoToken:(NSString *)autoToken
                                 addressId:(NSString *)addressId;

/**
 *  广告位配置
 *  /mapi/mobile_ads_position
 *  eg: http://qiaogu.local.com/mapi/mobile_ads_position
 */
- (NSString *)getMobileADSPositionAddress;

/**
 *  零售烟酒店首页信息展示
 *  /retailstore/[APP_TOKEN]/[CITY]/home
    [CITY] 城市名,eg:shanghai,guangzhou,beijing
 *  eg: http://qiaogu.local.com/retailstore/qiaogu/shanghai/home
 eg: http://qiaogu.local.com/retailstore/qiaogu/shanghai/home?limit=5
 */
- (NSString *)getHomeAddressWithAppToke:(NSString *)appToken city:(NSString *)city;

/**
 *  零售烟酒店（多个）列表展示查询接口
 *  /retailstore/[APP_TOKEN]/[CITY]/list
    [CITY] 城市名称,eg:shanghai,guangzhou,beijing
 *  eg: http://qiaogu.local.com/retailstore/qiaogu/shanghai/list?location=12.312312,121.4321234
 */
- (NSString *)getStoreListAddressWithAppToken:(NSString *)appToken city:(NSString *)city;

/**
 *  零售烟酒店（单个）信息显示查询接口
 *  /mapi/[APP_TOKEN]/[MOBILE_AUTO_TOKEN]/retail/[ID]/comments /retailstore/[APP_TOKEN]/detail
 *  eg: http://qiaogu.local.com/retailstore/qiaogu/detail?sid=705
 */
- (NSString *)getRetailInfoAddressWithAppToken:(NSString *)appToken;

/**
 *  已开通的热门城市列表
 *  /mapi/[APP_TOKEN]/[MOBILE_AUTO_TOKEN]/retail/[ID]/comments
    [ID] 商户ID
 *  eg: http://qiaogu.local.com/mob/[APP_TOKEN]/cities
 */
- (NSString *)getCitiesAddressWithAppToken:(NSString *)appToken;


//---------------------------------聊天相关接口------------------------------------------
//-------------------------------------------------------------------------------------

/**
 *  获取未读信息总数接口
 *  /message/[id]/unreadcount
 *  [id] 用户id
 *  eg: http://dev.qg.51beta.cn:9080/qg-api/message/81/unreadcount
 */
- (NSString *)getUnreadcountWithUserId:(NSString *)userId;

/*
 * 上传个推clientId到服务器
 * /PushRegist/addorUpdate
 * eg:http://dev.qg.51beta.cn:9080/qg-api/PushRegist/addorUpdate
 */
- (NSString *)getUpdateClientIdAddress;

/*
 * 获取会话列表接口
 * /user/[id]/conversations
 * [id] 用户id
 * eg:http://dev.qg.51beta.cn:9080/qg-api/user/81/conversations
 */
- (NSString *)getSessionListAddressWithUserId:(NSString *)userId;

/*
 * 获取某个会话的聊天信息接口
 * /conversations/[conId]/[userId]/messages
 * [conId] 会话id [userId] 用户id
 * eg:http://dev.qg.51beta.cn:9080/qg-api/conversations/0000000048159112014815a4ec9d001e/81/messages
 */
- (NSString *)getMessageListAddressWithUserId:(NSString *)userId conId:(NSString *)conId page:(NSString *)start pageSize:(NSString *)limit;

/**
 *  辑删除会话内的所有消息
 *  /user/[userid]/[conid]/delete
 *  [userId] 用户id [conId] 会话id
 *eg:http://dev.qg.51beta.cn:9080/qg-api/user/81/0000000048159112014815a4ec9d001e/delete
 */
- (NSString *)getDeleteMessageListAddressWithUserId:(NSString *)userId conId:(NSString *)conId;

/*
 * 告知服务器发送通知栏消息接口
 * /PushRegist/[userId]/userSendMessage/ios/2_0
 * [userId] 用户id
 * eg:http://dev.qg.51beta.cn:9080/qg-api/PushRegist/81/userSendMessage/ios/2_0
 */
- (NSString *)getSendPushMessageAddressWithUserId:(NSString *)userId;

/*
 * 发送聊天内容消息接口
 * /conversations/[conId]/messages/addtext
 * [conId] 会话id
 * eg:http://dev.qg.51beta.cn:9080/qg-api/conversations/0000000048159112014815a4ec9d001e/messages/addtext
 */
- (NSString *)getSendMessageAddressWithConId:(NSString *)conId;

/*
 * 发送聊天图片消息接口
 * /conversations/[conId]/messages/addtext
 * [conId] 会话id
 * eg:http://dev.qg.51beta.cn:9080/qg-api/conversations/0000000048159112014815a4ec9d001e/messages/addtext
 */
- (NSString *)getSendImageMessageAddressWithConId:(NSString *)conId;

/*
 * 创建会话id接口
 * /conversations/add
 * eg:http://dev.qg.51beta.cn:9080/qg-api/conversations/add
 */
- (NSString *)getSessionIdAddress;

/**
 * 广告位配置
 * /mapi/mobile_ads_position
 * eg: http://qiaogu.local.com/mapi/mobile_ads_position
 */
- (NSString *)getMobileAdsAddress;


//---------------------------------商家版相关接口------------------------------------------
//-------------------------------------------------------------------------------------

/**
 *  获取促销列表API
 *  /retailstore/[APP_TOKEN]/[MOBILE_AUTO_TOKEN]/merchant/promotions/list
 *  [id] 用户id
 *  eg: http://dev.qg.51beta.cn:9080/retailstore/qiaogu/f0043c9a08c4a52db886bead983ca844/merchant/promotions/list
 */
- (NSString *)getPromotionsWithAppToken:(NSString *)appToken mobileAutoToken:(NSString *)autoToken;

/**
 *  添加促销列表API
 *  /retailstore/[APP_TOKEN]/[MOBILE_AUTO_TOKEN]/merchant/promotion/add
 *
 *  eg: http://dev.qg.51beta.cn:9080/retailstore/qiaogu/f0043c9a08c4a52db886bead983ca844/merchant/promotion/add
 */
- (NSString *)addPromotionsWithAppToken:(NSString *)appToken mobileAutoToken:(NSString *)autoToken;

/**
 *  商家版促销单详细（单个）API
 *  /retailstore/[APP_TOKEN]/[MOBILE_AUTO_TOKEN]/merchant/promotion/[promotion_id]
 *
 *  eg: http://dev.qg.51beta.cn:9080/retailstore/qiaogu/f0043c9a08c4a52db886bead983ca844/merchant/promotion/1
 */
- (NSString *)getPromotionDetailWithAppToken:(NSString *)appToken mobileAutoToken:(NSString *)autoToken itemId:(NSString *)id;

/**
 *  删除商家版促销单
 *  /retailstore/[APP_TOKEN]/[MOBILE_AUTO_TOKEN]/merchant/promotion/delete
 *
 *  eg: http://dev.qg.51beta.cn:9080/retailstore/qiaogu/f0043c9a08c4a52db886bead983ca844/merchant/promotion/1
 */
- (NSString *)deletePromotionDetailWithAppToken:(NSString *)appToken mobileAutoToken:(NSString *)autoToken itemId:(NSString *)id;

/**
 *  修改促销详情
 *  /retailstore/[APP_TOKEN]/[MOBILE_AUTO_TOKEN]/merchant/promotion/edit
 */
- (NSString *)editPromotionWithAppToken:(NSString *)appToken mobileAutoToken:(NSString *)autoToken;


/**
 * 获取订单列表
 * /retailstore/[APP_TOKEN]/[MOBILE_AUTO_TOKEN]/merchant/order/list
 **/
- (NSString *)getOrdersWithAppToken:(NSString *)appToken mobileAutoToken:(NSString *)autoToken;

/**
 * 获取订单详情
 * /retailstore/[APP_TOKEN]/[MOBILE_AUTO_TOKEN]/merchant/order/detail
 **/
- (NSString *)getOrderDetailWithAppToken:(NSString *)appToken mobileAutoToken:(NSString *)autoToken itemId:(NSString *)id;

/**
 * 关闭订单
 * /retailstore/[APP_TOKEN]/[MOBILE_AUTO_TOKEN]/merchant/order/close
 **/
- (NSString *)closeOrderDetailWithAppToken:(NSString *)appToken mobileAutoToken:(NSString *)autoToken itemId:(NSString *)id;

/**
 * 修改订单
 * /retailstore/[APP_TOKEN]/[MOBILE_AUTO_TOKEN]/merchant/order/edit
 **/
- (NSString *)editOrderDetailWithAppToken:(NSString *)appToken mobileAutoToken:(NSString *)autoToken itemId:(NSString *)id newStatus:(NSString *)newStatus;

/**
 * 获取促销图片
 **/
- (NSString *)getPromotionPhoto:(NSString *)url;

//获取商品列表
- (NSString *)getGoodsList:(NSString *)str shopToken:(NSString *)shopToken page:(NSString *)page goods_name:(NSString *)goods_name type_id:(NSString *)type_id orderby:(NSString *)orderby shangjia:(NSString *)shangjia;
//批量修改商品上下架、商品类别，批量删除商品
- (NSString *)batchOperaToken:(NSString *)shopToken goods_opera:(NSString *)goods_opera data:(NSString *)data goods_nids:(NSString *)goods_nids;
//获取商铺信息
- (NSString *)getShopMessage:(NSString *)token;
//商户店铺图片修改
- (NSString *)sendShopImage:(NSString *)token;
//商户信息修改
- (NSString *)updateShopMessage:(NSString *)token;
@end
