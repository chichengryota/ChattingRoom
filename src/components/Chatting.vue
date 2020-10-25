<template>
  <div>
    <el-card class="chatBox" :body-style="{ padding: '0px' }">
      <div class="loginChat" v-if="isLogin">
        <img :src="avatar" alt="" />
        <span>{{ username }}</span>
        <button @click="loginChat">进入聊天室</button>
      </div>
      <room
        v-else
        :user="user"
        :userList="userList"
        ref="chatroom"
        @sendServer="sendServer"
        :message="message"
        @handleFile="handleFile"
      />
    </el-card>
  </div>
</template>

<script>
import Room from "./ChatRoom";
//引入socket.io-client
import io from "socket.io-client";
export default {
  components: { Room },
  data() {
    return {
      username: "",
      avatar: "",
      isLogin: true,
      socket: null,
      user: {},
      userList: [],
      message: {},
    };
  },
  methods: {
    loginChat() {
      this.socket.emit("login", {
        username: this.username,
        avatar: this.avatar,
      });
    },
    handleFile(file) {
      this.socket.emit("sendImage", { ...this.user, file });
    },
    sendServer(content) {
      const { username, avatar } = this.user;
      this.socket.emit("sendMessage", { msg: content, username, avatar });
    },
  },
  mounted() {
    this.username = window.sessionStorage.getItem("username");
    this.avatar = window.sessionStorage.getItem("avatar");
    /**
     * 聊天室的主要功能
     */
    // 连接服务器
    this.socket = io("http://localhost:3000/");
    // 监听登录失败的请求
    this.socket.on("userExit", (data) => this.$message.error(data.msg));
    // 监听登录成功的请求
    this.socket.on("loginsuccess", (data) => {
      this.$message.success(data.msg);
      this.user = data;
      this.isLogin = false;
    });
    this.socket.on("addUser", (data) => {
      this.$store.commit("setJoinRoom", data);
      this.$refs.chatroom ? this.$refs.chatroom.haveOneJoinRoom() : null;
    });
    this.socket.on("leaveroom", (data) => {
      this.$store.commit("setLeaveRoom", data);
      this.$refs.chatroom ? this.$refs.chatroom.haveOneleaveRoom() : null;
    });
    // 监听用户列表的信息
    this.socket.on("userList", (data) => {
      this.userList = data;
    });
    // 监听聊天的消息
    this.socket.on("receiveMessage", (data) => {
      // 把接收到的消息显示到聊天窗口中
      this.message = data;
    });
    // 监听图片的消息
    this.socket.on("receiveImage", (data) => {
      // 把接收到的图片显示到聊天窗口中
      this.$refs.chatroom.handleImage(data);
    });
  },
  destroyed() {
    if (this.socket) this.socket.disconnect();
  },
};
</script>

<style lang="less" scoped>
.chatBox {
  position: relative;
  width: 900px;
  height: 550px;
  margin: 0 auto;
  margin-top: 40px;
  border: none;
}
.loginChat {
  width: 900px;
  height: 550px;
  background-image: linear-gradient(
    to right top,
    #a98fb3,
    #a08fb9,
    #9490bd,
    #8691c1,
    #7593c4
  );
  img {
    width: 180px;
    height: 180px;
    top: 110px;
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
  }
  span {
    position: absolute;
    display: block;
    left: 50%;
    transform: translateX(-50%);
    font-size: 34px;
    top: 300px;
    color: yellow;
  }
  button {
    width: 135px;
    height: 47px;
    font-size: 20px;
    top: 410px;
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    color: #fff;
    background-color: rgb(157, 82, 226);
    cursor: pointer;
    border: none;
    border-radius: 50px;
    box-shadow: 0 0 8px rgba(0, 0, 0, 0.3);
  }
}
</style>