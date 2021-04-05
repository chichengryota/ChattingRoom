<template>
  <div class="login_container">
    <!-- 背景图片 -->
    <div class="loginBg">
      <img src="../assets/img/loginbg.jpg" alt />
    </div>
    <div class="login_box">
      <!-- 登录表单区域 -->
      <h1>LOGIN</h1>
      <el-form
        :model="loginForm"
        :rules="loginFormRules"
        ref="loginFormRef"
        class="login_form"
        @submit.native.prevent
      >
        <!-- 判断是用户名登录还是邮箱登录 -->
        <el-form-item prop="username" v-if="isUser">
          <el-input
            v-model="loginForm.username"
            prefix-icon="iconfont icon-user"
            class="inputStyle"
            placeholder="username"
            ref="input1"
          ></el-input>
        </el-form-item>
        <el-form-item prop="email" v-else>
          <el-input
            v-model="loginForm.email"
            prefix-icon="iconfont icon-youxiang1"
            class="inputStyle"
            placeholder="email"
            @blur="checkEmail"
            ref="input1"
          ></el-input>
        </el-form-item>
        <!-- 密码 -->
        <el-form-item prop="password">
          <el-input
            v-model="loginForm.password"
            show-password
            prefix-icon="iconfont icon-password"
            class="inputStyle"
            placeholder="password"
          ></el-input>
        </el-form-item>
        <!-- 按钮区域 -->
        <el-form-item>
          <div class="btns">
            <button class="loginButton button" @click="login">登录</button>
            <button class="goRegButton button" @click="goRegister">
              前往注册
            </button>
            <button class="checkButton button" @click="chooseUser">
              {{ loginText }}登录
            </button>
          </div>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      loginText: "邮箱",
      isUser: true,
      loginForm: {
        username: "",
        password: "",
        email: "",
      },
      loginFormRules: {
        username: [
          { required: true, message: "请输入用户名称", trigger: "blur" },
          {
            min: 3,
            max: 10,
            message: "长度在 3 到 10 个字符",
            trigger: "blur",
          },
        ],
        password: [
          { required: true, message: "请输入用户密码", trigger: "blur" },
          {
            min: 6,
            max: 15,
            message: "长度在 6 到 15 个字符",
            trigger: "blur",
          },
        ],
        email: [{ required: true, message: "请输入电子邮箱", trigger: "blur" }],
      },
    };
  },
  mounted() {
    this.$refs.input1.focus();
  },
  methods: {
    checkEmail: function () {
      var regEmail = /^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
      if (this.loginForm.email != "" && !regEmail.test(this.loginForm.email)) {
        this.$message.error("邮箱格式不正确");
        this.loginForm.email = "";
      }
    },
    login() {
      this.$refs.loginFormRef.validate(async (valid) => {
        if (!valid) return;
        const { data: res } = await this.$http.post("login", {
          params: this.loginForm,
        });
        if (res.code !== 200) {
          return this.$message.error(res.msg);
        }
        this.$message.success(res.msg);
        window.sessionStorage.setItem("token", res.token);
        window.sessionStorage.setItem("userInfo", JSON.stringify(res.data));
        this.$router.push("/");
      });
    },
    goRegister() {
      this.$router.push("/register");
    },
    chooseUser() {
      if (this.loginText === "邮箱") {
        this.isUser = false;
        this.loginText = "用户名";
      } else {
        this.isUser = true;
        this.loginText = "邮箱";
      }
      this.loginForm = {
        username: "",
        password: "",
        email: "",
      };
    },
  },
};
</script>

<style lang="less" scoped>
.loginBg {
  background-repeat: no-repeat;
  position: absolute;
  width: 100vw;
  height: 100vh;
  img {
    width: 100%;
  }
}
.login_container {
  height: 100%;
}
.login_box {
  width: 500px;
  height: 350px;
  border-radius: 20px;
  background-color: #00000090;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  h1 {
    color: rgb(240, 199, 218);
    text-align: center;
    margin: 50px 0 0;
  }
}

/deep/.login_form {
  position: absolute;
  bottom: 0;
  width: 100%;
  padding: 0 35px;
  box-sizing: border-box;
  .el-input__inner {
    padding-left: 40px;
    height: 50px;
    background-color: #ffffff90;
    font-size: 18px;
    color: #fff;
    border-radius: 10px;
  }
  .el-input__prefix {
    color: rgb(240, 199, 218);
    margin-left: 5px;
    top: 2px;
    i {
      font-size: 18px;
    }
  }
}
.btns {
  display: inline-flex;
  justify-content: space-evenly;
  align-content: center;
  margin-top: 15px;
}
.button {
  background-image: linear-gradient(120deg, #a6c0fe 0%, #f68084 100%);
  color: white;
  border: none;
}
.loginButton {
  order: 2;
  width: 110px;
  height: 45px;
  margin: 0 70px;
  margin-top: -10px;
  font-size: 26px;
  border-radius: 200px;
}
.goRegButton {
  order: 1;
  width: 90px;
  height: 30px;
  font-size: 14px;
  border-radius: 20px;
}
.checkButton {
  order: 3;
  width: 90px;
  height: 30px;
  font-size: 14px;
  border-radius: 20px;
}
</style>