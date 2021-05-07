let fs = require('fs');
let path = require('path'); //解析需要遍历的文件夹

// 图片集
getImageList = (req, res) => {
  let type = JSON.parse(req.query.type)
  let filePath = ''
  let imgType = ''
  switch (type) {
    case 1:
      imgType = 'scenery'
      break
    case 2:
      imgType = 'pets'
      break
    case 3:
      imgType = 'cartoon'
      break
    case 4:
      imgType = 'beauty'
      break
  }
  filePath = path.join(__dirname, '../public/images/img/', imgType)
  readSizeRecursive(filePath, '/public/images/img/' + imgType, files => {
    res.send({
      code: 200,
      data: files
    })
  })
}

// 获取目录中文件的总数,再拼接域名
function readSizeRecursive(path, imgPath, cb) {
  fs.readdir(path, function (err, files) {
    for (var i = 0; i < files.length; i++) {
      files[i] = global.BASE_URL + imgPath + '/' + files[i]
    }
    cb(files)
  });
}

module.exports = getImageList