<template>
  <div class="photoBox">
    <div class="masonry">
      <div
        class="item"
        :class="[xxxvar ? 'items' : '']"
        v-for="(item, i) in imgList"
        :key="i"
      >
        <el-image
          :src="item"
          :preview-src-list="imgList"
          lazy
          @load="loadImageOne"
        ></el-image>
      </div>
    </div>
  </div>
</template>

<script>
import { imgMixin } from "../../utils/mixins/imgList";
export default {
  mixins: [imgMixin],
  data() {
    return {
      xxxvar: false,
    };
  },
  created() {
    this.getImgList(3);
  },
  methods: {
    loadImageOne() {
      this.xxxvar = true;
    },
  },
};
</script>

<style lang='less' scoped>
@import "./imgStyle.less";
.masonry {
  height: 3260px;
}
</style>