//给Date类添加了一个新的实例方法format
Date.prototype.format = function(fmt) {
	//debugger;
	let o = {
		"M+": this.getMonth() + 1, //月份
		"d+": this.getDate(), //日
		"h+": this.getHours(), //小时
		"m+": this.getMinutes(), //分
		"s+": this.getSeconds(), //秒
		"q+": Math.floor((this.getMonth() + 3) / 3), //季度
		"S": this.getMilliseconds() //毫秒
	};
	if (/(y+)/.test(fmt))
		fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	for (let k in o)
		if (new RegExp("(" + k + ")").test(fmt))
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
};

export function fmtDate(date, pattern) {
	let ts = date.getTime();
	let d = new Date(ts).format("yyyy-MM-dd hh:mm:ss");
	if (pattern) {
		d = new Date(ts).format(pattern);
	}
	return d.toLocaleString();
}

export function formatDate(date, type) {
	let yy = date.getFullYear(),
		MM = date.getMonth() + 1, //月份
		dd = date.getDate(), //日
		hh = date.getHours(), //小时
		mm = date.getMinutes(), //分
		ss = date.getSeconds(), //秒
		t = new Date(),
		tmonth = t.getMonth() + 1,
		today = t.getDate(),
		differd = today - dd,
		differm = tmonth - MM;
	// 格式化日期为两位
	dd = doHandleMonth(dd)
	hh = doHandleMonth(hh)
	mm = doHandleMonth(mm)
	if (type == 1) {
		if (tmonth == MM && differd == 0) {
			if (hh > 12) {
				return `下午${hh}:${mm}`
			} else {
				return `上午${hh}:${mm}`
			}
		} else if (differd == 1 || (differm == 1 && today == 1)) {
			return '昨天'
		} else {
			return `${MM}月${dd}日`
		}
	} else {
		if (tmonth == MM && differd == 0) {
			return `${hh}:${mm}`
		} else if (differd == 1 || (differm == 1 && today == 1)) {
			return `昨天 ${hh}:${mm}`
		} else {
			return `${MM}月${dd}日 ${hh}:${mm}`
		}
	}
}

// 格式化日期为两位
function doHandleMonth(date) {
	let m = date;
	if (date.toString().length == 1) {
		m = '0' + date;
	}
	return m;
}
