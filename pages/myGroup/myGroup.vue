<template>
	<view>
		<navbar :type="2" title="我的群聊"></navbar>
		<view class="group-content">
			<view class="group-content-top">点击加入群聊</view>
			<view class="group-item" v-for="(item, index) in groupList" :key="index" @click="goChat(item.id)">
				<view class="group-item-left"><image :src="item.avatar" class="group-item-img"></image></view>
				<view class="group-item-main">{{ item.name }}</view>
			</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			groupList: [
				{
					id: 1,
					avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg',
					name: '未达完'
				},
				{
					id: 5,
					avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg',
					name: '梵蒂冈'
				},
				{
					id: 6,
					avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg',
					name: '萨达'
				}
			]
		};
	},
	methods: {
		goChat(id){
			uni.$u.route('/pages/chat/chat', { id: id });
		}
	}
};
</script>

<style lang="scss" scoped>
.group-content-top {
	padding: 14rpx 30rpx;
	font-size: 12px;
	background-color: #eee;
}
.group-item {
	width: 100%;
	height: 120rpx;
	padding: 0 30rpx;
	box-sizing: border-box;
	display: flex;
	align-items: center;
	border-bottom: 1px solid #eee;
	.group-item-left {
		.group-item-img {
			width: 90rpx;
			height: 90rpx;
			border-radius: 6px;
			margin-right: 40rpx;
		}
	}
	.group-item-main {
		white-space: nowrap;
		overflow: hidden;
		font-size: 15px;
		font-weight: bold;
	}
}
</style>
