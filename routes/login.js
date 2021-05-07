let dbconfig = require('../util/dbconfig')
let jwt = require('jsonwebtoken');

// 处理登录请求
userLogin = (req, res) => {
  let formData = req.body.params;
  let username = formData.username;
  let password = formData.password;
  let email = formData.email;
  //1、查询数据库中是否有用户名或邮箱
  if (username !== '') {
    var sql = "select * from users where username = ?";
    var sqlArr = [username];
  } else {
    var sql = "select * from users where email = ?";
    var sqlArr = [email];
  }
  let callback = (error, data) => {
    if (error) throw error;
    let result = JSON.parse(JSON.stringify(data));
    if (result.length >= 1) {
      //2、如果有用户名或邮箱，查询密码是否相同
      if (password == result[0].password) {
        if (username !== '') {
          sql = "select * from users where username = ?;";
          sqlArr = [username];
        } else {
          sql = "select * from users where email = ?";
          sqlArr = [email];
        }
        callback = (error, data) => {
          var data = JSON.parse(JSON.stringify(data))[0];
          delete data.password
          if (data.avatar !== null) {
            data.avatar = global.BASE_URL + data.avatar
          } else {
            data.avatar = global.BASE_URL + '/public/images/avatar/default_avatar.jpg'
          }
          if (error) throw error;
          let content = {
            username: username,
            email: email
          }; // 要生成token的主题信息
          let secretOrPrivateKey = "secretOrPrivateKey" // 这是加密的key（密钥） 
          let token = jwt.sign(content, secretOrPrivateKey, {
            expiresIn: 60 * 60 * 1 // 1小时过期
          });
          //3、密码相同则登陆成功
          res.send({
            code: 200,
            msg: '登录成功',
            token,
            data
          });
        }
        dbconfig.sqlConnect(sql, sqlArr, callback)
      } else {
        res.send({
          code: 401,
          msg: '登陆失败，密码错误'
        });
      }
    } else {
      res.send({
        code: 402,
        msg: '登陆失败，没有此用户名'
      });
    }
  }
  dbconfig.sqlConnect(sql, sqlArr, callback)
}

// 处理注册请求
userRegister = (req, res) => {
  let formData = req.body.params;
  let username = formData.username;
  let password = formData.password;
  let email = formData.email;
  let sql = "select * from users where username = ?";
  let sqlArr = [username];
  let callback = (error, data) => {
    if (error) throw error;
    let result = JSON.parse(JSON.stringify(data));
    //1、查看数据库中是否有相同用户名
    if (result.length >= 1) {
      //2、如果有相同用户名，则注册失败，用户名重复
      res.send({
        code: 401,
        msg: '注册失败，用户名已存在'
      });
    } else {
      sql = "select * from users where email = ?";
      sqlArr = [email];
      callback = (error, data) => {
        if (error) throw error;
        result = JSON.parse(JSON.stringify(data));
        //1、查看数据库中是否有相同邮箱
        if (result.length >= 1) {
          //2、如果有相同邮箱，则注册失败，邮箱已存在
          res.send({
            code: 402,
            msg: '注册失败，邮箱已存在'
          });
        } else {
          // 设置默认图片
          let avatar = '/public/images/avatar/default_avatar.jpg'
          sql = "insert into users(username,password,email,avatar) values(?,?,?,?)";
          sqlArr = [username, password, email, avatar];
          callback = (error, data) => {
            if (error) throw error;
            //3、如果没有相同用户名，并且有一条记录，则注册成功
            if (data.affectedRows == 1) {
              res.send({
                code: 200,
                msg: '注册成功'
              });
            } else {
              res.send({
                code: 400,
                msg: '注册失败'
              });
            }
          }
          dbconfig.sqlConnect(sql, sqlArr, callback)
        }
      }
      dbconfig.sqlConnect(sql, sqlArr, callback)
    }
  }
  dbconfig.sqlConnect(sql, sqlArr, callback)
}

module.exports = {
  userLogin,
  userRegister
}