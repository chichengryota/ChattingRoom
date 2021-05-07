<template>
  <div class="homeMain">
    <el-card :body-style="{ padding: '0px' }">
      <div class="homeMain-content" @click="goMessage">
        <img src="../assets/img/card1.jpg" class="image" />
        <div class="boxName">
          <span>留言板</span>
        </div>
      </div>
    </el-card>
    <el-card :body-style="{ padding: '0px' }">
      <div class="homeMain-content" @click="goChatting">
        <img src="../assets/img/card2.jpg" class="image" />
        <div class="boxName">
          <span>聊天室</span>
        </div>
      </div>
    </el-card>
    <el-card :body-style="{ padding: '0px' }">
      <div class="homeMain-content" @click="goMusicRoom">
        <img src="../assets/img/card3.jpg" class="image" />
        <div class="boxName">
          <span>发现</span>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script>
export default {
  data() {
    return {};
  },
  methods: {
    goMessage() {
      this.$router.push("/dynamic");
    },
    goChatting() {
      this.$router.push("/chatting");
    },
    goMusicRoom() {
      this.$router.push("/find");
    },
  },
};
</script>

<style lang="less" scoped>
.homeMain {
  margin-top: 90px;
  display: flex;
  justify-content: space-evenly;
  align-items: center;
  padding: 0 50px;
}
.el-card {
  width: 22%;
  height: 440px;
  box-shadow: 0 0 5px rgba(0, 0, 0, 0.6) !important;
  border: none;
  // padding: 10px;
  .homeMain-content {
    width: 100%;
    height: 100%;
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
    .image {
      width: 100%;
      height: 440px;
    }
    .boxName {
      width: 100%;
      text-align: center;
      height: 40px;
      line-height: 40px;
      font-size: 22px;
      font-weight: bold;
      color: rgb(85, 26, 139);
      position: absolute;
      bottom: 0;
      background-color: #fff;
    }
  }
}
.homeMain-content:hover img {
  opacity: 0.8;
  transform: scale(1.4) rotate(7deg);
  transition-duration: 0.4s;
}
.homeMain-content:hover .boxName {
  top: 45%;
  font-size: 50px;
  color: rgb(226, 163, 92);
  background-color: rgba(255, 255, 255, 0);
}
</style>