<template>
	<view>
		<navbar :type="4" @change="inputChange"></navbar>
		<view class="user">
			<view class="user-top" v-if="userList.length!==0">
				用户
			</view>
			<view class="user-content">
				<view class="user-item" v-for="(item,index) in userList" :key="index">
					<image :src="item.avatar" mode="" class="user-avatar"></image>
					<text class="user-name">{{item.username}}</text>
					<text v-if="item.isFriend" class="user-button" @click="goChat(item.id)">发消息</text>
					<text v-if="!item.isFriend" class="user-button add-friend" @click="goAddFriend(item.id)">加好友</text>
				</view>
			</view>
		</view>
		<view class="user">
			<view class="user-top" v-if="groupList.length!==0">
				群组
			</view>
			<view class="user-content">
				<view class="user-item" v-for="(item1,index1) in groupList" :key="index1">
					<image :src="item1.avatar" mode="" class="user-avatar"></image>
					<text class="user-name">{{item1.group_name}}</text>
					<text class="user-button">发消息</text>
				</view>
			</view>
		</view>
		<view class="empty" v-if="userList.length===0&&groupList.length===0">
			搜索不到要查询的用户或群组
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				uid: null,
				userList: [],
				groupList: []
			}
		},
		onLoad() {
			const tokenStr = uni.getStorageSync('token');
			if (tokenStr) {
				let userInfo = uni.getStorageSync("userInfo");
				this.uid = userInfo.id;
			}
		},
		methods: {
			// 搜索用户
			async inputChange(val){
				if(!val) return;
				console.log(val);
				const res = await this.$http({
					url: '/search/user',
					method: 'POST',
					data: {
						id: this.uid,
						value: val
					}
				});
				if (res.code !== 200) return;
				this.userList = res.data;
			},
			goChat(id){
				uni.$u.route('/pages/chat/chat', { id: id });
			},
			goAddFriend(id){
				uni.$u.route('/pages/addFriend/addFriend', { id: id });
			}
		}
	}
</script>

<style lang="scss" scoped>
.user{
	padding: 0 30rpx;
	margin: 40rpx 0;
	.user-top{
		font-weight: bold;
		font-size: 22px;
		margin-bottom: 10rpx;
	}
	.user-content{
		.user-item{
			display: flex;
			align-items: center;
			height: 110rpx;
			.user-avatar{
				width: 80rpx;
				height: 80rpx;
				border-radius: 8px;
				margin-right: 30rpx;
			}
			.user-name{
				width: 420rpx;
				white-space: nowrap;
				overflow: hidden;
				font-size: 18px;
				margin-right: 30rpx;
			}
			.user-button{
				width: 120rpx;
				height: 48rpx;
				line-height: 48rpx;
				text-align: center;
				background-color: $theme-color;
				border-radius: 30px;
				font-size: 12px;
				color: #fff;
			}
			.add-friend{
				background-color: rgb(255,228,49);
				color: #000;
			}
		}
	}
}
.empty{
	text-align: center;
	color: #888;
	margin-top: 100rpx;
}
</style>
