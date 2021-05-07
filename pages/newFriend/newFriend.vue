<template>
	<view>
		<navbar :type="2" title="好友请求"></navbar>
		<view class="friend-content">
			<view class="friend-content-top">请求列表</view>
			<view class="friend-item" v-for="(item, index) in friendList" :key="index">
				<view class="friend-item-left"><image :src="item.avatar" class="friend-item-img"></image></view>
				<view class="friend-item-main">
					<view class="friend-item-name">{{ item.username }}</view>
					<view class="friend-item-message">{{ item.message }}</view>
				</view>
				<view class="friend-item-text" v-if="item.isadd === 1">已同意</view>
				<view class="friend-item-button" v-else><button type="default" @click="addFriend(item.id)" class="button">添加</button></view>
			</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			friendList: [],
			uid: null
		};
	},
		onLoad() {
			const tokenStr = uni.getStorageSync('token');
			if (tokenStr) {
				let userInfo = uni.getStorageSync("userInfo");
				this.uid = userInfo.id;
				this.getApplyList();
			}
		},
	methods: {
		// 获取好友列表
		async getApplyList(id) {
			const res = await this.$http({
				url: '/friend/apply/list',
				method: 'POST',
				data: {
					uid: this.uid
				}
			});
			if (res.code === 200) {
				res.data.sort((a,b)=>{
					return Date.parse(b.add_time) - Date.parse(a.add_time)
				})
				this.friendList = res.data;
			}
		},
		// 同意添加好友
		async addFriend(id){
			const time = await new Date();
			await time.setHours(time.getHours() + 8);
			const res = await this.$http({
				url: '/friend/agree/apply',
				method: 'POST',
				data: {
					uid: this.uid,
					id,
					time
				}
			});
			if(res.code!==200){
				return this.$chat.alert(res.msg,'none')
			}
			this.$chat.alert(res.msg);
			this.getApplyList();
		}
	}
};
</script>

<style lang="scss" scoped>
.friend-content-top {
	padding: 14rpx 30rpx;
	font-size: 12px;
	background-color: #eee;
}
.friend-item {
	width: 100%;
	height: 140rpx;
	padding: 0 30rpx;
	box-sizing: border-box;
	display: flex;
	align-items: center;
	justify-content: space-between;
	border-bottom: 1px solid #eee;
	.friend-item-left {
		.friend-item-img {
			width: 90rpx;
			height: 90rpx;
			border-radius: 6px;
		}
	}
	.friend-item-main {
		width: 400rpx;
		height: 90rpx;
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		white-space: nowrap;
		overflow: hidden;
		.friend-item-name {
			font-weight: bold;
		}
		.friend-item-message {
			font-size: 12px;
		}
	}
	.friend-item-text {
		width: 120rpx;
		text-align: center;
		font-size: 14px;
		color: #888;
	}
	.friend-item-button {
		width: 120rpx;
		.button {
			width: 100%;
			height: 60rpx;
			line-height: 60rpx;
			font-size: 14px;
			background-color: $theme-color;
			color: #fff;
			border-radius: 6px;
			&::after {
				border: none;
			}
		}
	}
}
</style>
