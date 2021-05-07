// 接口基础地址
const BASE_URL = 'http://127.0.0.1:8088/';

export const http = (options) => {
	return new Promise((resolve,reject) => {
		uni.request({
			url: BASE_URL + options.url,
			method: options.method || 'GET',
			data: options.data || {},
			header: {Authorization:uni.getStorageSync('token')},
			success: (res) => {
					if (res == '') {
					return uni.showToast({
						icon: 'loading',
						title:'获取数据失败'
					})
				}
				resolve(res)
			},
			fail: (err) => {
				return uni.showToast({
					icon: 'loading',
					title:'请求失败'
				})
				reject(err)
			}
		})
	})
}