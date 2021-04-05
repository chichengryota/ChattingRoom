<template>
  <div class="register_container">
    <!-- 背景图片 -->
    <div class="registerBg">
      <img src="../assets/img/registerbg.jpg" alt />
    </div>
    <div class="register_box">
      <!-- 登录表单区域 -->
      <h1>REGISTER</h1>
      <button class="goHomeButton" @click="goHome">首页</button>
      <el-form
        :model="registerForm"
        :rules="registerFormRules"
        ref="registerFormRef"
        class="register_form"
        @submit.native.prevent
      >
        <!-- 用户名 -->
        <el-form-item prop="username">
          <el-input
            v-model="registerForm.username"
            prefix-icon="iconfont icon-user"
            class="inputStyle"
            placeholder="输入用户名"
            ref="input1"
          ></el-input>
        </el-form-item>
        <!-- 邮箱 -->
        <el-form-item prop="email">
          <el-input
            v-model="registerForm.email"
            prefix-icon="iconfont icon-youxiang1"
            class="inputStyle"
            placeholder="输入邮箱"
            @blur="checkEmail"
          ></el-input>
        </el-form-item>
        <!-- 密码 -->
        <el-form-item prop="password">
          <el-input
            v-model="registerForm.password"
            show-password
            prefix-icon="iconfont icon-password"
            class="inputStyle"
            placeholder="输入密码"
          ></el-input>
        </el-form-item>
        <!-- 确认密码 -->
        <el-form-item prop="confirmPassword">
          <el-input
            v-model="registerForm.confirmPassword"
            show-password
            prefix-icon="iconfont icon-password"
            class="inputStyle"
            placeholder="确认密码"
          ></el-input>
        </el-form-item>
        <!-- 按钮区域 -->
        <el-form-item>
          <div class="btns">
            <button class="registerButton" @click="register">注册</button>
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
      registerForm: {
        username: "",
        password: "",
        email: "",
        confirmPassword: "",
      },
      registerFormRules: {
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
        confirmPassword: [
          { required: true, message: "请确认用户密码", trigger: "blur" },
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
      if (
        this.registerForm.email != "" &&
        !regEmail.test(this.registerForm.email)
      ) {
        this.$message.error("邮箱格式不正确");
        this.registerForm.email = "";
      }
    },
    register() {
      if (this.registerForm.password !== this.registerForm.confirmPassword) {
        return this.$message.error("密码输入不一致!");
      } else {
        this.$refs.registerFormRef.validate(async (valid) => {
          if (!valid) return;
          const { data: res } = await this.$http.post("register", {
            params: this.registerForm,
          });
          if (res.code !== 200) {
            return this.$message.error(res.msg);
          }
          this.$message.success(res.msg);
          this.$router.push("/login");
        });
      }
    },
    goHome() {
      this.$router.push("/");
    },
  },
};
</script>

<style lang="less" scoped>
.registerBg {
  background-repeat: no-repeat;
  position: absolute;
  width: 100vw;
  height: 100vh;
  img {
    width: 100%;
  }
}
.register_container {
  height: 100%;
}
.register_box {
  width: 500px;
  height: 470px;
  border-radius: 20px;
  background-color: #00000090;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  h1 {
    color: rgb(240, 199, 218);
    text-align: center;
    margin: 35px 0;
  }
}

/deep/.register_form {
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
  display: flex;
  align-items: center;
  justify-content: center;
}
.registerButton {
  width: 110px;
  height: 45px;
  font-size: 22px;
  font-weight: bold;
  border: none;
  color: white;
  border-radius: 200px;
  background-image: linear-gradient(120deg, #a6c0fe 0%, #f68084 100%);
  cursor: pointer;
}
.goHomeButton {
  position: absolute;
  top: 30px;
  right: 36px;
  width: 42px;
  height: 42px;
  font-size: 15px;
  font-weight: bold;
  border: none;
  color: white;
  border-radius: 50%;
  background-image: linear-gradient(120deg, #a6c0fe 0%, #f68084 100%);
  cursor: pointer;
}
</style>