const mysql = require('mysql')
module.exports = {
  //数据库配置
  config: {
    host: 'localhost',
    port: '3306',
    user: 'root',
    password: 'root',
    database: 'user',
    dateStrings: true,
  },
  //连接数据库，使用mysql的连接池方式
  sqlConnect: function (sql, sqlArr, callback) {
    let pool = mysql.createPool(this.config)
    pool.getConnection((err, conn) => {
      if (err) {
        console.log('Mysql连接失败')
        return
      }
      //事件驱动回调
      conn.query(sql, sqlArr, callback)
      //释放连接
      conn.release()
    })
  }
}