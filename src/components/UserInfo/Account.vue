<template>
  <div>
    <div class="accountContainer">
      <div class="updateEmail">
        <h1>绑定邮箱</h1>
        <el-form
          :model="emailForm"
          ref="emailFormRef"
          label-width="100px"
          class="accountEmail"
        >
          <el-form-item label="修改邮箱" prop="email">
            <el-input
              prefix-icon="iconfont icon-youxiang1"
              v-model="emailForm.email"
              @blur="sendEmail"
            ></el-input>
          </el-form-item>
        </el-form>
        <el-button type="primary" @click="updateEmail">提交</el-button>
      </div>
      <div class="updatePwd">
        <h1>修改密码</h1>
        <el-form
          :model="accountForm"
          status-icon
          :rules="accountFormRules"
          ref="accountFormRef"
          label-width="100px"
          class="accountPwd"
        >
          <el-form-item label="当前密码" prop="password">
            <el-input
              type="password"
              v-model="accountForm.password"
              autocomplete="off"
              prefix-icon="iconfont icon-password"
            ></el-input>
          </el-form-item>
          <el-form-item label="新的密码" prop="newPassWord">
            <el-input
              type="password"
              v-model="accountForm.newPassWord"
              autocomplete="off"
              prefix-icon="iconfont icon-password"
            ></el-input>
          </el-form-item>
          <el-form-item label="确认密码" prop="checkPassWord">
            <el-input
              type="password"
              v-model="accountForm.checkPassWord"
              autocomplete="off"
              prefix-icon="iconfont icon-password"
            ></el-input>
          </el-form-item>
        </el-form>
        <el-button type="primary" @click="updatePwd">确认修改</el-button>
      </div>
      <div class="deleteAccount">
        <h1>注销账号</h1>
        <el-alert
          title="警告! 账号一旦注销，不可找回，请谨慎操作"
          type="warning"
          show-icon
        >
        </el-alert>
        <el-button type="danger" @click="dialogVisible = true">注销</el-button>
      </div>
      <el-dialog title="注销账号" :visible.sync="dialogVisible" width="28%">
        <span>账号注销后将永久删除账号，确认注销吗？</span>
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="deleteAccount">确 定</el-button>
        </span>
      </el-dialog>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    var validatePass = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请输入密码"));
      } else {
        if (this.accountForm.checkPassWord !== "") {
          this.$refs.accountFormRef.validateField("checkPassWord");
        }
        callback();
      }
    };
    var validatePass2 = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请再次输入密码"));
      } else if (value !== this.accountForm.newPassWord) {
        callback(new Error("两次输入密码不一致!"));
      } else {
        callback();
      }
    };
    return {
      emailForm: {
        email: "",
      },
      accountForm: {
        password: "",
        newPassWord: "",
        checkPassWord: "",
      },
      id: 0,
      dialogVisible: false,
      accountFormRules: {
        password: [
          { required: true, message: "请输入用户密码", trigger: "blur" },
        ],
        newPassWord: [
          { validator: validatePass, trigger: "blur" },
          {
            min: 6,
            max: 15,
            message: "长度在 6 到 15 个字符",
            trigger: "blur",
          },
        ],
        checkPassWord: [
          { validator: validatePass2, trigger: "blur" },
          {
            min: 6,
            max: 15,
            message: "长度在 6 到 15 个字符",
            trigger: "blur",
          },
        ],
      },
    };
  },
  mounted() {
    this.id = window.sessionStorage.getItem("id");
    this.getEmail();
  },
  methods: {
    sendEmail: function () {
      var regEmail = /^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
      if (this.emailForm.email != "" && !regEmail.test(this.emailForm.email)) {
        this.$message({
          message: "邮箱格式不正确",
          type: "error",
        });
        this.emailForm.email = "";
      }
    },
    async getEmail() {
      const { data: res } = await this.$http.post("shuserinfo", {
        id: this.id,
      });
      this.emailForm.email = res.data.email;
    },
    updateEmail() {
      this.$refs.emailFormRef.validate(async (valid) => {
        if (!valid) return;
        const confirmResult = await this.$confirm(
          "确定要更改绑定邮箱吗?",
          "提示",
          {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            type: "success",
          }
        ).catch((err) => err);
        if (confirmResult !== "confirm") {
          return this.$message.info("取消了删除");
        }
        const { data: res } = await this.$http.post("upemail", {
          id: this.id,
          email: this.emailForm.email,
        });
        if (res.code === 201) {
          return this.$message.error("更改绑定邮箱失败，邮箱已存在!");
        } else if (res.code === 500) {
          return this.$message.error("更改绑定邮箱失败，服务器错误!");
        }
        this.$message.success("绑定邮箱成功");
      });
    },
    updatePwd() {
      this.$refs.accountFormRef.validate(async (valid) => {
        if (!valid) return;
        const confirmResult = await this.$confirm("确定要修改密码吗?", "提示", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "success",
        }).catch((err) => err);
        if (confirmResult !== "confirm") {
          return this.$message.info("取消了删除");
        }
        const { data: res } = await this.$http.post("uppwd", {
          id: this.id,
          password: this.accountForm.password,
          newPassWord: this.accountForm.newPassWord,
        });
        if (res.code === 201) {
          return this.$message.error("当前密码输入错误!");
        } else if (res.code === 500) {
          return this.$message.error("修改密码失败，服务器错误!");
        }
        this.$message.success("修改密码成功");
      });
    },
    async deleteAccount() {
      const { data: res } = await this.$http.post("deluser", {
        id: this.id,
      });
      if (res.code !== 200) {
        return this.$message.error("注销账号失败!");
      }
      this.$message.success("注销账号成功");
      this.dialogVisible = false;
      window.sessionStorage.clear();
      this.$router.push("/login");
    },
  },
};
</script>

<style lang="less" scoped>
.accountContainer {
  margin: 0 70px 20px;
}
.el-button {
  margin-left: 15px;
}
.el-alert {
  margin-bottom: 20px;
}
</style>