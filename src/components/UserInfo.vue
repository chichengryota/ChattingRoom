<template>
  <div class="userinfo">
    <el-card>
      <el-menu
        :default-active="activeIndex"
        class="el-menu-demo"
        mode="horizontal"
        @select="handleSelect"
      >
        <el-menu-item index="1">个人资料</el-menu-item>
        <el-menu-item index="2">账号安全</el-menu-item>
        <el-menu-item index="3">我的消息</el-menu-item>
      </el-menu>
      <router-view></router-view>
    </el-card>
  </div>
</template>

<script>
export default {
  data() {
    return {
      activeIndex: "1",
    };
  },
  mounted() {
    this.getRoutePath();
  },
  updated() {
    this.getRoutePath();
  },
  methods: {
    handleSelect(key) {
      switch (key) {
        case "1":
          if (this.activeIndex == "1") {
            return;
          } else {
            this.$router.push("/userinfo/1");
          }
          break;
        case "2":
          if (this.activeIndex == "2") {
            return;
          } else {
            this.$router.push("/userinfo/2");
          }
          break;
        case "3":
          if (this.activeIndex == "3") {
            return;
          } else {
            this.$router.push("/userinfo/3");
          }
          break;
      }
    },
    getRoutePath() {
      var path = this.$route.path;
      if (path === "/userinfo/1") {
        this.activeIndex = "1";
      } else if (path === "/userinfo/2") {
        this.activeIndex = "2";
      } else if (path === "/userinfo/3") {
        this.activeIndex = "3";
      }
    },
  },
};
</script>

<style lang="less" scoped>
.userinfo {
  padding-bottom: 20px;
}
.el-card {
  height: 100%;
  width: 75%;
  margin: 0 auto;
  margin-top: 20px;
  position: relative;
  .el-menu-demo {
    margin-bottom: 30px;
    .el-menu-item {
      font-size: 16px;
    }
  }
}
</style>