export const imgMixin = {
  data() {
    return {
      imgList: []
    }
  },
  methods: {
    async getImgList(type) {
      await this.$http.get(`img_list?type=${type}`).then(res => {
        this.imgList = res.data.data;
      }).catch(err => {
        this.$message.error('获取图片数据失败')
        throw err
      })
    }
  }
}