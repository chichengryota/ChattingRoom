<template>
	<view class="addFriend">
		<navbar :type="2"></navbar>
		<view class="top-content"></view>
		<view class="addFriend-content">
			<u-avatar :src="userInfo.avatar" show-sex :sex-icon="userInfo.sex" size="280" @click="previewImage"></u-avatar>
			<view class="addFriend-content-name">{{ userInfo.nickname }}</view>
			<view class="addFriend-content-info">邮箱：{{ userInfo.email }}</view>
			<view class="addFriend-content-info">签名：{{ userInfo.remark }}</view>
			<view class="addFriend-content-info">生日：{{ userInfo.birthday }}</view>
			<view class="addFriend-send addFriend-menu" @click="goChat">
				发消息
			</view>
			<view class="addFriend-delete addFriend-menu" @click="deleteFriend">
				删除好友
			</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			id: null,
			userInfo:{
				avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg',
				sex: 'man',
				nickname: '李元芳',
				remark: '啊哈哈或或或或或或哈或或或或或或或或阿虎',
				email: '2354652121@qq.com',
				birthday: '2001-2-12'
			}
		};
	},
	onLoad(option) {
		this.id = option.id
	},
	methods: {
		goChat(){
			uni.$u.route('/pages/chat/chat', { id: this.id });
		},
		deleteFriend(){
			
		},
		// 图片预览
		previewImage(){
			uni.previewImage({urls: [this.userInfo.avatar]})
		}
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
		.addFriend-content-info{
			align-self: flex-start;
			font-size: 14px;
			padding: 30rpx 70rpx;
			width: 600rpx;
			border-bottom: 1px solid #eee;
			letter-spacing: 2px;
			overflow: hidden;
			white-space: nowrap;
			text-overflow: ellipsis;
		}
		.addFriend-menu{
			width: 100%;
			height: 100rpx;
			line-height: 100rpx;
			text-align: center;
			font-size: 18px;
			font-weight: bold;
			border-top: 1px solid #ddd;
			border-bottom: 1px solid #ddd;
			&:last-child{
				border-top: none;
			}
		}
		.addFriend-send{
			margin-top: 200rpx;
			color: $theme-color;
		}
		.addFriend-delete{
			color: red;
		}
	}
}
</style>
