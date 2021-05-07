<template>
	<view class="account">
		<navbar :type="2" title="账号安全"></navbar>
		<view class="main">
			<view class="main-title">绑定邮箱</view>
			<input class="main-input" type="text" v-model="email" disabled @click="showEmail"/>
		</view>
		<view class="main">
			<view class="main-title">修改密码</view>
			<input class="main-input" type="password" v-model="password" disabled  @click="showPwd"/>
		</view>
		<u-popup v-model="showPop" mode="center" border-radius="14">
			<view class="set-account" v-if="type==1">
				<text class="set-account-title">修改绑定邮箱</text>
				<input class="set-account-input" v-model="newEmail" placeholder="请输入您要绑定的邮箱" />
				<button type="default" class="set-account-button" @click="updateEmail">确认</button>
			</view>
			<view class="set-account set-pwd" v-if="type==2">
				<text class="set-account-title">修改密码</text>
				<input class="set-account-input" v-model="pwd" type="password" placeholder="请输入您当前密码" />
				<input class="set-account-input" v-model="newPwd" type="password" placeholder="请输入您要修改的密码" />
				<input class="set-account-input" v-model="checkPwd" type="password" placeholder="请确认您要修改的密码" />
				<button type="default" class="set-account-button" @click="updatePwd">确认</button>
			</view>
		</u-popup>
		<button type="default" class="button" @click="showAction = true">注销登录</button>
		<u-action-sheet :list="list" v-model="showAction" @click="clickAction"></u-action-sheet>
		<u-modal v-model="deleteTip" @confirm="confirmDel" show-cancel-button content="注销账户后不可找回，确定注销吗"></u-modal>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				email: '',
				password: 'abc123456',
				list: [{
					text: '退出登录',
					color: 'rgb(133, 203, 248)'
				}, {
					text: '注销账户',
					color: '#dd524d',
					subText: '注销账户后不可找回，确定注销吗'
				}],
				showAction: false,
				showPop: false,
				deleteTip: false,
				type: null,
				newEmail:'',
				pwd:'',
				newPwd:'',
				checkPwd: '',
				uid: null
			}
		},
		onLoad() {
			const tokenStr = uni.getStorageSync('token');
			if (tokenStr) {
				let userInfo = uni.getStorageSync("userInfo");
				this.uid = userInfo.id;
				this.email = userInfo.email;
			}
		},
		methods: {
			showEmail(){
				this.type = 1;
				this.showPop = true;
			},
			showPwd(){
				this.type = 2;
				this.showPop = true;
			},
			async updateEmail(){
				let regEmail = /^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
				if(!this.newEmail){
					this.showPop = false;
					return this.$chat.alert('请先输入邮箱号','none')
				}else if(!regEmail.test(this.newEmail)){
					this.showPop = false;
					return this.$chat.alert('邮箱格式不正确','none')
				}else{
					const res = await this.$http({
						url: '/user/update/email',
						method: 'POST',
						data: {
							id: this.uid,
							email: this.newEmail
						}
					});
					this.showPop = false;
					if (res.code !== 200) {
					  return this.$chat.alert(res.msg,'none');
					}
					this.$chat.alert(res.msg);
					this.email = this.newEmail;
					this.newEmail = '';
					let userInfo = uni.getStorageSync("userInfo");
					userInfo.email = this.email;
					uni.setStorageSync('userInfo',userInfo);
				}
			},
			async updatePwd(){
				if(!this.pwd || !this.newPwd || !this.checkPwd){
					this.showPop = false;
					return this.$chat.alert('请先输入密码','none')
				}else if(this.newPwd!==this.checkPwd){
					this.showPop = false;
					return this.$chat.alert('两次密码输入不一致','none')
				}else if(this.newPwd.length<6||this.newPwd.length>15){
					this.showPop = false;
					return this.$chat.alert('密码长度在6到15个字符之间','none')
				}else{
					const res = await this.$http({
						url: '/user/update/pwd',
						method: 'POST',
						data: {
							id: this.uid,
							password: this.pwd,
							newPassWord: this.newPwd
						}
					});
					this.showPop = false;
					if (res.code !== 200) {
					  return this.$chat.alert(res.msg,'none');
					}
					this.$chat.alert(res.msg);
					this.password = this.newPwd;
					this.pwd = '';
					this.newPwd = '';
					this.checkPwd = '';
					
				}
			},
			clickAction(index){
				if(index===0){
					uni.clearStorageSync();
					uni.navigateTo({
						url:'../login/login'
					})
				}else{
					this.deleteTip = true;
				}
			},
			// 注销账号
			async confirmDel(){
				const res = await this.$http({
					url: '/user/delete/user',
					method: 'POST',
					data: {
						id: this.uid
					}
				});
				this.deleteTip = false;
				if (res.code !== 200) {
				  return this.$chat.alert(res.msg,'none');
				}
				this.$chat.alert(res.msg);
				uni.clearStorageSync();
				uni.navigateTo({
					url:'../login/login'
				})
			}
		}
	}
</script>

<style lang="scss" scoped>
.main{
	padding: 0 30rpx;
	margin: 50rpx 0;
	.main-title{
		font-size: 18px;
		font-weight: bold;
		color: $theme-color;
	}
	.main-input{
		width: 100%;
		height: 80rpx;
		line-height: 80rpx;
		padding: 0 20rpx;
		box-sizing: border-box;
		border: 1px solid #ccc;
		border-radius: 5px;
		margin-top: 20rpx;
	}
}
.set-account{
	width: 600rpx;
	height: 350rpx;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: space-evenly;
	.set-account-title{
		color: $theme-color;
		font-size: 16px;
		font-weight: bold;
	}
	.set-account-input{
		width: 450rpx;
		padding: 0 20rpx;
		border-radius: 6px;
		height: 80rpx;
		border: 1px solid #ccc;
		font-size: 14px;
	}
	.set-account-button{
		width: 150rpx;
		height: 70rpx;
		line-height: 70rpx;
		background-color: $theme-color;
		color: #fff;
		font-size: 16px;
		&:after{
			border: none;
		}
	}
}
.set-pwd{
	height: 550rpx;
}
.button{
	width: 500rpx;
	margin: 80rpx auto;
	height: 90rpx;
	line-height: 90rpx;
	background-color: $uni-color-error;
	color: #fff;
	font-weight: bold;
	&:after{
		border: none;
	}
}
</style>
