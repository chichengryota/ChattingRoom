<template>
	<view class="addFriend">
		<navbar :type="2"></navbar>
		<view class="top-content"></view>
		<view class="addFriend-content">
			<u-avatar :src="userInfo.avatar" show-sex :sex-icon="userInfo.sex===1?'man':'woman'" size="280" @click="previewImage"></u-avatar>
			<view class="addFriend-content-name">{{ userInfo.username }}</view>
			<view class="addFriend-content-remark">{{ userInfo.signature }}</view>
			<textarea v-model="checkMessage" placeholder="请输入验证消息" class="addFriend-content-input"/>
			<view class="addFriend-content-button">
				<button type="default" class="cancel-send" @click="cancelApply">取消</button>
				<button type="default" class="send" @click="submitApply">发送</button>
			</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			userInfo:{},
			checkMessage: '',
			uid: null,
			id: null
		};
	},
	onLoad(option) {
		this.id = option.id;
		this.getUserInfo();
		const tokenStr = uni.getStorageSync('token');
		if (tokenStr) {
			let userInfo = uni.getStorageSync("userInfo");
			this.checkMessage = "我是"+userInfo.username;
			this.uid = userInfo.id;
		}
	},
	methods: {
		// 获取用户信息
		async getUserInfo(id){
			const res = await this.$http({
				url: '/user/show/userinfo',
				method: 'POST',
				data: {
					uid: this.id
				}
			});
			console.log(res.data);
			if (res.code !== 200) return;
			this.userInfo = res.data;
		},
		// 图片预览
		previewImage(){
			uni.previewImage({urls: [this.avatar]})
		},
		cancelApply(){
			uni.navigateBack()
		},
		// 发起添加好友请求
		async submitApply(){
			if(!this.checkMessage){
				return this.$chat.alert('请先输入验证消息','none')
			}
			const time = await new Date();
			await time.setHours(time.getHours() + 8);
			const res = await this.$http({
				url: '/apply/adduser',
				method: 'POST',
				data: {
					uid: this.uid,
					id: this.id,
					message: this.checkMessage,
					time: time
				}
			});
			console.log(res);
			if (res.code !== 200){
				return this.$chat.alert(res.msg,'none')
			}
			this.$chat.alert(res.msg)
			uni.navigateBack()
		},
	}
};
</script>

<style lang="scss" scoped>
.addFriend {
	background-color: $theme-color;
	.top-content {
		width: 100%;
		height: 24vh;
	}
	.addFriend-content {
		width: 100%;
		min-height: 70vh;
		background-color: #fff;
		border-top-left-radius: 20px;
		border-top-right-radius: 20px;
		display: flex;
		flex-direction: column;
		align-items: center;
		/deep/ .u-avatar {
			margin-top: -140rpx;
		}
		.addFriend-content-name{
			font-size: 24px;
			font-weight: bold;
			margin: 20rpx 0;
		}
		.addFriend-content-remark{
			font-size: 14px;
			margin-bottom: 30rpx;
			padding: 0 70rpx;
			letter-spacing: 2px;
		}
		.addFriend-content-input{
			height: 400rpx;
			background-color: #eee;
			border-radius: 10px;
			padding: 30rpx;
		}
		.addFriend-content-button{
			display: flex;
			height: 80rpx;
			width: 700rpx;
			align-items: center;
			justify-content: space-between;
			margin: 50rpx 0;
			.cancel-send{
				width: 180rpx;
				height: 80rpx;
				line-height: 80rpx;
				&::after{
					border: none;
				}
				background-color: #eee;
				text-align: center;
				font-size: 16px;
			}
			.send{
				width: 480rpx;
				height: 80rpx;
				line-height: 80rpx;
				&::after{
					border: none;
				}
				background-color: $theme-color;
				font-size: 16px;
			}
		}
	}
}
</style>
