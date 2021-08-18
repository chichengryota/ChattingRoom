module.exports = function (io) {
  //记录所有已经登录的用户
  const userList = []
  io.on('connection', socket => {
    socket.on("login", data => {
      // 判断，如果data在userList数组中存在，说明该用户已经登录，不允许登录
      // 如果data在userList数组中不存在，说明该用户没有登录，允许登录
      let user = userList.length !== 0 ? userList.find(item => item.username === data.username) : false
      if (user) {
        //表示用户存在,登录失败，服务器需要给当前用户响应，告诉登录失败
        socket.emit("userExit", {
          msg: "该用户已登录聊天室，登录失败"
        })
      } else {
        data.sid = socket.id;
        // 表示用户不存在,登录成功
        userList.push(data)
        socket.emit("loginSuccess", {
          ...data,
          msg: "登录聊天室成功"
        })
        //告诉所有的用户，有用户加入到聊天室，广播消息:io.emit
        io.emit("addUser", data)
        //告诉所有的用户，目前聊天室中有多少人
        io.emit("userList", userList)
        // 把登录成功的用户名和头像存储起来
        socket.username = data.username
      }
    })
    // 用户断开连接的功能
    socket.on("disconnect", () => {
      //判断用户是否已登录
      if (typeof socket.username !== 'undefined') {
        // 把当前用户的信息从userList中删除掉
        let idx = userList.findIndex(item => item.username === socket.username)
        userList.splice(idx, 1)
        // 告诉所有人有人离开了聊天室
        io.emit("leaveroom", {
          username: socket.username
        })
        // 告诉所有人，userList发生了更新
        io.emit("userList", userList)
      }
    })
    // 监听聊天的消息
    socket.on("sendMessage", data => {
      //广播给所有用户
      io.emit("receiveMessage", data)
    })
    // 接受图片信息
    socket.on("sendImage", data => {
      //广播给所有用户
      io.emit("receiveImage", data)
    })

    // 一对一单聊消息
    socket.on("oneMessage", data => {
      // 发送给指定用户
      socket.to(data.tosid).emit('oneMsg', data);
    })
    // 一对一单聊图片
    socket.on("oneImage", data => {
      // 发送给指定用户
      socket.to(data.tosid).emit('oneImg', data);
    })
  });
}