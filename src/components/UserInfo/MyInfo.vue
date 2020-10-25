<template>
  <div>
    <div class="userContainer">
      <div class="avatarContainer">
        <el-avatar :src="url" :size="170"></el-avatar>
        <el-upload
          class="avatar-uploader"
          action="http://localhost:3000/upload"
          :show-file-list="false"
          :on-success="handleAvatarSuccess"
          :before-upload="beforeuploadButton"
        >
          <img v-if="imageUrl" :src="imageUrl" class="avatarImg" />
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>
        <el-button type="primary" class="uploadButton" @click="uploadAvatar"
          >更换头像</el-button
        >
      </div>
      <div class="userInfoContainer">
        <el-form
          :label-position="labelPosition"
          :model="userInfoForm"
          ref="userInfoFormRef"
        >
          <el-form-item label="用户名">
            <el-input v-model="userInfoForm.username" disabled></el-input>
          </el-form-item>
          <el-form-item label="个性签名">
            <el-input
              v-model="userInfoForm.signature"
              prefix-icon="iconfont icon-qianming"
            ></el-input>
          </el-form-item>
          <el-form-item label="性别">
            <el-radio-group v-model="userInfoForm.sex">
              <el-radio label="男"></el-radio>
              <el-radio label="女"></el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="生日">
            <el-date-picker
              type="date"
              v-model="userInfoForm.birthday"
              style="width: 100%"
            ></el-date-picker>
          </el-form-item>
        </el-form>
        <el-button type="primary" class="userInfoButton" @click="updateUserInfo"
          >保存</el-button
        >
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      url: "",
      imageUrl: "",
      tempUrl: "",
      id: 0,
      avatar: "",
      userInfoForm: {
        username: "",
        signature: "",
        sex: "",
        birthday: "",
      },
      labelPosition: "top",
    };
  },
  mounted() {
    this.id = window.sessionStorage.getItem("id");
    this.showUserInfo();
  },
  methods: {
    handleAvatarSuccess(res, file) {
      this.imageUrl = URL.createObjectURL(file.raw);
      this.tempUrl = res;
    },
    beforeuploadButton(file) {
      const isJPG = file.type === "image/jpeg";
      const isLt2M = file.size / 1024 / 1024 < 2;
      if (!isJPG) {
        this.$message.error("上传头像图片只能是 JPG 格式!");
      }
      if (!isLt2M) {
        this.$message.error("上传头像图片大小不能超过 2MB!");
      }
      return isJPG && isLt2M;
    },
    async uploadAvatar() {
      if (this.imageUrl !== "") {
        const { data: res } = await this.$http.post("upavatar", {
          id: this.id,
          imgUrl: this.tempUrl,
        });
        if (res.code !== 200) {
          return this.$message.error("上传头像失败!");
        }
        this.$message.success("上传头像成功");
        this.url = this.tempUrl;
        this.imageUrl = "";
      }
    },
    async showUserInfo() {
      const { data: res } = await this.$http.post("shuserinfo", {
        id: this.id,
      });
      if (res.code !== 200) {
        return this.$message.error("获取用户信息失败!");
      }
      this.url = res.data.avatar;
      this.userInfoForm = res.data;
    },
    updateUserInfo() {
      this.$refs.userInfoFormRef.validate(async (valid) => {
        if (!valid) return;
        const { data: res } = await this.$http.post("upuserinfo", {
          id: this.id,
          userInfoForm: this.userInfoForm,
        });
        if (res.code !== 200) {
          return this.$message.error("更新用户信息失败!");
        }
        this.$message.success("更新用户信息成功!");
      });
    },
  },
};
</script>

<style lang="less" scoped>
.userContainer {
  display: flex;
  justify-content: space-around;
}
.avatarContainer {
  width: 170px;
  display: flex;
  flex-direction: column;
  margin-left: 100px;
}
.el-avatar {
  margin: 0 auto;
  margin: 40px 0;
}
.avatar-uploader {
  border: 1px dashed rgb(206, 206, 206);
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader:hover {
  border-color: #409eff;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 170px;
  height: 170px;
  line-height: 170px;
  text-align: center;
}
.avatarImg {
  width: 170px;
  height: 170px;
  display: block;
}
.uploadButton {
  text-align: center;
  margin: 30px auto;
}
.userInfoContainer {
  width: 100%;
  margin: 30px 120px;
}
</style>