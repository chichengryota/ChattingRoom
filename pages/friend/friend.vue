<template>
	<view>
		<navbar :type="1" title="通讯录"></navbar>
		<scroll-view class="friend-content">
			<view class="group group-friend" @click="goNewFriend">
				<image src="../../static/image/new-firend.png" mode="" class="group-img"></image>
				<text class="group-name">新的朋友</text>
				<view class="friend-count" v-if="applyList.length!==0">{{ applyList.length }}</view>
			</view>
			<view class="group" @click="goMyGroup">
				<image src="../../static/image/my-group.png" mode="" class="group-img2"></image>
				<text class="group-name">我的群聊</text>
			</view>
			<u-index-list :scrollTop="scrollTop" :index-list="indexList">
					<view v-for="(item, index) in friendList" :key="index">
						<u-index-anchor :index="item.letter" />
						<view class="cell-content" v-for="(item1, index1) in item.data" :key="index1" @click="goFriendDetail(item1.id)">
							<image :src="item1.avatar" mode="" class="cell-img"></image>
							<text class="cell-name">{{ item1.username }}</text>
						</view>
					</view>
			</u-index-list>
		</scroll-view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				scrollTop: 0,
				indexList: [],
				friendList: [],
				applyList: [],
				uid: null
			};
		},
		onLoad() {
			const tokenStr = uni.getStorageSync('token');
			if (tokenStr) {
				let userInfo = uni.getStorageSync("userInfo");
				this.uid = userInfo.id;
				this.getFriendList();
				this.getApplyNum();
			}
		},
		onShow() {
			this.getFriendList();
			this.getApplyNum();
		},
		onPageScroll(e) {
			this.scrollTop = e.scrollTop;
		},
		methods: {
			// 获取好友列表
			async getFriendList() {
				const res = await this.$http({
					url: '/friend/list',
					method: 'POST',
					data: {
						uid: this.uid
					}
				});
				if (res.code === 200) {
					res.data.sort((a, b) => {
						let a1 = a.letter.toLowerCase();
						let b1 = b.letter.toLowerCase();
						if (a1 < b1) return -1;
						if (a1 > b1) return 1;
						return 0;
					})
					this.indexList = [];
					res.data.forEach(val=>{
						this.indexList.push(val.letter);
					})
					this.friendList = res.data;
				}
			},
			// 获取好友请求数量
			async getApplyNum() {
				const res = await this.$http({
					url: '/friend/apply/num',
					method: 'POST',
					data: {
						uid: this.uid
					}
				});
				if (res.code === 200) {
					this.applyList = res.data
				}
			},
			goFriendDetail(id) {
				uni.$u.route('/pages/friendDetail/friendDetail', {
					id: id
				});
			},
			goNewFriend() {
				uni.$u.route('/pages/newFriend/newFriend');
			},
			goMyGroup() {
				uni.$u.route('/pages/myGroup/myGroup');
			}
		}
	};
</script>

<style lang="scss" scoped>
	.friend-content {
		.group {
			display: flex;
			align-items: center;
			height: 110rpx;
			padding: 0 26rpx;

			.group-img {
				width: 54rpx;
				height: 54rpx;
				padding-left: 14rpx;
				margin-right: 32rpx;
			}

			.group-img2 {
				width: 60rpx;
				height: 60rpx;
				margin-right: 30rpx;
				padding-left: 10rpx;
			}

			.group-name {
				font-weight: bold;
				font-size: 14px;
			}
		}

		.group-friend {
			position: relative;

			.friend-count {
				position: absolute;
				top: 50%;
				transform: translateY(-50%);
				right: 40rpx;
				width: 40rpx;
				height: 40rpx;
				line-height: 40rpx;
				border-radius: 50%;
				background-color: red;
				color: #fff;
				font-size: 12px;
				text-align: center;
			}
		}

		.cell-content {
			display: flex;
			align-items: center;
			height: 110rpx;
			padding: 0 26rpx;

			.cell-img {
				width: 80rpx;
				height: 80rpx;
				border-radius: 5px;
				margin-right: 20rpx;
			}

			.cell-name {
				font-weight: bold;
			}
		}
	}
</style>
