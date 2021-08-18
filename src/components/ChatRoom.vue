<template>
  <div class="chatRoom" ref="room">
    <div class="chatList">
      <div class="avatar">
        <img :src="user.avatar" alt="" />
        <span>{{ user.username }}</span>
      </div>
      <el-divider></el-divider>
      <div
        class="group"
        :class="isGroup ? 'active-user' : ''"
        @click="chooseGroup"
      >
        <img src="../assets/img/star.png" alt="" />
        <span>群聊</span>
      </div>
      <div class="listTop">
        <span>当前用户列表</span>
      </div>
      <div class="userChat">
        <div
          class="userBox"
          :class="active === index ? 'active-user' : ''"
          @click="chooseUser(item, index)"
          v-for="(item, index) in userList"
          :key="index"
        >
          <img :src="item.avatar" alt="" />
          <span>{{ item.username }}</span>
        </div>
      </div>
    </div>
    <div class="roomRight">
      <p class="name" v-if="isGroup">聊天室({{ userListLength }})</p>
      <p class="name" v-else>{{ username }}</p>
      <div class="chatContent">
        <ul class="join" ref="joinUs">
          <li
            v-for="(item1, index) in messageContent"
            :key="index"
            :class="{
              'my-message': item1.type === 1 ? true : false,
              'other-message': item1.type === 2 ? true : false,
            }"
          >
            <div v-if="item1.type === 3">
              欢迎{{ item1.username }}加入聊天室
            </div>
            <div v-if="item1.type === 4">{{ item1.username }}离开了聊天室</div>
            <div v-if="item1.type === 1">
              <img
                :src="item1.file"
                alt
                class="file"
                v-if="item1.file"
                @load="loadOverImg"
                preview="1"
              />
              <span v-else>{{ item1.msg }}</span>
              <img :src="item1.avatar" class="avatar" />
            </div>
            <div v-if="item1.type === 2">
              <img :src="item1.avatar" alt class="avatar" />
              <p class="username">{{ item1.username }}</p>
              <img
                :src="item1.file"
                alt
                class="file"
                v-if="item1.file"
                @load="loadOverImg"
                preview="1"
              />
              <p class="content" v-else>{{ item1.msg }}</p>
            </div>
          </li>
        </ul>
      </div>
      <div class="sendMessage">
        <div class="icon">
          <span
            class="iconfont icon-smile"
            @click="emojiShow = !emojiShow"
          ></span>
          <div
            class="emoji"
            tabindex="1"
            v-show="emojiShow"
            @blur="handleEmojiBlur"
          >
            <span
              v-for="item in emojiList"
              :key="item.codes"
              @click="handleEmoji(item)"
              >{{ item.char }}</span
            >
          </div>
          <label class="iconfont icon-Path" for="file"></label>
          <input
            type="file"
            style="display: none"
            id="file"
            @change="handleFile"
          />
          <span class="iconfont icon-jietu" @click="handleCanvas"></span>
        </div>
        <textarea
          cols="80"
          rows="5"
          ref="textarea"
          @keydown.enter="handlePress"
        ></textarea>
        <button class="sendMessage" @click="sendContentToServe">发送</button>
        <img :src="imgUrl" alt />
      </div>
    </div>
  </div>
</template>

<script>
import html2canvas from "html2canvas";
import emoji from "../assets/emoji.json";
export default {
  name: "Room",
  props: {
    user: Object,
    userList: Array,
  },
  data() {
    return {
      messageContent: [], //0不渲染，1表示自己发出的信息，2表示别人发出的信息
      groupContent: [],
      oneContent: [],
      emojiList: [],
      content: "", // 输入框的内容
      emojiShow: false, // 表情框
      imgUrl: "", // 图片或截图
      isGroup: true, // 是否是群聊
      active: null, // 当前聊天用户
      username: null, // 当前聊天用户名
    };
  },
  computed: {
    userListLength() {
      return this.userList.length;
    },
  },
  mounted() {
    this.emojiList = emoji;
    this.userList.forEach((val, i) => {
      this.oneContent[i] = [];
    });
  },
  updated() {
    // 聊天定位到底部
    this.handleScrollBottom();
  },
  watch: {
    groupContent: {
      handler(val) {
        this.messageContent = val;
      },
      deep: true,
    },
    oneContent: {
      handler(val) {
        this.messageContent = val;
      },
      deep: true,
    },
  },
  methods: {
    // 监听键盘按下事件
    handlePress(e) {
      if (e.ctrlKey && e.keyCode == 13) {
        //用户点击ctrl+enter触发换行
        this.$refs.textarea.value += "\n";
      } else {
        //用户点击了enter触发发送消息
        this.sendContentToServe();
      }
    },
    //发送截图
    handleCanvas() {
      const room = this.$refs.room;
      html2canvas(room).then((canvas) => {
        const file = canvas.toDataURL();
        this.$emit("handleFile", file, this.isGroup);
        if (!this.isGroup) {
          this.oneContent.push({ ...this.user, file, type: 1 });
        }
      });
    },
    handleEmojiBlur() {
      this.emojiShow = false;
    },
    // 输入表情
    handleEmoji(emoji) {
      this.content = this.$refs.textarea.value;
      this.$refs.textarea.value += emoji.char;
    },
    loadOverImg() {
      // 图片预览
      this.$previewRefresh();
      this.handleScrollBottom();
    },
    // 处理收到的群聊消息
    handleGroup(data) {
      this.isGroup = true;
      this.active = null;
      this.handleMessageBox(data);
    },
    // 处理收到的单聊消息
    handleOne(data) {
      this.isGroup = false;
      this.userList.forEach((val, i) => {
        if (val.username == data.username) {
          this.active = i;
          this.username = val.username;
        }
      });
      this.$emit("activeSid", data.sid);
      this.handleMessageBox(data);
    },
    // 给发送图片做限制
    handleFile(e) {
      const file = e.target.files[0];
      if (file.size > 1024 * 1024) {
        return this.$message.info("发送图片大小不能超过1M!");
      }
      const reader = new FileReader(); // 创建读取文件对象
      reader.readAsDataURL(file); // 发起异步请求，读取文件
      reader.onload = (e) => {
        let file = e.target.result;
        // 文件读取完成后
        // 读取完成后，将结果赋值给img的src
        this.$emit("handleFile", file, this.isGroup);
        if (!this.isGroup) {
          this.oneContent.push({ ...this.user, file, type: 1 });
        }
      };
    },
    haveOneJoinRoom() {
      const joinRoom = this.$store.state.joinRoom;
      this.groupContent.push({ ...joinRoom, type: 3 });
    },
    haveOneleaveRoom() {
      const leaveRoom = this.$store.state.leaveRoom;
      this.groupContent.push({ ...leaveRoom, type: 4 });
    },
    // 点击发送按钮
    sendContentToServe() {
      // 获取到聊天的内容
      this.content = this.$refs.textarea.value;
      this.$refs.textarea.value = "";
      if (!this.content) {
        return alert("请输入内容");
      }
      //发送给服务器
      this.$emit("sendServer", this.content, this.isGroup);
      let msg = this.content;
      if (!this.isGroup) {
        this.oneContent.push({ ...this.user, msg, type: 1 });
      }
    },
    // 分类显示聊天窗口中的内容
    handleMessageBox(newValue) {
      // 群组消息
      if (this.isGroup) {
        if (newValue.username === this.user.username) {
          //是自己发的信息
          this.groupContent.push({ ...newValue, type: 1 });
        } else {
          //是别人发的信息
          this.groupContent.push({ ...newValue, type: 2 });
        }
        this.messageContent = this.groupContent;
      } else {
        // 单人消息
        if (this.oneContent.length > 1) {
          let user = this.oneContent[this.oneContent.length - 1];
          if (newValue.username !== user.username) {
            this.oneContent = [];
          }
        }
        this.oneContent.push({ ...newValue, type: 2 });
        this.messageContent = this.oneContent;
      }
    },
    handleScrollBottom() {
      const ul = this.$refs.joinUs;
      ul.scrollTop = ul.scrollHeight;
    },
    // 点击群聊进入群聊房间
    chooseGroup() {
      this.active = null;
      this.isGroup = true;
      this.$refs.textarea.value = "";
      this.messageContent = this.groupContent;
    },
    // 点击用户进行单聊
    chooseUser(user, index) {
      if (user.username == this.user.username) return;
      this.isGroup = false;
      if (this.active !== index) {
        this.active = index;
        this.oneContent = [];
        this.username = user.username;
        this.$refs.textarea.value = "";
        this.$emit("activeSid", user.sid);
      }
    },
  },
};
</script>

<style lang="less" scoped>
.chatRoom {
  display: flex;
  .chatList {
    width: 185px;
    height: 550px;
    padding: 20px 0 0 20px;
    background-image: linear-gradient(
      to right top,
      #a98fb3,
      #a08fb9,
      #9490bd,
      #8691c1,
      #7593c4
    );
    .avatar {
      position: relative;
      span {
        position: absolute;
        left: 53px;
        top: 11px;
        font-size: 18px;
        color: yellow;
      }
      img {
        width: 45px;
        height: 45px;
        border-radius: 50%;
      }
    }
    .el-divider {
      margin: 10px 0;
    }
    .group {
      display: flex;
      align-items: center;
      margin-bottom: 10px;
      margin-right: 10px;
      cursor: pointer;
      box-sizing: border-box;
      img {
        width: 60px;
        height: 60px;
        margin-right: 20px;
      }
      span {
        font-size: 20px;
        color: #fff;
      }
    }
    .active-user {
      border: 2px solid #ccc;
      border-radius: 5px;
    }
    .listTop {
      span {
        color: #fff;
        display: block;
        margin-bottom: 10px;
        font-weight: bold;
      }
      padding-left: 5px;
    }
    .userChat {
      overflow: auto;
      height: 350px;
      padding-left: 5px;
      margin-right: 10px;
      box-sizing: border-box;
      .userBox {
        display: flex;
        align-items: center;
        height: 55px;
        cursor: pointer;
        img {
          width: 50px;
          height: 50px;
          margin-right: 20px;
        }
        span {
          font-size: 20px;
          color: #fff;
        }
      }
    }
    .userChat::-webkit-scrollbar {
      display: none;
    }
  }
}
.roomRight {
  flex: 1;
  background-color: #f6f6f6;
  display: flex;
  flex-direction: column;
  .name {
    display: flex;
    justify-content: center;
    line-height: 40px;
    margin-block-start: 0;
    margin-block-end: 0;
    font-size: 18px;
    border-bottom: 1px solid rgba(100, 100, 100, 0.3);
  }
  .chatContent {
    height: 340px;
    padding: 5px 0;
    .join {
      text-align: center;
      color: #ccc;
      overflow: auto;
      height: 100%;
      margin-bottom: 0;
      margin-top: 0;
      padding: 10px 30px 0;
      list-style: none;
      li {
        padding-bottom: 10px;
      }
    }
    .join::-webkit-scrollbar {
      display: none;
    }
    .my-message {
      display: flex;
      justify-content: flex-end;
      div {
        display: flex;
        position: relative;
        &::after {
          content: "";
          right: 45px;
          top: 50%;
          transform: translateY(-50%);
          position: absolute;
          border-left: 6px solid #9eea6a;
          border-top: 6px solid transparent;
          border-bottom: 6px solid transparent;
          border-right: 6px solid transparent;
        }
        .file {
          max-width: 330px;
          max-height: 170px;
          margin-right: 12px;
          cursor: pointer;
        }
        .avatar {
          width: 45px;
          height: 45px;
        }
        span {
          overflow: auto;
          box-sizing: border-box;
          display: inline-block;
          border-radius: 5px;
          line-height: 30px;
          background-color: #9eea6a;
          color: #000;
          padding: 5px;
          margin-right: 12px;
          min-width: 45px;
          max-width: 500px;
        }
      }
    }
    .other-message {
      position: relative;
      display: flex;
      justify-content: flex-start;
      div {
        display: flex;
        position: relative;
        &::before {
          content: "";
          left: 45px;
          top: 45%;
          transform: translateY(-50%);
          position: absolute;
          border-left: 5px solid transparent;
          border-top: 5px solid transparent;
          border-bottom: 5px solid transparent;
          border-right: 5px solid #ccc;
        }
        .file {
          max-width: 330px;
          max-height: 170px;
          margin-top: 15px;
          margin-left: 11px;
          cursor: pointer;
        }
        .avatar {
          width: 45px;
          height: 45px;
        }
        .username {
          position: absolute;
          left: 55px;
          top: -20px;
          font-size: 14px;
          color: #888;
        }
        .content {
          overflow: auto;
          margin-top: 15px;
          box-sizing: border-box;
          display: inline-block;
          border-radius: 5px;
          line-height: 30px;
          background-color: #fff;
          color: #000;
          padding: 5px;
          margin-left: 11px;
          border: 1px solid #ccc;
          min-width: 45px;
          max-width: 500px;
        }
      }
    }
  }
  .sendMessage {
    position: relative;
    flex: 1;
    background-color: #fff;
    padding-left: 15px;
    .icon {
      height: 25px;
      padding-top: 6px;
      display: flex;
      .icon-smile,
      .icon-Path,
      .icon-jietu {
        font-size: 20px;
        padding: 0 6px;
        cursor: pointer;
      }
      .icon-jietu {
        font-size: 23px !important;
      }
      .emoji {
        position: absolute;
        display: flex;
        flex-wrap: wrap;
        width: 276px;
        height: 218px;
        overflow: auto;
        bottom: 190px;
        background-color: #fff;
        border: 1px solid #cccccc;
        outline: none;
        span {
          padding: 7px;
          cursor: pointer;
        }
      }
    }
    textarea {
      border: none;
      resize: none;
      outline: none;
      font-size: 15px;
      padding-left: 10px;
    }
    textarea::-webkit-scrollbar {
      display: none;
    }
    .sendMessage {
      position: absolute;
      bottom: 35px;
      right: 20px;
      font-size: 16px;
      border-radius: 5px;
      padding: 4px 10px;
      background-color: #f5f5f5;
      border: 1px solid #ccc;
    }
  }
}
</style>