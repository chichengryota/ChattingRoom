<template>
	<view class="my">
		<view class="top" @click="goPerson">
				<image :src="avatar" class="top-img"></image>
			<view class="top-main">
				<view class="top-name">
					{{nickname}}
				</view>
				<view class="top-remark">
					简介：{{remark}}
				</view>
			</view>
			<view class="top-right">
				<u-icon name="arrow-right" size="30" color="#888" class="arrow-right"></u-icon>
			</view>
		</view>
		<view class="follow-fans">
			<view class="follow-fans-item">
				<text>{{messageNum}}</text>
				<text>动态</text>
			</view>
			<view class="follow-fans-item">
				<text>{{followNum}}</text>
				<text>关注</text>
			</view>
			<view class="follow-fans-item">
				<text>{{fansNum}}</text>
				<text>粉丝</text>
			</view>
		</view>
		<view class="setting" @click="goAccount">
			<image src="../../static/image/set.png" mode="" class="setting-img"></image>
			<text class="setting-text">账号与安全</text>
			<view class="setting-right">
				<u-icon name="arrow-right" size="30" color="#888" class="arrow-right"></u-icon>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				avatar: '',
				nickname: '',
				remark: '哈哈啊哈哈哈哈哈哈哈哈哈哈哈',
				messageNum: 12,
				followNum: 23,
				fansNum: 3
			};
		},
		onLoad() {
			const tokenStr = uni.getStorageSync('token');
			if (tokenStr) {
				let userInfo = uni.getStorageSync("userInfo");
				this.avatar = userInfo.avatar;
				this.nickname = userInfo.username;
				this.remark = userInfo.signature;
			}else{
				uni.navigateTo({
					url:'../login/login'
				})
			}
		},
		methods:{
			goPerson(){
				uni.navigateTo({
					url:'../person/person'
				})
			},
			goAccount(){
				uni.navigateTo({
					url:'../account/account'
				})
			}
		}
	}
</script>

<style lang="scss" scoped>
.my{
	background-color: #eee;
	min-height: 100vh;
}
.top{
		width: 100%;
		height: 230rpx;
		background-color: #fff;
		box-sizing: border-box;
		display: flex;
		align-items: center;
		justify-content: space-between;
			.top-img{
				width: 120rpx;
				height: 120rpx;
				border-radius: 8px;
				margin-left: 40rpx;
			}
		.top-main{
			width: 450rpx;
			height: 100rpx;
			display: flex;
			flex-direction: column;
			justify-content: space-between;
			white-space: nowrap;
			.top-name{
				font-weight: bold;
			}
			.top-remark{
				width: 430rpx;
				overflow: hidden;
				font-size: 12px;
			}
		}
		.top-right{
			width: 80rpx;
			text-align: center;
		}
	}
	.follow-fans{
		display: flex;
		justify-content: space-around;
		align-items: center;
		border-top: 1px solid #ddd;
		background-color: #fff;
		height: 100rpx;
		font-size: 12px;
		.follow-fans-item{
			width: 100%;
			display: flex;
			flex-direction: column;
			align-items: center;
		}
	}
	.setting{
		margin-top: 30rpx;
		height: 100rpx;
		background-color: #fff;
		display: flex;
		align-items: center;
		.setting-img{
			width: 50rpx;
			height: 50rpx;
			margin-left: 40rpx;
			margin-right: 30rpx;
		}
		.setting-text{
			width: 550rpx;
			line-height: 100rpx;
			font-size: 14px;
		}
		.setting-right{
			width: 80rpx;
			text-align: center;
		}
	}
</style>
