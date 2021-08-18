let dbconfig = require('../util/dbconfig')

//更新用户头像
updateAvatar = (req, res) => {
  let id = req.body.id;
  let image = req.body.imgUrl;
  let sql = "update users set avatar = ? where id = ?;";
  let sqlArr = [image, id];
  let callback = (error, data) => {
    if (error) {
      return res.send({
        code: 400,
        msg: "更新头像失败"
      })
    }
    res.send({
      code: 200,
      msg: "更新头像成功",
      url: global.BASE_URL + image
    })
  }
  dbconfig.sqlConnect(sql, sqlArr, callback)
}

//获取用户列表
getUser = (req, res) => {
  let sql = "select * from users";
  let sqlArr = [];
  let callback = (err, data) => {
    if (err) {
      return res.send({
        code: 400,
        msg: "获取用户列表失败"
      })
    }
    res.send({
      code: 200,
      data: data
    })
  }
  dbconfig.sqlConnect(sql, sqlArr, callback)
}

//查询用户信息
showUserInfo = (req, res) => {
  let uid = req.body.uid;
  let sql = "select * from users where id = ?;";
  let sqlArr = [uid];
  let callback = (error, data) => {
    var data = JSON.parse(JSON.stringify(data))[0];
    data.avatar = global.BASE_URL + data.avatar;
    if (error) {
      return res.send({
        code: 400,
        msg: "查询用户信息失败"
      })
    }
    res.send({
      code: 200,
      msg: "查询用户信息成功",
      data
    })
  }
  dbconfig.sqlConnect(sql, sqlArr, callback)
}

//更新用户信息
updateUserInfo = (req, res) => {
  let id = req.body.id;
  let signature = req.body.signature;
  let sex = req.body.sex;
  let birthday = req.body.birthday;
  let sql = "update users set signature = ?,sex = ?,birthday = ? where id = ?;";
  let sqlArr = [signature, sex, birthday, id];
  let callback = (error, data) => {
    if (error) {
      res.send({
        code: 400,
        msg: "更新用户信息失败"
      })
      throw error;
    }
    res.send({
      code: 200,
      msg: "更新用户信息成功"
    })
  }
  dbconfig.sqlConnect(sql, sqlArr, callback)
}

//更改绑定邮箱
updateEmail = (req, res) => {
  let id = req.body.id;
  let email = req.body.email;
  let sql = "select * from users where email = ?";
  let sqlArr = [email];
  let callback = (error, data) => {
    if (error) throw error;
    let result = JSON.parse(JSON.stringify(data));
    //1、查看数据库中是否有相同邮箱
    if (result.length >= 1) {
      //2、如果有相同邮箱，则更改绑定邮箱失败，邮箱重复
      res.send({
        code: 401,
        msg: '更改绑定邮箱失败，邮箱已存在'
      });
    } else {
      sql = "update users set email = ? where id = ?;";
      sqlArr = [email, id];
      callback = (error, data) => {
        if (error) {
          return res.send({
            code: 400,
            msg: "更改绑定邮箱失败"
          })
        }
        res.send({
          code: 200,
          msg: "更改绑定邮箱成功"
        })
      }
      dbconfig.sqlConnect(sql, sqlArr, callback)
    }
  }
  dbconfig.sqlConnect(sql, sqlArr, callback)
}

//更改密码
updatePwd = (req, res) => {
  let id = req.body.id;
  let password = req.body.password;
  let newPassWord = req.body.newPassWord;
  let sql = "select * from users where id = ?";
  let sqlArr = [id];
  let callback = (error, data) => {
    if (error) throw error;
    let result = JSON.parse(JSON.stringify(data));
    //判断当前密码是否正确
    if (password !== result[0].password) {
      res.send({
        code: 401,
        msg: '当前密码输入错误'
      });
    } else {
      sql = "update users set password = ? where id = ?;";
      sqlArr = [newPassWord, id];
      callback = (error, data) => {
        if (error) {
          return res.send({
            code: 400,
            msg: "修改密码失败"
          })
        }
        res.send({
          code: 200,
          msg: "修改密码成功"
        })
      }
      dbconfig.sqlConnect(sql, sqlArr, callback)
    }
  }
  dbconfig.sqlConnect(sql, sqlArr, callback)
}

//删除用户
deleteAccount = (req, res) => {
  let id = req.body.id;
  let sql = "delete from users where id = ?;";
  let sqlArr = [id];
  let callback = (error, data) => {
    if (error) {
      return res.send({
        code: 400,
        msg: "注销账户失败"
      })
    }
    res.send({
      code: 200,
      msg: "注销账户成功"
    })
  }
  dbconfig.sqlConnect(sql, sqlArr, callback)
}

module.exports = {
  getUser,
  updateAvatar,
  showUserInfo,
  updateUserInfo,
  updateEmail,
  updatePwd,
  deleteAccount
}