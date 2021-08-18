//图片上传
let multer = require('multer')
//上传的文件保存在 upload
let storage = multer.diskStorage({
  //存储的位置
  destination(req, file, cb) {
    let type = JSON.parse(req.query.type)
    switch (type) {
      case 1:
        cb(null, 'public/images/avatar')
        break
      case 2:
        cb(null, 'public/images/dynamic')
        break
      case 3:
        cb(null, 'public/images/message')
        break
    }
  },
  //文件名字的确定 multer默认帮我们取一个没有扩展名的文件名，因此需要我们自己定义
  filename(req, file, cb) {
    cb(null, Date.now() + file.originalname)
  }
})
//传入storage 除了这个参数我们还可以传入dest等参数
let upload = multer({
  storage
})
let uploadparams = upload.single('file');

//处理图片上传请求
uploadImg = (req, res) => {
  let type = JSON.parse(req.query.type)
  let imgUrl = ''
  switch (type) {
    case 1:
      imgUrl = '/public/images/avatar/'
      break
    case 2:
      imgUrl = '/public/images/dynamic/'
      break
    case 3:
      imgUrl = '/public/images/message/'
      break
  }
  let image = imgUrl + req.file.filename
  res.send(image)
}

module.exports = {
  uploadparams,
  uploadImg
}