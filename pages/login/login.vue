<template>
	<view>
		<view class="top">
			<image src="../../static/image/close.png" mode="widthFix" class="close-img" @click="closeLogin"></image>
			<text @click="goRegister">注册</text>
		</view>
		<image src="../../static/image/logo.png" mode="widthFix" class="logo-img"></image>
		<view class="title">登录</view>
		<text class="subtitle">您好，欢迎来到天天聊天室！</text>
		<u-form :model="loginForm" ref="loginFormRef">
			<u-form-item prop="username" left-icon="account" v-if="isUser">
				<u-input class="user-input" v-model="loginForm.username" placeholder="请输入用户名" />
				<button type="default" class="check-button" @click="chooseUser">邮箱登录</button>
			</u-form-item>
			<u-form-item prop="email" left-icon="email" v-else>
				<u-input class="user-input" v-model="loginForm.email" @blur="checkEmail" placeholder="请输入邮箱" />
				<button type="default" class="check-button" @click="chooseUser">用户名登录</button></u-form-item>
			<u-form-item prop="password" left-icon="lock">
				<u-input v-model="loginForm.password" placeholder="请输入密码" type="password" :clearable="false" />
			</u-form-item>
		</u-form>
		<button type="default" @click="login" class="login-button">登录</button>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				isUser: true,
				loginForm: {
					username: 'admin',
					email: '',
					password: '123456'
				},
				rules: {
					username: [{
							required: true,
							message: "请输入用户名称",
							trigger: "blur"
						},
						{
							min: 3,
							max: 10,
							message: "长度在 3 到 10 个字符",
							trigger: "blur",
						},
					],
					password: [{
							required: true,
							message: "请输入用户密码",
							trigger: "blur"
						},
						{
							min: 6,
							max: 15,
							message: "长度在 6 到 15 个字符",
							trigger: "blur",
						},
					],
					email: [{
						required: true,
						message: '请输入邮箱',
						// 可以单个或者同时写两个触发验证方式
						trigger: 'blur'
					}]
				}
			};
		},
		onReady() {
			this.$refs.loginFormRef.setRules(this.rules);
		},
		methods: {
			checkEmail: function() {
				var regEmail = /^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
				if (this.loginForm.email != "" && !regEmail.test(this.loginForm.email)) {
					this.$chat.alert("邮箱格式不正确", 'none');
					this.loginForm.email = "";
				}
			},
			chooseUser() {
				this.isUser = !this.isUser
				this.loginForm = {
					username: "",
					password: "",
					email: "",
				};
			},
			login() {
				this.$refs.loginFormRef.validate(async valid => {
					if (!valid) return;
					const res = await this.$http({
						url: '/login',
						method: 'POST',
						data: {
							params: this.loginForm
						}
					});
					console.log(res);
					if (res.code !== 200) {
						return this.$chat.alert(res.msg, 'none');
					}
					this.$chat.alert(res.msg);
					uni.setStorageSync('token', res.token);
					uni.setStorageSync('userInfo', res.data);
					setTimeout(()=>{
						uni.switchTab({
							url: '../index/index'
						});
					},1200)
				});
			},
			closeLogin() {
				let routes = getCurrentPages();
				if (routes.length == 1) {
					uni.switchTab({
						url: '../index/index'
					})
				} else {
					uni.navigateBack()
				}
			},
			goRegister() {
				uni.navigateTo({
					url: '../register/register'
				})
			}
		},
	};
</script>

<style lang="scss" scoped>
	.top {
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 50rpx;

		.close-img {
			width: 34rpx;
		}
	}

	.logo-img {
		display: block;
		width: 170rpx;
		margin: 50rpx auto;
	}

	.title {
		font-size: 22px;
		font-weight: bold;
		margin-left: 50rpx;
	}

	.subtitle {
		font-size: 18px;
		color: #888;
		display: inline-block;
		margin: 30rpx 0;
		margin-left: 50rpx;
	}

	.check-button {
		position: absolute;
		right: 50rpx;
		width: 140rpx;
		height: 50rpx;
		line-height: 50rpx;
		font-size: 12px;
		padding: 0;
		color: #fff;
		background-color: $theme-color;

		&:after {
			border: none;
		}
	}

	/deep/ .user-input {
		position: relative;
	}

	/deep/ .u-form-item {
		margin: 0 50rpx;
		height: 120rpx;
	}

	/deep/ .u-form-item__message {
		padding-left: 0 !important;
	}

	/deep/ .u-input {
		border-bottom: 1px solid #ddd;
	}

	.login-button {
		width: 500rpx;
		height: 90rpx;
		line-height: 90rpx;
		border-radius: 50px;
		margin: 100rpx auto;
		background-color: rgb(133, 203, 248);
		color: #fff;
		font-weight: bold;

		&::after {
			border: none;
		}
	}
</style>
