<template>
  <div>
    <el-row>
      <el-col :span="5" :push="3">
        <el-card :body-style="{ padding: '0px' }">
          <a href="javascript:;" @click="goMessage">
            <img src="../assets/img/card1.jpg" class="image" />
            <div class="boxName">
              <span>留言板</span>
            </div>
          </a>
        </el-card>
      </el-col>
      <el-col :span="5" :push="4">
        <el-card :body-style="{ padding: '0px' }">
          <a href="javascript:;" @click="goChatting">
            <img src="../assets/img/card2.jpg" class="image" />
            <div class="boxName">
              <span>聊天室</span>
            </div>
          </a>
        </el-card>
      </el-col>
      <el-col :span="5" :push="5">
        <el-card :body-style="{ padding: '0px' }">
          <a href="javascript:;">
            <img src="../assets/img/card3.jpg" class="image" />
            <div class="boxName">
              <span>发现</span>
            </div>
          </a>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  data() {
    return {};
  },
  methods: {
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
.el-row {
  margin-top: 70px;
}
.el-card {
  height: 440px;
  position: relative;
  box-shadow: 0 0 5px rgba(0, 0, 0, 0.6) !important;
  border: none;
  img {
    width: 700px;
    position: absolute;
    left: -200px;
  }
  .boxName {
    position: absolute;
    width: 100%;
    height: 40px;
    line-height: 40px;
    bottom: 0;
    font-size: 22px;
    font-weight: bold;
    text-align: center;
    padding-bottom: 5px;
    color: rgb(85, 26, 139);
  }
}
.el-card:hover img {
  opacity: 0.7;
  transform: scale(1.4) rotate(7deg);
  transition-duration: 0.4s;
}
.el-card:hover .boxName {
  height: 220px;
  font-size: 50px;
  color: rgb(226, 163, 92);
}
</style>