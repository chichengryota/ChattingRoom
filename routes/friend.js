let dbconfig = require('../util/dbconfig')
let getFirstLetter = require('../util/firstLetter');

// 搜索用户
serachUser = (req, res) => {
  let id = req.body.id;
  let name = req.body.value;
  let sql = "select * from users where username like ? and id <> ?;";
  let sqlArr = ['%' + name + '%', id];
  let callback = (error, data) => {
    if (error) throw error;
    if (data.length === 0) {
      return res.send({
        code: 400,
        msg: "搜索不到该用户"
      })
    }
    let result = JSON.parse(JSON.stringify(data));
    result.forEach(val => {
      val.isFriend = false;
      val.avatar = global.BASE_URL + val.avatar
    })
    let friend = [];
    sql = "select beapply from friend where apply = ? and isadd = 1;";
    sqlArr = [id];
    callback = (error, data) => {
      if (error) throw error;
      if (data.length !== 0) {
        let beapply = JSON.parse(JSON.stringify(data));
        beapply.forEach(val => {
          friend.push(val.beapply);
        });
      }
      sql = "select apply from friend where beapply = ? and isadd = 1;";
      sqlArr = [id];
      callback = (error, data) => {
        if (error) throw error;
        if (data.length !== 0) {
          let apply = JSON.parse(JSON.stringify(data));
          apply.forEach(val => {
            friend.push(val.apply);
          });
        }
        result.forEach(val => {
          if (friend.indexOf(val.id) !== -1) {
            val.isFriend = true;
          }
        })
        res.send({
          code: 200,
          data: result,
          msg: '查询用户成功'
        })
      }
      dbconfig.sqlConnect(sql, sqlArr, callback)
    }
    dbconfig.sqlConnect(sql, sqlArr, callback)
  }
  dbconfig.sqlConnect(sql, sqlArr, callback)
}

// 发起好友申请
applyAdd = (req, res) => {
  let uid = req.body.uid;
  let id = req.body.id;
  let message = req.body.message;
  let time = req.body.time;
  let sql = "select * from friend where apply = ? and beapply = ?";
  let sqlArr = [uid, id];
  let callback = (error, data) => {
    if (error) throw error;
    if (data.length === 0) {
      sql = "insert into friend(apply,beapply,message,add_time,isadd) values(?,?,?,?,0)";
      sqlArr = [uid, id, message, time];
      callback = (error, data) => {
        if (error) {
          return res.send({
            code: 400,
            msg: "发起好友请求失败"
          })
        }
        res.send({
          code: 200,
          msg: "已成功发起好友请求"
        })
      }
      dbconfig.sqlConnect(sql, sqlArr, callback)
    } else {
      sql = "update friend set message = ?,add_time = ? where apply = ? and beapply = ?;";
      sqlArr = [message, time, uid, id];
      callback = (error, data) => {
        if (error) {
          return res.send({
            code: 400,
            msg: "发起好友请求失败"
          })
        }
        res.send({
          code: 200,
          msg: "已成功发起好友请求"
        })
      }
      dbconfig.sqlConnect(sql, sqlArr, callback)
    }
  }
  dbconfig.sqlConnect(sql, sqlArr, callback)
}

// 好友列表
getFriendList = (req, res) => {
  let uid = req.body.uid;
  let sql = "select beapply from friend where apply = ? and isadd = 1;";
  let sqlArr = [uid];
  let callback = (error, data) => {
    if (error) throw error;
    let friend = [];
    if (data.length !== 0) {
      let beapply = JSON.parse(JSON.stringify(data));
      beapply.forEach(val => {
        friend.push(val.beapply);
      });
    }
    sql = "select apply from friend where beapply = ? and isadd = 1;";
    sqlArr = [uid];
    callback = (error, data) => {
      if (error) throw error;
      if (data.length !== 0) {
        let apply = JSON.parse(JSON.stringify(data));
        apply.forEach(val => {
          friend.push(val.apply);
        });
      }
      sql = "select * from users where id in (?) order by username;";
      sqlArr = [friend];
      callback = (error, data) => {
        if (error) throw error;
        let result = JSON.parse(JSON.stringify(data));
        let friendList = [];
        let letterArr = [];
        let initial = '';
        let index = 0;
        result.forEach(val => {
          val.avatar = global.BASE_URL + val.avatar;
          initial = getFirstLetter(val.username);
          index = letterArr.indexOf(initial);
          if (index === -1) {
            letterArr.push(initial);
            friendList.push({
              letter: initial,
              data: [val]
            })
          } else {
            friendList[index].data.push(val);
          }
        })
        res.send({
          code: 200,
          data: friendList,
          msg: '获取好友列表成功'
        })
      }
      dbconfig.sqlConnect(sql, sqlArr, callback)
    }
    dbconfig.sqlConnect(sql, sqlArr, callback)
  }
  dbconfig.sqlConnect(sql, sqlArr, callback)
}

// 好友请求数量
newFriend = (req, res) => {
  let uid = req.body.uid;
  let sql = "select beapply from friend where apply = ? and isadd = 0;";
  let sqlArr = [uid];
  let callback = (error, data) => {
    if (error) throw error;
    let friend = [];
    if (data.length !== 0) {
      let beapply = JSON.parse(JSON.stringify(data));
      beapply.forEach(val => {
        friend.push(val.beapply);
      });
    }
    sql = "select apply from friend where beapply = ? and isadd = 0;";
    sqlArr = [uid];
    callback = (error, data) => {
      if (error) throw error;
      if (data.length !== 0) {
        let apply = JSON.parse(JSON.stringify(data));
        apply.forEach(val => {
          friend.push(val.apply);
        });
      }
      res.send({
        code: 200,
        data: friend,
        msg: '获取好友请求数量成功'
      })
    }
    dbconfig.sqlConnect(sql, sqlArr, callback)
  }
  dbconfig.sqlConnect(sql, sqlArr, callback)
}

// 所有好友请求
friendApply = (req, res) => {
  let uid = req.body.uid;
  let sql = "select apply,message,isadd,add_time from friend where beapply = ?;";
  let sqlArr = [uid];
  let callback = (error, data) => {
    if (error) throw error;
    let idArr = [];
    let friendList = [];
    if (data.length !== 0) {
      let applyArr = JSON.parse(JSON.stringify(data));
      applyArr.forEach(val => {
        idArr.push(val.apply);
        friendList.push(val);
      });
    }
    sql = "select * from users where id in (?);";
    sqlArr = [idArr];
    callback = (error, data) => {
      if (error) throw error;
      let result = JSON.parse(JSON.stringify(data));
      result.forEach(val => {
        val.avatar = global.BASE_URL + val.avatar;
        friendList.forEach(item => {
          if (val.id == item.apply) {
            val.isadd = item.isadd;
            val.message = item.message;
            val.add_time = item.add_time;
          }
        })
      })
      res.send({
        code: 200,
        data: result,
        msg: '获取所有好友请求成功'
      })
    }
    dbconfig.sqlConnect(sql, sqlArr, callback)
  }
  dbconfig.sqlConnect(sql, sqlArr, callback)
}

// 同意好友请求
agreeAdd = (req, res) => {
  let uid = req.body.uid;
  let id = req.body.id;
  let time = req.body.time;
  let sql = "update friend set isadd = 1,add_time = ? where apply = ? and beapply = ?;";
  let sqlArr = [time, id, uid];
  let callback = (error, data) => {
    if (error) {
      return res.send({
        code: 400,
        msg: "添加好友失败"
      })
    }
    sql = "insert into follow(follow,befollow) values(?,?);";
    sqlArr = [uid, id];
    callback = (error, data) => {
      if (error) throw error;
      sql = "insert into follow(follow,befollow) values(?,?);";
      sqlArr = [id, uid];
      callback = (error, data) => {
        if (error) throw error;
        res.send({
          code: 200,
          msg: "添加好友成功"
        })
      }
      dbconfig.sqlConnect(sql, sqlArr, callback)
    }
    dbconfig.sqlConnect(sql, sqlArr, callback)
  }
  dbconfig.sqlConnect(sql, sqlArr, callback)
}

module.exports = {
  serachUser,
  applyAdd,
  getFriendList,
  newFriend,
  friendApply,
  agreeAdd
}