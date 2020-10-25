<template>
  <div class="home">
    <el-container>
      <div class="bgImg">
        <img src="../assets/img/bg.jpg" alt="" />
      </div>
      <el-header>
        <el-row :gutter="20" type="flex" class="row-bg" justify="space-around">
          <!-- 导航栏左侧 -->
          <el-col :span="6" :offset="1">
            <div class="grid-content bg-purple navLeft">
              <a href="/">
                <img src="../assets/img/star.png" alt="" />
                <span>无名小站</span>
              </a>
            </div>
          </el-col>
          <!-- 导航栏菜单 -->
          <el-col :span="10">
            <ul class="navList">
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
              <!-- <li>
                <a href="">
                  <i class="iconfont">&#xe71d;</i>
                  图集</a
                >
              </li> -->
              <li><a href="javascript:;">🎶Music</a></li>
            </ul>
          </el-col>
          <!-- 导航栏登录注册、用户 -->
          <el-col :span="5">
            <div class="grid-content bg-purple navLogin" v-if="isLogin">
              <!-- <el-avatar size="large" :src="circleUrl"></el-avatar> -->
              <el-button type="primary" @click="LoginIn">登录</el-button>
              <el-button type="warning" @click="Register">注册</el-button>
            </div>
            <div class="avatar" v-else>
              <el-avatar :size="70" :src="url"></el-avatar>
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
          </el-col>
        </el-row>
      </el-header>
      <el-main>
        <router-view></router-view>
      </el-main>
    </el-container>
  </div>
</template>

<script>
export default {
  data() {
    return {
      isLogin: true,
      url: "",
      id: 0,
      avatar: "",
      username: "",
    };
  },
  created() {
    this.loginWithToken();
    this.id = window.sessionStorage.getItem("id");
    this.showUserInfo();
  },
  methods: {
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
    //判断token是否存在
    loginWithToken() {
      const tokenStr = window.sessionStorage.getItem("token");
      if (tokenStr) {
        this.isLogin = false;
      }
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
    //获取用户信息
    async showUserInfo() {
      if (this.isLogin) {
        return;
      }
      const { data: res } = await this.$http.post("shuserinfo", {
        id: this.id,
      });
      if (res.code !== 200) {
        return this.$message.error("获取登录用户信息失败!");
      }
      this.url = res.data.avatar;
      this.username = res.data.username;
      window.sessionStorage.setItem("avatar", res.data.avatar);
      window.sessionStorage.setItem("username", res.data.username);
    },
    goMessage() {
      this.$router.push("/message");
    },
    goChatting() {
      const tokenStr = window.sessionStorage.getItem("token");
      if (!tokenStr) {
        this.$message("请先登录");
        this.$router.push("/login");
      } else {
        this.$router.push("/chatting");
      }
    },
  },
};
</script>

<style lang="less" scoped>
.bgImg {
  position: absolute;
  img {
    width: 100%;
    height: 100%;
    opacity: 0.7;
    background-size: cover;
  }
}
.navLeft {
  img {
    position: absolute;
    height: 150px;
    top: -30px;
  }
  span {
    position: absolute;
    left: 245px;
    top: 25px;
    font-size: 30px;
    color: rgb(145, 48, 224);
    font-weight: bolder;
  }
}
.navList {
  display: flex;
  list-style-type: none;
  justify-content: space-around;
  padding-top: 20px;
  a {
    text-decoration: none;
    color: rgb(85, 26, 139);
    font-size: 20px;
    font-weight: bold;
    i {
      font-size: 20px;
    }
  }
}
.navList > li > a:hover {
  color: orange;
}
.navLogin {
  position: relative;
  top: 30px;
  .el-button {
    font-size: 18px;
  }
}
.avatar {
  .el-avatar {
    border: 2px #eee solid;
    margin-top: 16px;
    z-index: 9999;
    position: absolute;
  }
}
.el-avatar:hover + .userInfo,
.userInfo:hover {
  display: block;
}
.userInfo {
  display: none;
  width: 170px;
  height: 300px;
  position: absolute;
  top: 68px;
  right: 203px;
  box-shadow: 0 0 5px rgba(0, 0, 0, 0.8);
  border-radius: 5px;
  background-color: #fff;
  z-index: 999;
  ul {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-evenly;
    margin: 0;
    padding: 0;
    li {
      list-style: none;
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
.el-header {
  height: 100px !important;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.8);
  position: relative;
}
.el-main {
  padding: 0;
}
</style>
