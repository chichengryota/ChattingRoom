let express = require('express');
let router = express.Router();
let login = require('./routes/login');
let user = require('./routes/user');
let message = require('./routes/message');
let getImageList = require('./routes/imgList');
let mobile = require('./routes/mobile');

router.post('/login', login.userLogin);
router.post('/register', login.userRegister);
// 查询用户信息
router.post('/user/show/userinfo', user.showUserInfo);
// 上传图片
router.post('/upload', user.uploadparams, user.uploadImg)
// 修改头像
router.post('/user/update/avatar', user.updateAvatar);
// 修改用户信息
router.post('/user/update/userinfo', user.updateUserInfo);
// 改绑邮箱
router.post('/user/update/email', user.updateEmail);
// 修改密码
router.post('/user/update/pwd', user.updatePwd);
// 注销账户
router.post('/user/delete/user', user.deleteAccount);
// 发表动态
router.post('/message/post/dynamic', message.postDynamic);
// 发表评论
router.post('/message/post/comment', message.postComment);
// 获取所有留言
router.get('/message/get/dynamic', message.getDynamic);
// 获取我的留言消息
router.post('/message/get/mycomment', message.getMyComment);
// 获取图片集
router.get('/img_list', getImageList);

// 搜索用户
router.post('/search/user', mobile.serachUser);
// 申请添加好友
router.post('/apply/adduser', mobile.applyAdd);
// 获取好友列表
router.post('/friend/list', mobile.getFriendList);
// 获取好友请求数量
router.post('/friend/apply/num', mobile.newFriend);
// 获取所有好友请求
router.post('/friend/apply/list', mobile.friendApply);
// 同意好友请求
router.post('/friend/agree/apply', mobile.agreeAdd);

module.exports = router;