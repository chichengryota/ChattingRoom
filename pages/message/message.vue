<template>
	<view>
		<view class="top">
			<image :src="bgImg" mode="" class="bg-img"></image>
			<u-icon name="plus-circle" color="#fff" size="60" class="upload-icon" @click="show = true"></u-icon>
			<image :src="avatar" mode="" class="avatar-img" @click="previewImage"></image>
			<text class="nickname">{{ name }}</text>
		</view>
		<view class="content">
			<view class="content-top">
				<u-tabs-swiper ref="uTabs" :list="list" :current="current" @change="tabsChange" :is-scroll="false" bar-width="70"
				 active-color="rgb(133, 203, 248)"></u-tabs-swiper>
			</view>
			<swiper class="message" :current="swiperCurrent" @transition="transition" @animationfinish="animationfinish">
				<swiper-item v-for="(item, index) in messageData" :key="index">
					<scroll-view scroll-y class="message-content" @scrolltolower="onreachBottom">
						<view class="message-item" v-for="(item1, index1) in item" :key="index1" @click="goMessageDetail(item1)">
							<chat-message-item :messageData="item1" :avatar="avatar" @change-follow="changeFollow(index, $event)"></chat-message-item>
						</view>
					</scroll-view>
				</swiper-item>
			</swiper>
		</view>
		<u-popup v-model="show" mode="top" border-radius="8" height="1000rpx">
			<view class="submit-popup">
				<view class="input-content">
					<view class="input-content-title">发布文字</view>
					<textarea v-model="inputVal" placeholder="记录此刻心情" class="input" />
					<view class="upload-content-title">上传图片(最多6张)</view>
				</view>
					<u-upload :action="action" :file-list="fileList" max-count="6" width="160" height="160"></u-upload>
				<button type="default" class="submit-button">发表</button>
			</view>
		</u-popup>
	</view>
</template>

<script>
export default {
	data() {
		return {
			bgImg: '',
			avatar: '',
			name: '',
			// tab栏数据
			list: [
				{
					name: '热门'
				},
				{
					name: '关注'
				}
			],
			// 因为内部的滑动机制限制，请将tabs组件和swiper组件的current用不同变量赋值
			current: 0, // tabs组件的current值，表示当前活动的tab选项
			swiperCurrent: 0, // swiper组件的current值，表示当前那个swiper-item是活动的
			// 全部留言数据
			messageData: [
				[
					{
						id: 1,
						avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg',
						name: '阿华',
						time: 1614689655857,
						isFollow: 0,
						message: '阿达所得税法法撒飒飒发傻舒服舒服飒飒哈哈哈哈哈啊哈哈',
						img: [
							'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg',
							'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg',
							'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg'
						],
						comment: 5,
						like: 10,
						isLike: 1
					},
					{
						id: 2,
						avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg',
						name: '阿华',
						time: 1614689655857,
						isFollow: 1,
						message: '阿达所得税法法撒飒飒发傻舒服舒服飒飒哈哈哈哈哈啊哈哈',
						img: ['http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg', 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg'],
						comment: 5,
						like: 10,
						isLike: 0
					}
				],
				[
					{
						id: 1,
						avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg',
						name: '阿华',
						time: 1614689655857,
						isFollow: 0,
						message: '阿达所得税法法撒飒飒发傻舒服舒服飒飒哈哈哈哈哈啊哈哈',
						img: ['http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg', 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg'],
						comment: 5,
						like: 10,
						isLike: 0
					},
					{
						id: 2,
						avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg',
						name: '阿华',
						time: 1614689655857,
						isFollow: 0,
						message: '阿达所得税法法撒飒飒发傻舒服舒服飒飒哈哈哈哈哈啊哈哈',
						img: ['http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg', 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg'],
						comment: 5,
						like: 10,
						isLike: 0
					}
				]
			],
			show: false,
			inputVal: '',
			action: 'http://www.example.com/upload',
			fileList: []
		};
	},
	onLoad() {
			const tokenStr = uni.getStorageSync('token');
			if (tokenStr) {
				let userInfo = uni.getStorageSync("userInfo");
				this.avatar = userInfo.avatar;
				this.bgImg = userInfo.avatar;
				this.name = userInfo.username;
			}
		},
	methods: {
		// tabs通知swiper切换
		tabsChange(index) {
			this.swiperCurrent = index;
		},
		// swiper-item左右移动，通知tabs的滑块跟随移动
		transition(e) {
			let dx = e.detail.dx;
			this.$refs.uTabs.setDx(dx);
		},
		// 由于swiper的内部机制问题，快速切换swiper不会触发dx的连续变化，需要在结束时重置状态
		// swiper滑动结束，分别设置tabs和swiper的状态
		animationfinish(e) {
			let current = e.detail.current;
			this.$refs.uTabs.setFinishCurrent(current);
			this.swiperCurrent = current;
			this.current = current;
		},
		// scroll-view到底部加载更多
		onreachBottom() {},
		// 更改关注状态
		changeFollow(index, id) {
			this.messageData[index].forEach(val => {
				if (val.id == id) {
					val.isFollow = !val.isFollow;
				}
			});
		},
		goMessageDetail(item) {
			uni.$u.route('/pages/messageDetail/messageDetail', { data: JSON.stringify(item) });
		},
		// 图片预览
		previewImage(){
			uni.previewImage({urls: [this.avatar]})
		}
	}
};
</script>

<style lang="scss" scoped>
.top {
	position: relative;
	width: 100%;
	height: 500rpx;
	.bg-img {
		height: 400rpx;
		overflow: hidden;
		position: absolute;
		width: 100%;
	}
	.upload-icon {
		position: absolute;
		top: 20rpx;
		right: 30rpx;
	}
	.avatar-img {
		position: absolute;
		width: 130rpx;
		height: 130rpx;
		border-radius: 5px;
		bottom: 40rpx;
		right: 30rpx;
		z-index: 99;
	}
	.nickname {
		position: absolute;
		bottom: 50rpx;
		right: 180rpx;
		font-size: 14px;
		font-weight: bold;
	}
}
.content {
	.content-top {
		width: 250rpx;
		margin-left: 20rpx;
	}
}
.message {
	min-height: 58vh;
	.message-content {
		width: 100%;
		height: 100%;
	}
}
.message-item {
	margin-bottom: 20rpx;
	background-color: #fff;
	padding: 0 30rpx;
	padding-top: 20rpx;
	display: flex;
	flex-direction: column;
}
.submit-popup{
	padding: 30rpx;
	.input-content{
		display: flex;
		flex-direction: column;
		align-items: center;
		.input-content-title{
			font-weight: bold;
			margin-bottom: 30rpx;
		}
		.input{
			background-color: #eee;
			padding: 10rpx 20rpx;
			border-radius: 5px;
			height: 300rpx;
			overflow: auto;
			width: 640rpx;
		}
		.upload-content-title{
			font-weight: bold;
			margin: 30rpx 0;
		}
	}
.submit-button{
	position: absolute;
	bottom: 50rpx;
	right: 50rpx;
	width: 140rpx;
	height: 64rpx;
	line-height: 64rpx;
	font-size: 16px;
	color: #fff;
	background-color: $theme-color;
	&:after{
		border: none;
	}
}
}
</style>
