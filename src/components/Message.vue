<template>
  <div>
    <div class="boxContainer">
      <section class="container">
        <div class="topContent">
          <header class="article-header">
            <h1 class="article-title">留言板</h1>
          </header>
          <article class="article-content">
            <div id="guestbookniao" style="margin-bottom: 30px">
              您想说些什么吗？就在这里发表留言吧~
              欢迎分享你的所得所感！我们会陪你经历
            </div>
            <el-divider></el-divider>
            <blockquote style="font-size: 14px">
              <p>总有一天，该有的总会有，该来的总会来。</p>
              <p>生活不可能像你想象得那么好，但也不会像你想得那么糟。</p>
              <p>人的脆弱和坚强都超乎自己的想象。</p>
              <p>在自己的身上克服这个时代，克服它的混浊、粗粝、不近人情。</p>
              <p>克服它的嘈杂、不公、狼烟四起。</p>
              <p>克服它让我们燃烧了万丈豪情，又用一场场冷雨浇熄的任性。</p>
              <p>
                你要比我更加相信，在这条光荣的荆棘路上，星星之火，可以燎原。
              </p>
            </blockquote>
          </article>
        </div>
        <div class="content">
          <el-divider content-position="center">{{ total }} 条评论</el-divider>
          <div class="postComments">
            <!-- 发表我的留言 -->
            <div class="comm_title">
              <img :src="url" alt="" />
              <p>发表我的留言 ==></p>
              <a href="javascript:;" @click="openComment">
                <i class="iconfont icon-jia"></i>
              </a>
            </div>
            <!-- 发表留言输入框 -->
            <div class="comm_input" v-show="commentBox">
              <el-input
                type="textarea"
                placeholder="请输入内容"
                v-model="newMessage"
                maxlength="250"
                :rows="4"
                show-word-limit
              ></el-input>
              <el-button class="comm_button" type="primary" @click="postComment"
                >发表</el-button
              >
            </div>
          </div>
          <!-- 显示留言列表 -->
          <div class="showComments">
            <el-row
              class="commentList"
              v-for="(item, index) in commentList"
              :key="index"
            >
              <el-divider></el-divider>
              <span class="comm_f">{{ "#" + item.mid }}</span>
              <div class="userComment">
                <img :src="item.avatar" alt="" />
                <div class="comm_main">
                  <p class="comm_user">{{ item.username }}</p>
                  <p class="comm_body">{{ item.message }}</p>
                  <p class="comm_time">{{ item.time }}</p>
                </div>
              </div>
            </el-row>
            <el-pagination
              background
              layout="prev, pager, next"
              :total="total"
              :page-size="pageSize"
              @current-change="handleCurrentChange"
              :current-page="pagenum"
            >
            </el-pagination>
          </div>
        </div>
      </section>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      url: "",
      id: 0,
      newMessage: "",
      pagenum: 1,
      pageSize: 8,
      total: 0,
      commentBox: false,
      tokenStr: "",
      commentList: [],
    };
  },
  mounted() {
    this.id = window.sessionStorage.getItem("id");
    this.getComments();
    this.tokenStr = window.sessionStorage.getItem("token");
    if (this.tokenStr) {
      this.url = window.sessionStorage.getItem("avatar");
    }
  },
  methods: {
    //判断是否登录进行路由拦截
    openComment() {
      this.tokenStr = window.sessionStorage.getItem("token");
      if (!this.tokenStr) {
        this.$message("请先登录");
        this.$router.push("/login");
      } else {
        this.commentBox = !this.commentBox;
      }
    },
    //获取留言信息
    async getComments() {
      const { data: res } = await this.$http.get("getcomm");
      if (res.code !== 200) {
        return this.$message.error("获取留言失败!");
      }
      this.commentList = res.result;
      this.total = this.commentList.length;
      this.commentList = this.commentList.slice(
        (this.pagenum - 1) * this.pageSize,
        this.pagenum * this.pageSize
      );
    },
    //切换分页
    handleCurrentChange(newPage) {
      this.pagenum = newPage;
      this.getComments();
    },
    //发表留言
    async postComment() {
      if (!this.newMessage) {
        return this.$message.error("请输入留言内容!");
      }
      const confirmResult = await this.$confirm(
        "确定要发表这条留言吗?",
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
      const time = await new Date();
      await time.setHours(time.getHours() + 8);
      const { data: res } = await this.$http.post("postcomm", {
        uid: this.id,
        message: this.newMessage,
        time: time,
      });
      if (res.code !== 200) {
        return this.$message.error("发表留言失败!");
      }
      this.$message.success("发表留言成功");
      this.newMessage = "";
      this.getComments();
    },
  },
};
</script>

<style lang="less" scoped>
.boxContainer {
  background-color: #fff;
  position: relative;
}
.container {
  max-width: 800px;
  min-height: 800px;
  position: relative;
  margin: 0 auto;
}
.topContent {
  padding: 45px;
  margin: 0 auto;
}
.article-header {
  margin-bottom: 25px;
  padding: 0;
  font-size: 28px;
}
.article-content {
  word-wrap: break-word;
  line-height: 1.85;
  word-break: break-all;
}
.article-content blockquote {
  border-left: 3px solid #2d2d2d;
  font-weight: 400;
  letter-spacing: 0.01rem;
  margin: 0;
  padding-left: 20px;
}
blockquote {
  display: block;
  margin-block-start: 1em;
  margin-block-end: 1em;
  margin-inline-start: 40px;
  margin-inline-end: 40px;
}
.comm_title {
  margin: 30px 0;
  display: flex;
  position: relative;
  font-size: 18px;
  color: rgb(64, 158, 255);
  img {
    width: 60px;
    height: 60px;
    border: 1px #eee solid;
    margin-right: 20px;
  }
  i {
    position: absolute;
    right: 30px;
    font-size: 40px;
    color: rgb(64, 158, 255);
    top: 5px;
  }
}
.comm_button {
  margin: 20px 0;
}
.showComments {
  margin-bottom: 70px;
}
.commentlist {
  position: relative;
  list-style: none;
  margin-block-start: 1em;
  margin-block-end: 1em;
  margin-inline-start: 0px;
  margin-inline-end: 0px;
  padding-inline-start: 40px;
}
.comm_f {
  position: absolute;
  top: 40px;
  right: 40px;
  display: block;
  padding: 0 4px;
  height: 22px;
  background: #f2f2f2;
  color: #888;
  text-align: center;
  font-size: 14px;
  line-height: 22px;
}
.userComment {
  position: relative;
  display: flex;
  img {
    width: 60px;
    height: 60px;
    border: 1px #eee solid;
    margin-right: 10px;
  }
}
.comm_main {
  width: 100%;
}
.comm_user {
  margin-top: 5px;
  font-size: 18px;
  color: rgb(226, 65, 25);
}
.comm_body {
  margin: 30px 0;
  font-size: 16px;
}
.comm_time {
  margin-bottom: 0px;
  font-size: 14px;
  color: #888;
}
.el-pagination {
  margin: 20px 0;
  margin-left: 50%;
  transform: translateX(-25%);
}
</style>