export default {
	// 节流
	throttle(fn, delay) {
		let lastTime;
		let timer;
		let mdelay = delay || 200;
		return function(event) {
			let args = arguments;
			// 记录当前函数触发的时间
			let nowTime = Date.now();
			if (lastTime && nowTime - lastTime < mdelay) {
				clearTimeout(timer);
				timer = setTimeout(function() {
					// 记录上一次函数触发的时间
					lastTime = nowTime;
					// 修正this指向问题
					fn.apply(this, args, event);
				}, mdelay);
			} else {
				lastTime = nowTime;
				fn.apply(this, args, event);
			}
		}
	},
	// 防抖
	fnDebounce(fn, delay) {
		let timer = null;
		var delay = delay || 200;
		return function() {
			// 清除上一次延时器
			if(timer) clearTimeout(timer);
			timer = setTimeout(()=> {
				fn.apply(this, arguments)
			}, delay);
		}
	},
	// 更新组件内数据
	updateComponentData(that, name, val) {
		that[name] = val;
	},
	// 页面跳转
	naviTo(url) {
		uni.navigateTo({
			url,
			animationType: 'none'
		})
	},
	// 页面内跳转
	inpageNaviTo(url) {
		uni.navigateTo({
			url,
			animationType: 'slide-in-bottom',
			animationDuration: 250
		})
	},
	// 动态添加变量
	addVariable(that, name, val) {
		that.$set(that.$data, name, val)
	},
	// 精确乘法
	accMul(num1, num2) {
		var baseNum = 0;
		try {
			baseNum += String(num1).split(".")[1].length;
		} catch (e) {}
		try {
			baseNum += String(num2).split(".")[1].length;
		} catch (e) {}
		return Number(String(num1).replace(".", "")) * Number(String(num2).replace(".", "")) / Math.pow(10, baseNum);
	},
	// 精确加法
	accPlus(num1, num2) {
		var baseNum, baseNum1, baseNum2;
		try {
			baseNum1 = String(num1).split(".")[1].length;
		} catch (e) {
			baseNum1 = 0;
		}
		try {
			baseNum2 = String(num2).split(".")[1].length;
		} catch (e) {
			baseNum2 = 0;
		}
		baseNum = Math.pow(10, Math.max(baseNum1, baseNum2));
		return (num1 * baseNum + num2 * baseNum) / baseNum;
	},
	// 报错处理
	checkDataStatus(that, val, params, name, handle) {
		if (val && !('err' in val)) {
			that.inputDataStatus[params] = true;
			console.log(name + '-已获得数据')
			// console.log(val)
			handle.call(that, true)
		} else {
			console.log(name + '-发生错误')
			console.log('错误信息:')
			console.log(val)
			handle.call(that, false)
		}
	},
	// 发出通知
	alert(str,type) {
		//#ifdef APP-PLUS
		plus.nativeUI.toast(str);
		//#endif

		//#ifndef APP-PLUS
		uni.showToast({
			title: str,
			duration: 2000,
			icon: type
		});
		//#endif
	},
	// 上传图片(单图)
	fetchImage(filePath, name, url, formData) {
		return new Promise((resolve, reject) => {
			let uploadTask = uni.uploadFile({
				url,
				filePath,
				name,
				formData,
				success: (data) => {
					if (data.statusCode == 200) {
						let sth = JSON.parse(data.data)
						resolve({
							code: data.statusCode,
							data: sth.data
						})
					} else {
						resolve({
							data: []
						})
					}
				},
				fail: (err) => {
					reject(err)
				}
			});


		}).catch((err) => {
			return {
				err
			};
		})
	},
	// 上传图片(多图)
	fetchImages(files, name, url, header, formData, func) {
		return new Promise((resolve, reject) => {
			let uploadTask = uni.uploadFile({
				url,
				files,
				name,
				header,
				formData,
				success: (data) => {
					if (data.statusCode == 200) {
						let sth = JSON.parse(data.data)
						resolve({
							data: sth.data
						})
					} else {
						resolve({
							data: []
						})
					}
				},
				fail: (err) => {
					reject(err)
				}
			});

			// uploadTask.onProgressUpdate((res) => {
			// 	func(res)
			// })

		}).catch((err) => {
			return {
				err
			};
		})
	},
	// 时间戳转时间
	createTime(last) {
		let now = Date.now();
		let date = new Date();
		let y = date.getFullYear();
		let m = date.getMonth() + 1;
		let d = date.getDate();
		let h = date.getHours();
		let mm = date.getMinutes();
		let s = date.getSeconds();
		h < 10 ? h = '0' + h : h;
		mm < 10 ? mm = '0' + mm : mm;
		s < 10 ? s = '0' + s : s;
		if (last) {
			if (now - last > 86400000) {
				return `${y}年${m}月${d}日  ${h}:${mm}`
			} else if (now - last > 300000) {
				return `${h}:${mm}`
			} else {
				return ''
			}
		} else {
			return `${y}.${m}.${d} ${h}:${mm}:${s}`
		}

	},
	// 获取当前位置
	getCurrentLocation() {
		return new Promise((resolve, reject) => {
			uni.getLocation({
				type: 'wgs84',
				geocode: true,
				success: function(res) {
					resolve(res)
				},
				fail: function(err) {
					resolve(err)
				}
			});
		})
	},
	// 精确除法
	accDiv(arg1, arg2) {
		var t1 = this.deal(arg1);
		var t2 = this.deal(arg2);
		var r1 = Number(arg1.toString().replace(".", ""))
		var r2 = Number(arg2.toString().replace(".", ""))
		return (r1 / r2) * Math.pow(10, t2 - t1);
	},
	// 处理小数
	deal(arg) {
		var t = 0;
		try {
			t = arg.toString().split(".")[1].length
		} catch (e) {}
		return t;
	},
	checkAgreement(url) {
		//#ifdef APP-PLUS
		plus.runtime.openURL(url);
		//#endif

		//#ifndef APP-PLUS
		window.location.href = url;
		//#endif
	}
}
