//非测试环境下、开发环境/生产环境
export const BASE_URL = process.env.NODE_ENV === 'development' ? 'http://127.0.0.1:4000' : 'http://8.129.128.30:4000';

export const http = (opt) => {
	opt = opt || {};
	opt.url = opt.url || '';
	opt.data = opt.data || null;
	opt.method = opt.method || 'GET';
	let token = uni.getStorageSync("token");
	opt.header = opt.header || {
		"Content-Type": "application/json",
		"Authorization": token ? token : ''
	};
	return new Promise((resolve, reject) => {
		if (opt.loadText) {
			uni.showLoading({
				title: opt.loadText,
				mask: true
			})
		}
		uni.request({
			url: BASE_URL + opt.url,
			data: opt.data,
			header: opt.header,
			timeout: 10000,
			method: opt.method,
			dataType: 'json',
			success: (res) => {
				if (res.statusCode == 200) {
					resolve(res.data);
				} else {
					reject("error");
				}
			},
			complete: () => {
				if (opt.loadText) {
					uni.hideLoading();
				}
			},
			fail: () => {
				reject('error');
			}
		})
	})
}
