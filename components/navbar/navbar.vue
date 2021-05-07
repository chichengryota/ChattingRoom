<template>
	<view>
		<view :style="{ background: background }" class="custom-header-container" :class="isFixed?'fixed':''">
			<!-- 导航栏距顶部距离 -->
			<view :style="{ height: getStausBarHeight + 'px' }" class="custom-header-status-bar"></view>
			<!-- 第1类导航栏 -->
			<view :class="{ 'ios-center': isIos }" class="custom-header-top-container" v-if="type==1">
				<view :class="{ isIos: isIos }" class="custom-header-left">
					<image :src="avatar" class="left-avatar" @click="goMy"></image>
				</view>
				<view :style="{ color: color }" :class="{ 'ios-center': isIos }" class="custom-header-title">{{ title }}</view>
				<view :class="{ isIos: isIos }" class="custom-header-right">
					<image src="../../static/image/search.png" mode="widthFix" class="custom-header-right-img" @click="goSearch"></image>
					<image src="../../static/image/add.png" mode="widthFix" class="custom-header-right-img right-img" @click="goAddGroup"></image>
				</view>
			</view>
			<!-- 第2类导航栏 -->
			<view :class="{ 'ios-center': isIos }" class="custom-header-top-container" v-if="type==2">
				<view :class="{ isIos: isIos }" class="custom-header-left" v-if="showBack">
					<image src="../../static/image/back.png" mode="widthFix" class="custom-header-left-img" @tap="backTap"></image>
				</view>
				<view :style="{ color: color }" :class="{ 'ios-center': isIos }" class="custom-header-title" v-if="title">{{ title }}</view>
				<view :class="{ isIos: isIos }" class="custom-header-right" v-if="showMenu" @click="clickMenu">
					<image src="../../static/image/menu.png" mode="widthFix" class="custom-header-right-img"></image>
				</view>
			</view>
			<!-- 第3类导航栏 -->
			<view :class="{ 'ios-center': isIos }" class="custom-header-top-container" v-if="type==3">
				<view :class="{ isIos: isIos }" class="custom-header-left" @tap="backTap">取消</view>
				<view :style="{ color: color }" :class="{ 'ios-center': isIos }" class="custom-header-title" v-if="title">{{ title }}</view>
				<view :class="{ isIos: isIos }" class="custom-header-right confirm" v-if="showConfirm">确定</view>
			</view>
			<!-- 第4类导航栏 -->
			<view v-if="type==4" :class="{ 'ios-center': isIos }" class="custom-header-top-container">
				<u-search placeholder="" v-model="searchInp" @change="inputChange" shape="square" action-text="取消" @custom="cancel"></u-search>
			</view>
		</view>
		<!-- 导航栏固定后占位元素 -->
		<view :style="{ height: getStausBarHeight + (isIos ? 45 : 48) + 'px' }" class="custom-header-height" v-if="isFixed"></view>
	</view>
</template>
<script>
	import commonJs from "../../static/js/common.js"
	export default {
		name: 'Navbar',
		props: {
			title: {
				type: String,
				default: ''
			},
			background: {
				type: String,
				default: '#fff'
			},
			color: {
				type: String,
				default: '#000'
			},
			// 是否显示返回按钮
			showBack: {
				type: Boolean,
				default: true
			},
			showMenu: {
				type: Boolean,
				default: false
			},
			showConfirm: {
				type: Boolean,
				default: true
			},
			// 导航栏类别，1是首页，2是聊天页，3是创建群聊页，4是搜索页
			type: {
				type: Number,
				default: 1
			},
			// 导航栏是否固定
			isFixed: {
				type: Boolean,
				default: true
			}
		},
		data() {
			return {
				avatar: '',
				searchInp: ''
			}
		},
		computed: {
			// 获取导航栏距顶部高度
			getStausBarHeight() {
				try {
					const res = uni.getSystemInfoSync();
					return res.statusBarHeight;
				} catch (e) {}
			},
			// 判断是否为ios机型
			isIos() {
				return uni.getSystemInfoSync().system.indexOf('iOS') > -1;
			}
		},
		created() {
			const tokenStr = uni.getStorageSync('token');
			if (tokenStr) {
				let userInfo = uni.getStorageSync("userInfo");
				this.avatar = userInfo.avatar;
			}
		},
		methods: {
			backTap() {
				uni.navigateBack({
					delta: 1,
					fail: () => {
						uni.switchTab({
							url: '/pages/index/index'
						});
					}
				});
			},
			goSearch() {
				uni.navigateTo({
					url: '/pages/search/search'
				})
			},
			goAddGroup() {
				uni.navigateTo({
					url: '/pages/addGroup/addGroup'
				})
			},
			cancel() {
				uni.navigateBack({
					delta: 1,
					fail: () => {
						uni.switchTab({
							url: '/pages/index/index'
						});
					}
				});
			},
			goMy() {
				uni.switchTab({
					url: '/pages/my/my'
				})
			},
			// 点击菜单
			clickMenu() {
				this.$emit('clickMenu')
			},
			// 搜索
			inputChange: commonJs.fnDebounce(function() {
				this.$emit('change', this.searchInp)
			}, 1000)
		}
	};
</script>
<style scoped lang="scss">
	.custom-header-top-container {
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 0 30rpx;
		position: relative;
		height: 48px;

		&.ios-center {
			height: 45px;
		}
	}

	.custom-header-container {
		z-index: 9;
		width: 100%;
		border-bottom: 1px solid #ddd;
	}

	.fixed {
		position: fixed;
		top: 0;
	}

	.custom-header-left {
		display: flex;
		align-items: center;

		.left-avatar {
			width: 70rpx;
			height: 70rpx;
			border-radius: 5px;
		}

		.custom-header-left-img {
			width: 40rpx;
		}
	}

	.custom-header-title {
		height: 48px;
		line-height: 48px;
		font-size: 18px;
		font-weight: bold;
		position: absolute;
		left: 50%;
		transform: translateX(-50%);

		&.ios-center {
			line-height: 45px;
			height: 45px;
		}
	}

	.custom-header-right {
		display: flex;
		align-items: center;

		.right-img {
			margin-left: 30rpx;
		}

		.custom-header-right-img {
			width: 42rpx;
		}
	}

	.confirm {
		color: $theme-color;
	}
</style>
