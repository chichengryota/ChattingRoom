<template>
  <div class="home">
    <div class="header">
      <!-- 导航栏左侧 -->
      <div class="header-left" @click="goHome">
        <img src="../assets/img/star.png" alt="" />
        <span>聊天留言系统</span>
      </div>
      <!-- 导航栏菜单 -->
      <ul class="header-navList">
        <li>
          <a href="/">
            <i class="iconfont">&#xe68b;</i>
            首页</a
          >
        </li>
        <li @click="goMessage">
          <a href="javascript:;">
            <i class="iconfont">&#xe61b;</i>
            留言板</a
          >
        </li>
        <li @click="goChatting">
          <a href="javascript:;">
            <i class="iconfont">&#xe606;</i>
            聊天室</a
          >
        </li>
        <li @click="goMusicRoom"><a href="javascript:;">🎶M&P</a></li>
      </ul>
      <!-- 导航栏登录注册、用户 -->
      <div class="header-login">
        <div class="login" v-if="!isLogin">
          <!-- <el-avatar size="large" :src="circleUrl"></el-avatar> -->
          <el-button type="primary" @click="LoginIn">登录</el-button>
          <el-button type="warning" @click="Register">注册</el-button>
        </div>
        <div class="avatar" v-else>
          <el-avatar
            :size="70"
            :src="avatar"
            @click.native="UserInfo1"
          ></el-avatar>
          <div class="userInfo">
            <ul>
              <li>
                <span>当前登录用户:</span>
                <span class="loginName">{{ username }}</span>
              </li>
              <li @click="UserInfo1">
                <i class="iconfont">&#xe61d;</i>个人资料
              </li>
              <li @click="UserInfo2">
                <i class="iconfont">&#xe66d;</i>账号安全
              </li>
              <li @click="UserInfo3">
                <i class="iconfont">&#xe646;</i>我的消息
              </li>
              <li @click="loginOut">
                <i class="iconfont">&#xe71e;</i>退出登录
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
    <div class="main">
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      isLogin: false,
      id: 0,
      avatar: "",
      username: "",
    };
  },
  watch: {
    "$store.state.avatar"(val) {
      this.avatar = val;
    },
  },
  created() {
    this.loginWithToken();
  },
  methods: {
    //判断是否登录
    loginWithToken() {
      const tokenStr = window.sessionStorage.getItem("token");
      if (tokenStr) {
        this.isLogin = true;
        let userInfo = window.sessionStorage.getItem("userInfo");
        userInfo = JSON.parse(userInfo);
        this.avatar = userInfo.avatar;
        this.username = userInfo.username;
      }
    },
    goHome() {
      this.$router.push("/");
    },
    goMessage() {
      this.$router.push("/dynamic");
    },
    goChatting() {
      this.$router.push("/chatting");
    },
    goMusicRoom() {
      this.$router.push("/find");
    },
    LoginIn() {
      this.$router.push("/login");
    },
    Register() {
      this.$router.push("/register");
    },
    loginOut() {
      window.sessionStorage.clear();
      this.$message.success("退出登录成功");
      this.$router.push("/login");
    },
    UserInfo1() {
      this.$router.push("/userinfo/1");
    },
    UserInfo2() {
      this.$router.push("/userinfo/2");
    },
    UserInfo3() {
      this.$router.push("/userinfo/3");
    },
  },
};
</script>

<style lang="less" scoped>
.home {
  background-image: url(../assets/img/bg.jpg);
  background-size: 210px;
  background-repeat: repeat;
  min-height: 100vh;
}
.header {
  width: 100%;
  height: 100px;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.7);
  display: flex;
  .header-left {
    width: 35%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    box-sizing: border-box;
    img {
      width: 70px;
      margin-right: 30px;
    }
    span {
      display: inline-block;
      font-size: 38px;
      color: #b47aff;
      font-weight: bolder;
      font-family: monospace;
    }
  }
  .header-navList {
    display: flex;
    justify-content: space-around;
    align-items: center;
    width: 40%;
    height: 100%;
    margin: 0;
    list-style: none;
    a {
      text-decoration: none;
      color: rgb(85, 26, 139);
      font-size: 20px;
      font-weight: bold;
      i {
        font-size: 20px;
      }
    }
    & > li > a:hover {
      color: orange;
    }
  }
  .header-login {
    width: 25%;
    height: 100%;
    display: flex;
    padding-left: 50px;
    box-sizing: border-box;
    align-items: center;
    .login {
      display: flex;
      align-items: center;
      justify-content: space-around;
      .el-button {
        font-size: 16px;
        margin-right: 10px;
      }
    }

    .avatar {
      position: relative;
      .el-avatar {
        border: 2px #eee solid;
        z-index: 999;
        margin-top: 10px;
        position: relative;
        cursor: pointer;
      }
    }
    .el-avatar:hover + .userInfo {
      animation: show 0.7s forwards;
    }
    .userInfo:hover {
      height: 300px;
    }
    @keyframes show {
      0% {
        height: 0;
      }
      100% {
        height: 300px;
      }
    }
    .userInfo {
      position: absolute;
      left: -50px;
      top: 70px;
      height: 0;
      overflow: hidden;
      width: 170px;
      box-shadow: 0 0 5px rgba(0, 0, 0, 0.8);
      border-radius: 5px;
      background-color: #fff;
      z-index: 99;
      ul {
        width: 100%;
        height: 100%;
        display: flex;
        flex-direction: column;
        justify-content: space-evenly;
        margin: 0;
        padding: 0;
        list-style: none;
        li {
          font-size: 16px;
          border-top: 1px #eee solid;
          padding-top: 14px;
          text-align: center;
          color: purple;
          width: 100%;
          cursor: pointer;
          i {
            margin-right: 8px;
          }
          span {
            display: block;
            cursor: auto;
          }
          .loginName {
            font-size: 24px;
            color: orange;
            margin: 0 auto;
          }
        }
      }
    }
  }
}
.main {
  padding: 0;
  box-sizing: border-box;
}
</style>
