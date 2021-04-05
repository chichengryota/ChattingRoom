<template>
  <div>
    <div class="boxContainer">
      <div class="container">
        <div class="musicContent">
          <p>音乐馆</p>
          <div class="musicBox" @click="goMusic">
            <div class="boxMask"></div>
            <span>轻 松 一 下</span>
          </div>
        </div>
        <div class="photoContent">
          <p>照片墙</p>
          <ul class="photoBox">
            <li class="photo scenery" @click="goScenery">
              <div class="boxMask"></div>
              <span>风景系列</span>
            </li>
            <li class="photo pets" @click="goPets">
              <div class="boxMask"></div>
              <span>可爱萌宠</span>
            </li>
            <li class="photo cartoon" @click="goCartoon">
              <div class="boxMask"></div>
              <span>卡通动漫</span>
            </li>
            <li class="photo beauty" @click="goBeauty">
              <div class="boxMask"></div>
              <span>明星人物</span>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {},
  methods: {
    goMusic() {
      this.$router.push("/music");
    },
    goScenery() {
      this.$router.push("/scenery");
    },
    goPets() {
      this.$router.push("/pets");
    },
    goCartoon() {
      this.$router.push("/cartoon");
    },
    goBeauty() {
      this.$router.push("/beauty");
    },
  },
};
</script>

<style lang="less" scoped>
.boxContainer {
  // background-color: rgb(249, 249, 249);
  position: relative;
}
.container {
  // background-color: #fff;
  max-width: 950px;
  min-height: 100vh;
  position: relative;
  margin: 0 auto;
  padding-bottom: 20px;
}
.musicContent {
  padding: 1px;
  p {
    text-shadow: 3px 1px 2px #888;
    font-size: 48px;
    font-family: monospace;
    font-weight: bolder;
    margin-top: 70px;
    text-align: center;
    color: #70a1ff;
  }
  .musicBox {
    position: relative;
    margin: 40px auto;
    width: 800px;
    height: 180px;
    background-image: url("../assets/img/music1.jpg");
    background-repeat: no-repeat;
    background-size: cover;
    background-position: left top;
    border-radius: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
    cursor: pointer;
    overflow: hidden;
    span {
      position: absolute;
      display: inline-block;
      line-height: 180px;
      left: 50%;
      transform: translateX(-50%);
      font-size: 48px;
      font-family: monospace;
      font-weight: bold;
      color: #70a1ff;
      opacity: 0;
    }
  }
}
.photoContent {
  p {
    text-shadow: 3px 1px 2px #888;
    font-size: 48px;
    font-family: monospace;
    font-weight: bolder;
    text-align: center;
    color: #5ce1e6;
  }
  .photoBox {
    position: relative;
    width: 860px;
    list-style: none;
    display: flex;
    flex-wrap: wrap;
    margin: 0 auto;
    .photo {
      position: relative;
      width: 300px;
      height: 100px;
      margin-right: 38px;
      margin-bottom: 50px;
      flex: 1 0 45%;
      background-repeat: no-repeat;
      background-size: cover;
      background-position: center;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
      cursor: pointer;
      overflow: hidden;
      span {
        position: absolute;
        display: inline-block;
        line-height: 100px;
        left: 50%;
        transform: translateX(-50%);
        font-size: 30px;
        font-family: monospace;
        font-weight: bold;
        color: #5ce1e6;
        opacity: 0;
      }
    }
    .scenery {
      background-image: url("../assets/img/scenery1.jpg");
    }
    .cartoon {
      background-image: url("../assets/img/cartoon.jpg");
    }
    .beauty {
      background-image: url("../assets/img/beauty11.jpg");
    }
    .pets {
      background-image: url("../assets/img/pets9.jpg");
    }
  }
}
.boxMask {
  position: absolute;
  width: 100%;
  height: 100%;
  background-color: #000;
  opacity: 0;
}
.musicBox:hover .boxMask {
  animation: img 0.3s linear forwards;
}
.musicBox:hover span {
  animation: text 0.5s linear forwards;
}
.photo:hover .boxMask {
  animation: img 0.3s linear forwards;
}
.photo:hover span {
  animation: text 0.5s linear forwards;
}
@keyframes img {
  0% {
    opacity: 0;
  }
  100% {
    opacity: 0.3;
  }
}
@keyframes text {
  0% {
    opacity: 0;
    top: -100%;
  }
  33% {
    top: 0;
  }
  66% {
    top: -12%;
  }
  100% {
    opacity: 1;
    top: 0;
  }
}
</style>