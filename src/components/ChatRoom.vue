<template>
  <div class="chatRoom" ref="room">
    <div class="chatList">
      <div class="avatar">
        <img :src="user.avatar" alt="" />
        <span>{{ user.username }}</span>
      </div>
      <el-divider></el-divider>
      <div class="listTop">
        <span>当前用户列表</span>
      </div>
      <div class="userChat">
        <ul class="onlineList">
          <li class="userBox" v-for="item in userList" :key="item.username">
            <img :src="item.avatar" alt="" />
            <span>{{ item.username }}</span>
          </li>
        </ul>
      </div>
    </div>
    <div class="roomRight">
      <p class="name">聊天室({{ userListLength }})</p>
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
    message: Object,
  },
  data() {
    return {
      messageContent: [], //0不渲染，1表示自己发出的信息，2表示别人发出的信息
      emojiList: [],
      content: "",
      emojiShow: false,
      imgUrl: "",
      imgAllUrl: [],
    };
  },
  methods: {
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
        const imgUrl = canvas.toDataURL();
        this.$emit("handleFile", imgUrl);
      });
    },
    handleEmojiBlur() {
      this.emojiShow = false;
    },
    handleEmoji(emoji) {
      this.content = this.$refs.textarea.value;
      this.$refs.textarea.value += emoji.char;
    },
    loadOverImg() {
      this.$previewRefresh();
      this.handleScrollBottom();
    },
    handleImage(file) {
      this.handleMessageBox(file);
    },
    handleFile(e) {
      const file = e.target.files[0];
      const reader = new FileReader(); // 创建读取文件对象
      reader.readAsDataURL(file); // 发起异步请求，读取文件
      reader.onload = (e) => {
        // 文件读取完成后
        // 读取完成后，将结果赋值给img的src
        this.$emit("handleFile", e.target.result);
      };
    },
    haveOneJoinRoom() {
      const joinRoom = this.$store.state.joinRoom;
      this.messageContent.push({ ...joinRoom, type: 3 });
    },
    haveOneleaveRoom() {
      const leaveRoom = this.$store.state.leaveRoom;
      this.messageContent.push({ ...leaveRoom, type: 4 });
    },
    sendContentToServe() {
      // 获取到聊天的内容
      this.content = this.$refs.textarea.value;
      this.$refs.textarea.value = "";
      if (!this.content) {
        return alert("请输入内容");
      }
      //发送给服务器
      this.$emit("sendServer", this.content);
    },
    handleMessageBox(newValue) {
      if (newValue.username === this.user.username) {
        //是自己发的信息
        this.messageContent.push({ ...newValue, type: 1 });
      } else {
        //是别人发的信息
        this.messageContent.push({ ...newValue, type: 2 });
      }
    },
    handleScrollBottom() {
      const ul = this.$refs.joinUs;
      ul.scrollTop = ul.scrollHeight;
    },
  },
  computed: {
    userListLength() {
      return this.userList.length;
    },
  },
  mounted() {
    this.emojiList = emoji;
  },
  updated() {
    // 聊天定位到底部
    this.handleScrollBottom();
  },
  watch: {
    message(newValue) {
      this.handleMessageBox(newValue);
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
      height: 420px;
      .onlineList {
        list-style: none;
        padding-left: 10px;
        margin: 0;
        img {
          width: 50px;
          height: 50px;
          margin: 5px 10px 0 0;
        }
        .userBox {
          position: relative;
          height: 55px;
          cursor: pointer;
          span {
            position: absolute;
            top: 16px;
            font-size: 20px;
            color: #fff;
          }
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
    .join {
      text-align: center;
      color: #ccc;
      overflow: auto;
      height: 100%;
      margin-bottom: 0;
      margin-top: 0;
      padding: 5px 30px 0;
      list-style: none;
      li {
        padding-bottom: 12px;
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