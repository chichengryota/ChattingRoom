<template>
	<view>
		<navbar :type="2" title="个人资料"></navbar>
		<view class="top">
			<image :src="avatar" mode="aspectFill" class="top-bg"></image>
			<image :src="avatar" mode="" class="top-avatar" @click="chooseAvatar"></image>
			<text class="top-name">{{nickname}}</text>
		</view>
		<view class="main">
			<!-- 昵称设置 -->
			<view class="main-item" @click="showNamePop">
				<u-icon name="account" size="44" class="main-icon"></u-icon>
				<text class="main-text">{{ nickname }}</text>
				<u-icon name="arrow-right" size="36" color="#888" class="arrow-right"></u-icon>
			</view>
			<!-- 昵称设置结束 -->
			<!-- 个性签名 -->
			<view class="main-item" @click="showRemarkPop">
				<u-icon name="edit-pen" size="44" class="main-icon"></u-icon>
				<text class="main-text">{{ remark }}</text>
				<u-icon name="arrow-right" size="36" color="#888" class="arrow-right"></u-icon>
			</view>
			<!-- 个性签名结束 -->
			<!-- 邮箱 -->
			<view class="main-item">
				<u-icon name="email" size="44" class="main-icon"></u-icon>
				<text class="main-text">{{ email }}</text>
			</view>
			<!-- 邮箱结束 -->
			<!-- 性别设置 -->
			<view class="main-item" @click="showSexSel">
				<u-icon name="man" size="50" class="main-icon"></u-icon>
				<text class="main-text">{{ sex===1?'男':'女' }}</text>
				<u-icon name="arrow-right" size="36" color="#888" class="arrow-right"></u-icon>
			</view>
			<u-select v-model="showSex" mode="single-column" :list="sexList" @confirm="updateSex"></u-select>
			<!-- 性别设置结束 -->
			<!-- 生日设置 -->
			<view class="main-item" @click="showCalendar">
				<u-icon name="calendar" size="50" class="main-icon"></u-icon>
				<text class="main-text">{{ birthday }}</text>
				<u-icon name="arrow-right" size="36" color="#888" class="arrow-right"></u-icon>
			</view>
			<u-calendar v-model="showCal" @change="chooseDate"></u-calendar>
			<!-- 生日设置结束 -->
			<u-popup v-model="showPop" mode="center" border-radius="14">
				<view class="set-name" v-if="type==1">
					<text class="set-name-title">修改昵称</text>
					<input class="set-name-input" v-model="newName" placeholder="请输入您要修改的昵称" />
					<button type="default" class="set-name-button" @click="updateName">确认</button>
				</view>
				<view class="set-name" v-if="type==2">
					<text class="set-name-title">修改个性签名</text>
					<input class="set-name-input" v-model="newRemark" placeholder="请输入您要修改的个性签名" />
					<button type="default" class="set-name-button" @click="updateRemark">确认</button>
				</view>
			</u-popup>
			<button type="default" class="save-button" @click="savePerson">保存</button>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				avatar: '',
				nickname: '',
				newName: '',
				remark: '',
				newRemark: '',
				email: '',
				sex: '',
				birthday: '',
				showPop: false,
				showSex: false,
				showCal: false,
				sexList: [{
					value: 1,
					label: '男'
				}, {
					value: 2,
					label: '女'
				}],
				type: null,
				tempUrl: '',
				uid: null
			};
		},
		onLoad() {
			let userInfo = uni.getStorageSync("userInfo");
			this.uid = userInfo.id;
			this.avatar = userInfo.avatar;
			this.nickname = userInfo.username;
			this.remark = userInfo.signature;
			this.email = userInfo.email;
			this.birthday = userInfo.birthday.split('T')[0];
			this.sex = userInfo.sex;
			// 监听从裁剪页发布的事件，获得裁剪结果
			uni.$on('uAvatarCropper', path => {
				// 可以在此上传到服务端
				uni.uploadFile({
					url: this.$apiServer + '/upload?type=1',
					filePath: path,
					name: 'file',
					complete: (res) => {
						if (res.statusCode === 200) {
							this.$http({
								url: '/user/update/avatar',
								data: {
									id: this.uid,
									imgUrl: res.data
								},
								method: 'POST'
							}).then(result => {
								if (result.code !== 200) {
									return this.$chat.alert(result.msg, 'none');
								}
								this.$chat.alert(result.msg);
								this.avatar = result.url;
								let userInfo = uni.getStorageSync("userInfo");
								userInfo.avatar = this.avatar;
								uni.setStorageSync('userInfo', userInfo);
							})
						} else {
							this.$chat.alert('上传图片失败，服务器错误', 'none');
						}
					}
				});
			})
		},
		methods: {
			// 头像裁切
			chooseAvatar() {
				// 此为uView的跳转方法，详见"文档-JS"部分，也可以用uni的uni.navigateTo
				this.$u.route({
					// 关于此路径，请见下方"注意事项"
					url: '/uview-ui/components/u-avatar-cropper/u-avatar-cropper',
					// 内部已设置以下默认参数值，可不传这些参数
					params: {
						// 输出图片宽度，高等于宽，单位px
						destWidth: 300,
						// 裁剪框宽度，高等于宽，单位px
						rectWidth: 200,
						// 输出的图片类型，如果'png'类型发现裁剪的图片太大，改成"jpg"即可
						fileType: 'png',
					}
				})
			},
			// 显示修改昵称框
			showNamePop() {
				this.type = 1;
				this.showPop = true;
			},
			showRemarkPop() {
				this.type = 2;
				this.showPop = true;
			},
			// 修改昵称
			updateName() {
				if (!this.newName) {
					this.showPop = false;
					return this.$chat.alert('请先输入昵称', 'none');
				}
				this.nickName = this.newName;
				this.showPop = false;
			},
			// 修改个性签名
			updateRemark() {
				if (!this.newRemark) {
					this.showPop = false;
					return this.$chat.alert('请先输入个性签名', 'none');
				}
				this.remark = this.newRemark;
				this.showPop = false;
			},
			// 显示日历选择器
			showCalendar() {
				this.showCal = true;
			},
			// 修改生日
			chooseDate(e) {
				this.birthday = e.result;
				this.showCal = false;
			},
			// 显示修改性别选择器
			showSexSel() {
				this.showSex = true;
			},
			// 修改性别
			updateSex(e) {
				this.sex = e[0].value;
			},
			// 保存修改信息
			async savePerson() {
				const res = await this.$http({
					url: '/user/update/userinfo',
					method: 'POST',
					data: {
						id: this.uid,
					    signature: this.remark,
					    sex: this.sex,
					    birthday: this.birthday
					}
				});
				if (res.code !== 200) {
					return this.$chat.alert(res.msg, 'none');
				}
				this.$chat.alert(res.msg);
				let userInfo = uni.getStorageSync("userInfo");
				userInfo.signature = this.remark;
				userInfo.sex = this.sex;
				userInfo.birthday = this.birthday;
				uni.setStorageSync('userInfo', userInfo);
				setTimeout(()=>{
					uni.switchTab({
						url: '../my/my'
					})
				},1000)
			}
		}
	};
</script>

<style lang="scss" scoped>
	.top {
		width: 100%;
		height: 400rpx;
		overflow: hidden;
		position: relative;

		.top-bg {
			width: 100%;
			height: 100%;
			z-index: -1;
			-webkit-filter: blur(3px);
			filter: blur(3px);
			transform: scale(1.4);
		}

		.top-avatar {
			width: 190rpx;
			height: 190rpx;
			border-radius: 50%;
			border: 2px solid #fff;
			position: absolute;
			left: 50%;
			transform: translateX(-50%);
			top: 70rpx;
		}

		.top-name {
			color: #fff;
			font-weight: bold;
			position: absolute;
			left: 50%;
			transform: translateX(-50%);
			bottom: 70rpx;
		}
	}

	.main {
		width: 100%;
		padding: 20rpx 0;

		.main-item {
			width: 100%;
			height: 120rpx;
			padding: 0 30rpx;
			display: flex;
			align-items: center;
			position: relative;
			box-sizing: border-box;
			border-bottom: 1px solid #eee;

			.main-icon {
				width: 70rpx;
				color: #555;
			}

			.main-text {
				color: #333;
			}

			.arrow-right {
				position: absolute;
				right: 30rpx;
			}
		}
	}

	.set-name {
		width: 500rpx;
		height: 330rpx;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: space-evenly;

		.set-name-title {
			color: $theme-color;
			font-size: 16px;
			font-weight: bold;
		}

		.set-name-input {
			width: 400rpx;
			padding: 0 20rpx;
			border-radius: 6px;
			height: 70rpx;
			border: 1px solid #ccc;
			font-size: 14px;
		}

		.set-name-button {
			width: 140rpx;
			height: 66rpx;
			line-height: 64rpx;
			background-color: $theme-color;
			color: #fff;
			font-size: 14px;

			&:after {
				border: none;
			}
		}
	}

	.save-button {
		width: 500rpx;
		margin: 80rpx auto;
		height: 90rpx;
		line-height: 90rpx;
		background-color: $theme-color;
		color: #fff;
		font-weight: bold;

		&:after {
			border: none;
		}
	}
</style>
