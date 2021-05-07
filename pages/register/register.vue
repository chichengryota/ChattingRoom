<template>
	<view>
		<view class="top">
			<image src="../../static/image/back.png" mode="widthFix" class="back-img" @click="goback"></image>
			<image src="../../static/image/close.png" mode="widthFix" class="close-img" @click="closeRegister"></image>
		</view>
		<image src="../../static/image/logo.png" mode="widthFix" class="logo-img"></image>
		<view class="title">注册</view>

		<u-form :model="regForm" ref="regFormRef">
			<u-form-item prop="username" left-icon="account">
				<u-input v-model="regForm.username" placeholder="请取个名字" />
			</u-form-item>
			<u-form-item prop="email" left-icon="email">
				<u-input v-model="regForm.email" placeholder="请输入邮箱" @blur="checkEmail" />
			</u-form-item>
			<u-form-item prop="password" left-icon="lock">
				<u-input v-model="regForm.password" placeholder="请输入密码" type="password" :clearable="false" />
			</u-form-item>
			<u-form-item prop="confirmPassword" left-icon="lock-fill">
				<u-input v-model="regForm.confirmPassword" placeholder="请确认密码" type="password" :clearable="false" />
			</u-form-item>
		</u-form>
		<button type="default" @click="register" class="register-button">注册</button>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				regForm: {
					username: '',
					email: '',
					password: '',
					confirmPassword: ""
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
					confirmPassword: [{
						required: true,
						message: "请确认用户密码",
						trigger: "blur"
					}, ],
					email: [{
						required: true,
						message: "请输入电子邮箱",
						trigger: "blur"
					}]
				}
			};
		},
		// 必须要在onReady生命周期，因为onLoad生命周期组件可能尚未创建完毕
		onReady() {
			this.$refs.regFormRef.setRules(this.rules);
		},
		methods: {
			checkEmail: function() {
				var regEmail = /^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
				if (
					this.regForm.email != "" &&
					!regEmail.test(this.regForm.email)
				) {
					this.$chat.alert("邮箱格式不正确", 'none');
					this.regForm.email = "";
				}
			},
			register() {
				if (this.regForm.password !== this.regForm.confirmPassword) {
					return this.$chat.alert("密码输入不一致!", 'none');
				} else {
					this.$refs.regFormRef.validate(async valid => {
						if (!valid) return;
						const res = await this.$http({
							url: "/register",
							method: 'POST',
							data: {
								params: this.regForm
							}
						});
						if (res.code !== 200) {
							return this.$chat.alert(res.msg, 'none');
						}
						this.$chat.alert(res.msg);
						setTimeout(()=>{
							uni.navigateTo({
								url: '../login/login'
							})
						},1200)
					});
				}
			},
			goback() {
				uni.navigateBack();
			},
			closeRegister() {
				let routes = getCurrentPages();
				if (routes.length <= 2) {
					uni.reLaunch({
						url: '../index/index'
					})
				} else {
					uni.navigateBack({
						delta: 2
					});
				}
			}
		}
	};
</script>

<style lang="scss" scoped>
	.top {
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 50rpx;

		.back-img {
			width: 38rpx;
		}

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
		margin-bottom: 30rpx;
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

	.register-button {
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
