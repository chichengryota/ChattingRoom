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
              <img :src="userInfo.avatar || avatar" alt="" />
              <p>发表我的留言 ==></p>
              <div @click="openComment">
                <i class="iconfont icon-jia"></i>
              </div>
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
              <el-button class="comm_button" type="primary" @click="postDynamic"
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
                  <div class="comm_user">{{ item.username }}</div>
                  <div class="comm_body">{{ item.message }}</div>
                  <div class="comm_bottom">
                    <span class="comm_time">{{ item.time }}</span>
                    <span class="comm_reply" @click="replyComment(item.mid)"
                      >回复</span
                    >
                  </div>
                  <div class="reply" v-if="item.reply.length !== 0">
                    <div
                      class="reply-list"
                      v-for="(item1, index1) in item.reply"
                      :key="index1"
                    >
                      <img :src="item1.avatar" alt="" />
                      <div class="comm_main">
                        <div class="comm_user">
                          <span class="comm_user1">{{ item1.username }}</span>
                          <span class="comm_text">回复</span>
                          <span class="comm_user2"
                            >@{{ item1.reply_name }}</span
                          >
                        </div>
                        <div class="comm_body">{{ item1.message }}</div>
                        <div class="comm_bottom">
                          <span class="comm_time">{{ item1.time }}</span>
                          <span
                            class="comm_reply"
                            @click="replyComment(item.mid, item1.id)"
                            >回复</span
                          >
                        </div>
                      </div>
                    </div>
                  </div>
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
          <el-dialog
            title="发表评论"
            :visible.sync="dialogFormVisible"
            width="30%"
            top="30vh"
            @close="cancelPost"
          >
            <el-input
              v-model="comment"
              type="textarea"
              autocomplete="off"
              placeholder="请输入您要发表的评论内容"
            ></el-input>
            <div slot="footer" class="dialog-footer">
              <el-button @click="dialogFormVisible = false">取 消</el-button>
              <el-button type="primary" @click="postComment">确 定</el-button>
            </div>
          </el-dialog>
        </div>
      </section>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      avatar: "",
      userInfo: {},
      newMessage: "",
      comment: "",
      commentBox: false,
      tokenStr: "",
      commentList: [],
      pagenum: 1,
      pageSize: 8,
      total: 0,
      dialogFormVisible: false,
      mid: null,
      replyId: null,
    };
  },
  created() {
    this.tokenStr = window.sessionStorage.getItem("token");
    if (this.tokenStr) {
      let userInfo = window.sessionStorage.getItem("userInfo");
      this.userInfo = JSON.parse(userInfo);
    }
    this.getComments();
  },
  methods: {
    //判断是否登录进行路由拦截
    openComment() {
      if (this.tokenStr) {
        this.commentBox = !this.commentBox;
      } else {
        this.$message.warning("请先登录");
        this.$router.push("/login");
      }
    },
    //获取留言信息
    async getComments() {
      const { data: res } = await this.$http.get("message/get/dynamic");
      console.log(res);
      this.avatar = res.avatar;
      this.commentList = res.data;
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
    async postDynamic() {
      if (!this.newMessage) {
        return this.$message.warning("请输入留言内容!");
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
        return this.$message.info("取消发布");
      }
      const time = await new Date();
      await time.setHours(time.getHours() + 8);
      const { data: res } = await this.$http.post("message/post/dynamic", {
        uid: this.userInfo.id,
        message: this.newMessage,
        time: time,
      });
      if (res.code !== 200) {
        return this.$message.error(res.msg);
      }
      this.$message.success(res.msg);
      this.newMessage = "";
      this.getComments();
    },
    replyComment(mid, replyId) {
      if (!this.tokenStr) {
        this.$message.warning("请先登录");
        this.$router.push("/login");
      } else {
        this.mid = mid;
        if (replyId) {
          this.replyId = replyId;
        }
        this.dialogFormVisible = true;
      }
    },
    cancelPost() {
      this.mid = null;
      this.replyId = null;
      this.comment = "";
    },
    // 发表评论
    async postComment() {
      if (!this.comment) {
        return this.$message.warning("请输入要评论的内容!");
      }
      console.log(this.mid);
      console.log(this.replyId);
      const time = await new Date();
      await time.setHours(time.getHours() + 8);
      const { data: res } = await this.$http.post("message/post/comment", {
        uid: this.userInfo.id,
        comment: this.comment,
        time: time,
        mid: this.mid,
        reply_id: this.replyId,
      });
      if (res.code !== 200) {
        return this.$message.error(res.msg);
      }
      this.$message.success(res.msg);
      this.getComments();
      this.comment = "";
      this.dialogFormVisible = false;
    },
  },
};
</script>

<style lang="less" scoped>
@blue-color: rgb(64, 158, 255);
@red-color: rgb(226, 65, 25);
.boxContainer {
  background-color: rgb(249, 249, 249);
  .container {
    background-color: #fff;
    max-width: 950px;
    min-height: 100vh;
    margin: 0 auto;
    .topContent {
      padding: 45px;
      margin: 0 auto;
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
    }
  }
}
.comm_title {
  margin: 30px 0;
  padding: 0 40px;
  display: flex;
  align-items: center;
  position: relative;
  font-size: 18px;
  color: @blue-color;
  img {
    margin-right: 20px;
  }
  i {
    position: absolute;
    right: 30px;
    font-size: 40px;
    color: @blue-color;
    top: 10px;
    cursor: pointer;
  }
}
.comm_input {
  padding: 0 40px;
  .comm_button {
    margin: 20px 0;
  }
}
.showComments {
  padding: 0 40px;
  padding-bottom: 30px;
}
.commentlist {
  position: relative;
  list-style: none;
}
.comm_f {
  position: absolute;
  top: 40px;
  right: 40px;
  display: block;
  padding: 0 5px;
  height: 22px;
  background: #f2f2f2;
  color: #888;
  text-align: center;
  font-size: 16px;
  line-height: 22px;
}
img {
  width: 60px;
  height: 60px;
  border: 1px #eee solid;
  margin-right: 12px;
  border-radius: 6px;
}
.userComment {
  position: relative;
  display: flex;
}
.comm_main {
  width: 100%;
  .comm_user {
    margin-top: 5px;
    font-size: 18px;
    color: @red-color;
  }
  .comm_body {
    margin: 24px 0;
    font-size: 16px;
  }
  .comm_bottom {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-right: 40px;
    .comm_time {
      margin-bottom: 0px;
      font-size: 14px;
      color: #888;
    }
    .comm_reply {
      color: @blue-color;
      cursor: pointer;
      background: #eee;
      padding: 1px 6px;
      border-radius: 4px;
    }
  }
}
.reply {
  background-color: #eee;
  margin-top: 10px;
  padding: 10px 20px;
  border-radius: 6px;
  .reply-list {
    position: relative;
    display: flex;
    img {
      width: 50px;
      height: 50px;
    }
    .comm_main {
      margin: 16px 0;
      .comm_user {
        margin-top: -10px;
        font-size: 16px;
        .comm_text {
          color: black;
          margin: 0 5px;
        }
        .comm_user2 {
          color: @blue-color;
          font-size: 16px;
        }
      }
      .comm_body {
        margin: 16px 0;
      }
      .comm_bottom {
        padding-right: 20px;
      }
    }
  }
}
.el-pagination {
  margin: 20px 0;
  margin-left: 50%;
  transform: translateX(-25%);
}
</style>