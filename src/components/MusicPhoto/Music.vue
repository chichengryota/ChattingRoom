<template>
  <div>
    <div class="musicBox">
      <aplayer :music="videoUpload.music" :list="musicList"></aplayer>
    </div>
  </div>
</template>

<script>
import aplayer from "vue-aplayer";

export default {
  data() {
    return {
      videoUpload: {
        //progress: false,
        // progressPercent: 0,
        // successPercent: 0,
        theme: "#70a1ff",
        autoplay: true,
        repeat: "repeat-one", // 轮播模式。值可以是 'repeat-one'（单曲循环）'repeat-all'（列表循环）或者 'no-repeat'（不循环）。为了好记，还可以使用对应的 'music' 'list' 'none'
        mini: false, // 迷你模式
        float: true, // 浮动模式。你可以在页面上随意拖放你的播放器
        music: {
          // 当前播放的音乐
          title: "晴天",
          artist: "周杰伦",
          src: require("../../assets/music/周杰伦 - 晴天.mp3"),
          pic: require("../../assets/img/cover/1.jpg"), // 封面图片
        },
      },
      musicList: [
        {
          // 当前播放的音乐
          title: "晴天",
          artist: "周杰伦",
          src: require("../../assets/music/周杰伦 - 晴天.mp3"),
          pic: require("../../assets/img/cover/1.jpg"), // 封面图片
        },
        {
          // 当前播放的音乐
          title: "七里香",
          artist: "周杰伦",
          src: require("../../assets/music/周杰伦 - 七里香.mp3"),
          pic: require("../../assets/img/cover/2.jpg"), // 封面图片
        },
        {
          // 当前播放的音乐
          title: "奇遇的起点",
          artist: "王力宏",
          src: require("../../assets/music/王力宏 - 奇遇的起点.mp3"),
          pic: require("../../assets/img/cover/3.jpg"), // 封面图片
        },
        {
          // 当前播放的音乐
          title: "好想爱这个世界啊",
          artist: "华晨宇",
          src: require("../../assets/music/华晨宇 - 好想爱这个世界啊.mp3"),
          pic: require("../../assets/img/cover/4.jpg"), // 封面图片
        },
        {
          // 当前播放的音乐
          title: "花 (抒情版)",
          artist: "片寄凉太数原龍友",
          src: require("../../assets/music/片寄凉太数原龍友 - 花 (抒情版).mp3"),
          pic: require("../../assets/img/cover/5.jpg"), // 封面图片
        },
        {
          // 当前播放的音乐
          title: "BLUE",
          artist: "Bigbang",
          src: require("../../assets/music/Bigbang - BLUE.mp3"),
          pic: require("../../assets/img/cover/6.jpg"), // 封面图片
        },
        {
          // 当前播放的音乐
          title: "LOSER",
          artist: "Bigbang",
          src: require("../../assets/music/Bigbang - LOSER.mp3"),
          pic: require("../../assets/img/cover/7.jpg"), // 封面图片
        },
        {
          // 当前播放的音乐
          title: "LAST DANCE",
          artist: "Bigbang",
          src: require("../../assets/music/Bigbang - LAST DANCE.mp3"),
          pic: require("../../assets/img/cover/8.jpg"), // 封面图片
        },
        {
          // 当前播放的音乐
          title: "Untitled, 2014 (无题)",
          artist: "G-DRAGON (权志龙)",
          src: require("../../assets/music/G-DRAGON (权志龙) - Untitled, 2014 (无题).mp3"),
          pic: require("../../assets/img/cover/9.jpg"), // 封面图片
        },
        {
          // 当前播放的音乐
          title: "眼鼻嘴",
          artist: "太阳",
          src: require("../../assets/music/太阳 - 眼鼻嘴.mp3"),
          pic: require("../../assets/img/cover/10.jpg"), // 封面图片
        },
      ],
    };
  },
  components: {
    aplayer,
  },
};
</script>

<style lang="less" scoped>
.musicBox {
  width: 700px;
  margin: 100px auto;
}
</style>