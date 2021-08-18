<template>
  <div class="my-message">
    <div v-if="commentList.length !== 0" class="message-content">
      <div
        class="message-item"
        v-for="(item, index) in commentList"
        :key="index"
      >
        <img :src="item.avatar" alt="" />
        <div class="message-main">
          <div class="message-top">
            <span class="message-name">{{ item.username }}</span>
            <span class="message-time">{{ item.time }}</span>
          </div>
          <div class="message-text">
            {{ item.message }}
          </div>
        </div>
      </div>
    </div>
    <div v-else style="margin-left: 20px">当前暂无消息...</div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      commentList: [],
    };
  },
  created() {
    let userInfo = window.sessionStorage.getItem("userInfo");
    let uid = JSON.parse(userInfo).id;
    this.getMyComment(uid);
  },
  methods: {
    async getMyComment(uid) {
      const { data: res } = await this.$http.post("message/get/mycomment", {
        uid: uid,
      });
      this.commentList = res.data.reverse();
    },
  },
};
</script>

<style lang="less" scoped>
.my-message {
  min-height: 400px;
  .message-content {
    padding: 0 40px;
    box-sizing: border-box;
    .message-item {
      background-color: #eee;
      padding: 20px;
      padding-right: 150px;
      display: flex;
      border-radius: 6px;
      margin-bottom: 20px;
      position: relative;
      img {
        width: 60px;
        height: 60px;
        border-radius: 6px;
        margin-right: 20px;
      }
      .message-top {
        display: flex;
        align-items: center;
        margin-bottom: 16px;
        .message-name {
          font-size: 18px;
          color: rgb(226, 65, 25);
        }
        .message-time {
          position: absolute;
          right: 50px;
          font-size: 14px;
          color: #888;
        }
      }
      .message-text {
        font-size: 16px;
        line-height: 30px;
      }
    }
  }
}
</style>
