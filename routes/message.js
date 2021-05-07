let dbconfig = require('../util/dbconfig')

//获取全部留言数据
getDynamic = (req, res) => {
  // 查询留言表
  let sql = "select a.id, a.username, a.avatar, b.* from users a inner join dynamic b on a.id = b.uid order by b.time desc;";
  let sqlArr = [];
  let callback = (error, data) => {
    if (error) throw error;
    let dynamic = JSON.parse(JSON.stringify(data));
    // 查询评论表
    sql = "select a.id, a.username, a.avatar, b.* from users a inner join comment b on a.id = b.uid order by b.time;";
    sqlArr = [];
    callback = (error, data) => {
      if (error) throw error;
      let comment = JSON.parse(JSON.stringify(data));
      // 给所有一级评论添加回复名称
      comment.forEach(val => {
        val.avatar = global.BASE_URL + val.avatar
        comment.forEach(item => {
          if (item.reply_id != null) {
            if (item.reply_id == val.id) {
              item.reply_name = val.username;
            }
          }
        })
      })
      // 给所有二级评论添加回复名称,并把所有评论数据插入留言列表中
      dynamic.forEach(val => {
        val.avatar = global.BASE_URL + val.avatar
        val.reply = []
        comment.forEach(item => {
          if (item.mid === val.mid) {
            if (item.reply_id == null) {
              item.reply_name = val.username;
            }
            val.reply.push(item)
          }
        })
      });
      // 默认头像
      let default_avatar = global.BASE_URL + '/public/images/avatar/default_avatar.jpg'
      res.send({
        code: 200,
        msg: "获取所有留言成功",
        data: dynamic,
        avatar: default_avatar
      })
    }
    dbconfig.sqlConnect(sql, sqlArr, callback)
  }
  dbconfig.sqlConnect(sql, sqlArr, callback)
}

//添加留言到数据库
postDynamic = (req, res) => {
  let uid = req.body.uid;
  let message = req.body.message;
  let time = req.body.time;
  let sql = "insert into dynamic(message,time,uid) values(?,?,?)";
  let sqlArr = [message, time, uid];
  let callback = (error, data) => {
    if (error) {
      return res.send({
        code: 400,
        msg: "发表留言失败"
      })
    }
    res.send({
      code: 200,
      msg: "发表留言成功"
    })
  }
  dbconfig.sqlConnect(sql, sqlArr, callback)
}

//添加评论到数据库
postComment = (req, res) => {
  let uid = req.body.uid;
  let mid = req.body.mid;
  let reply_id = req.body.reply_id;
  let comment = req.body.comment;
  let time = req.body.time;
  let sql = "insert into comment(message,time,uid,mid,reply_id) values(?,?,?,?,?)";
  let sqlArr = [comment, time, uid, mid, reply_id];
  let callback = (error, data) => {
    if (error) {
      return res.send({
        code: 400,
        msg: "发表评论失败"
      })
    };
    res.send({
      code: 200,
      msg: "发表评论成功"
    })
  }
  dbconfig.sqlConnect(sql, sqlArr, callback)
}

// 获取我的留言评论
getMyComment = (req, res) => {
  let uid = req.body.uid;
  // 查询我发表留言的评论
  let sql = "select * from comment where mid in (select mid from dynamic where uid = ?);";
  let sqlArr = [uid];
  let callback = (error, data) => {
    if (error) throw error;
    let result = JSON.parse(JSON.stringify(data));
    let uidArr = [];
    result.forEach((val, i) => {
      uidArr.push(val.uid)
      if (val.reply_id != null) {
        result.splice(i, 1)
      }
    })
    // 查询我所有评论的评论
    sql = "select * from comment where reply_id in (select id from comment where uid = ?);";
    sqlArr = [uid];
    callback = (error, data) => {
      if (error) throw error;
      let result1 = JSON.parse(JSON.stringify(data));
      result1.forEach(item => {
        uidArr.push(item.uid)
      })
      uidArr = Array.from(new Set(uidArr));
      result = result.concat(result1);
      // 根据评论对应的uid查询对应用户信息
      sql = "select id, avatar, username from users where id in (?);";
      sqlArr = [uidArr];
      callback = (error, data) => {
        if (error) throw error;
        let user = JSON.parse(JSON.stringify(data));
        user.forEach(val => {
          result.forEach(item => {
            if (val.id == item.uid) {
              item.avatar = global.BASE_URL + val.avatar;
              item.username = val.username;
            }
          })
        })
        res.send({
          code: 200,
          msg: "获取我的消息成功",
          data: result
        })
      }
      dbconfig.sqlConnect(sql, sqlArr, callback)
    }
    dbconfig.sqlConnect(sql, sqlArr, callback)
  }
  dbconfig.sqlConnect(sql, sqlArr, callback)
}
module.exports = {
  postDynamic,
  postComment,
  getDynamic,
  getMyComment
}